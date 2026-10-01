"""Freeze a reviewed task's explicitly listed inputs into a verified local ZIP.

Run from the formal project. Uses only the Python standard library; never sends
files, modifies Lean sources, fetches dependencies, or overwrites a delivery.
"""

import argparse
import csv
import hashlib
import io
import json
from pathlib import Path, PurePosixPath
import re
import subprocess
from datetime import datetime, timezone, timedelta
import zipfile


PROJECT = Path(__file__).resolve().parents[1]
WORKSPACE = PROJECT.parent
BLOCKED = {".git", ".lake", ".codex", ".agents", ".aws", ".mathcopilot"}


def within(path, root):
    return path == root or root in path.parents


def digest(data):
    return hashlib.sha256(data).hexdigest()


def git(*args):
    return subprocess.check_output(
        ["git", "-c", f"safe.directory={PROJECT.as_posix()}", *args],
        cwd=PROJECT,
    ).decode("utf-8").strip()


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def json_bytes(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + "\n").encode("utf-8")


def csv_bytes(rows, fields):
    out = io.StringIO(newline="")
    writer = csv.DictWriter(out, fieldnames=fields, lineterminator="\n")
    writer.writeheader()
    writer.writerows(rows)
    return out.getvalue().encode("utf-8")


def source_path(relative):
    supplied = PurePosixPath(relative)
    if supplied.is_absolute() or "\\" in relative or ":" in relative:
        raise ValueError(f"Source must be a relative forward-slash path: {relative}")
    resolved = (PROJECT / relative).resolve()
    if not within(resolved, WORKSPACE) or any(p in BLOCKED for p in resolved.parts):
        raise ValueError(f"Source outside allowed task inputs: {relative}")
    if resolved.name.startswith(".env") or not resolved.is_file():
        raise ValueError(f"Missing or excluded input: {relative}")
    return resolved


def origin(path, head):
    if not within(path, PROJECT):
        return "workspace_page_attachment"
    relative = path.relative_to(PROJECT).as_posix()
    if not git("ls-files", "--", relative):
        return "local_uncommitted_input"
    actual = git("hash-object", "--", relative)
    expected = git("rev-parse", f"{head}:{relative}")
    if actual != expected:
        raise ValueError(f"Tracked input differs from required HEAD: {relative}")
    return "committed_HEAD"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--refresh-input-manifest", action="store_true")
    args = parser.parse_args()
    if Path.cwd().resolve() != PROJECT:
        raise ValueError("Run this command from the formal project root.")
    config = read_json(source_path(args.config))
    packet_id = config["packet_id"]
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9_-]{0,95}", packet_id):
        raise ValueError("Packet ID must be a short path-safe identifier.")
    output = (PROJECT / args.output).resolve()
    if not within(output, WORKSPACE) or output == WORKSPACE or within(output, PROJECT):
        raise ValueError("Delivery must be a new directory outside the repo, inside the workspace.")
    if any(part in BLOCKED for part in output.parts) or output.exists():
        raise ValueError(f"Excluded or existing output directory; use a new packet revision: {output}")

    head = git("rev-parse", "HEAD")
    branch = git("branch", "--show-current")
    if (head, branch) != (config["required_head"], config["required_branch"]):
        raise ValueError("Actual branch/HEAD differs from the reviewed packet baseline.")
    lean_pin = (PROJECT / "lean-toolchain").read_text(encoding="utf-8").strip()
    lake_manifest = read_json(PROJECT / "lake-manifest.json")
    mathlib_rev = next(p["rev"] for p in lake_manifest["packages"] if p["name"] == "mathlib")
    if (lean_pin, mathlib_rev) != (config["lean_toolchain"], config["mathlib_revision"]):
        raise ValueError("Toolchain or mathlib lock differs from the reviewed configuration.")

    with source_path(config["file_list"]).open(encoding="utf-8-sig", newline="") as inp:
        files = list(csv.DictReader(inp))
    if not files:
        raise ValueError("Input file list is empty.")
    reserved = {"START_HERE.zh-CN.md", "PACKET_METADATA.json", "PACKET_MANIFEST.csv"}
    seen = set()
    for row in files:
        name = row["bundle_path"]
        member = PurePosixPath(name)
        if (member.is_absolute() or ".." in member.parts or "\\" in name
                or ":" in name or member.as_posix() != name or name.casefold() in seen
                or name in reserved or any(p in BLOCKED for p in member.parts)):
            raise ValueError(f"Unsafe or duplicate archive member: {name}")
        seen.add(name.casefold())
        row["resolved"] = source_path(row["source_path"])
        row["origin"] = origin(row["resolved"], head)
    member_names = {row["bundle_path"] for row in files}
    required = [config["entry_file"], config["prompt_file"]]
    required += [page["path"] for page in config.get("textbook_pages", [])]
    if not set(required).issubset(member_names):
        raise ValueError("File list omits an entry, prompt, or required textbook page.")

    reference = source_path(config["input_manifest"])
    if not within(reference, PROJECT):
        raise ValueError("Reference manifest must be inside the formal project.")
    with reference.open(encoding="utf-8-sig", newline="") as inp:
        reference_rows = list(csv.DictReader(inp))
    supplied_sources = {row["resolved"] for row in files}
    for row in reference_rows:
        path = source_path(row["relative_path"])
        if path not in supplied_sources or row["base_commit"] != head:
            raise ValueError("Reference manifest input is missing or uses a different HEAD.")
        row["origin"] = origin(path, head)
        actual = digest(path.read_bytes())
        if not args.refresh_input_manifest and actual != row["sha256"]:
            raise ValueError(f"Stale input hash: {row['relative_path']}; refresh before freezing.")
        row["sha256"] = actual
    if args.refresh_input_manifest:
        reference.write_bytes(csv_bytes(reference_rows, list(reference_rows[0])))

    payload = {}
    records = []
    for row in files:
        data = row["resolved"].read_bytes()
        payload[row["bundle_path"]] = data
        records.append({"bundle_path": row["bundle_path"], "sha256": digest(data),
                        "bytes": len(data), "origin": row["origin"],
                        "base_commit": head, "purpose": row["purpose"]})
    start = (
        f"# MathCopilot 任务包：{packet_id}\n\n"
        f"阶段：{config['stage']}；{config['stage_summary']}。\n\n"
        f"1. 阅读 `{config['entry_file']}`，核对 PACKET_METADATA.json 与输入清单。\n"
        f"2. 将 `{config['prompt_file']}` 的完整代码块复制到目标项目新 Task，选择 {config['primary_skill']}。\n"
        "3. 随任务提供本 ZIP；附件快照位于 project/，原页位于 textbook/。\n"
        "   在隔离附件目录展开，不直接覆盖当前项目；不混用后来更新的输入。\n"
        f"4. 返回报告保存到 {config['return_directory']}，使用包内模板。\n"
        "   回填包 ID、PACKET_MANIFEST.csv 的 SHA-256、实际版本和输出文件哈希。\n"
        "5. 若网站不能读取 ZIP，改提供其中同一快照的文件，并报告缺项。\n\n"
        f"输入 HEAD：{head}；分支：{branch}。\n"
        "该包由本地生成和校验，尚未上传或发送网站任务；本次打包不新增教材证明。\n"
    ).encode("utf-8")
    payload["START_HERE.zh-CN.md"] = start
    records.append({"bundle_path": "START_HERE.zh-CN.md", "sha256": digest(start),
                    "bytes": len(start), "origin": "generated_packet_entry",
                    "base_commit": head, "purpose": "start instructions"})
    manifest = csv_bytes(records, list(records[0]))
    metadata = json_bytes({"schema_version": "1.0", "packet_id": packet_id,
        "task_id": config["task_id"], "stage": config["stage"],
        "created_at": datetime.now(timezone(timedelta(hours=8))).isoformat(timespec="seconds"),
        "timezone": "Asia/Shanghai", "branch": branch, "head": head,
        "lean_toolchain": lean_pin, "mathlib_revision": mathlib_rev,
        "textbook_sha256": config.get("textbook_sha256"),
        "textbook_pages": config.get("textbook_pages", []),
        "skills_confirmation": config.get("skills_confirmation"),
        "input_manifest_sha256": digest(manifest), "manifest_file_count": len(records),
        "includes_local_uncommitted_inputs": True,
        "new_textbook_proofs_completed": False, "website_task_sent": False,
        "validation_scope": "input identity and archive integrity; no new Lean proof/build"})
    payload["PACKET_MANIFEST.csv"] = manifest
    payload["PACKET_METADATA.json"] = metadata
    output.mkdir(parents=True, exist_ok=False)
    archive = output / f"{packet_id}.zip"
    with zipfile.ZipFile(archive, "x", compression=zipfile.ZIP_DEFLATED) as zipped:
        for name, data in payload.items():
            zipped.writestr(name, data)
    with zipfile.ZipFile(archive) as zipped:
        if zipped.testzip() or set(zipped.namelist()) != set(payload):
            raise ValueError("Archive CRC or member-set check failed.")
        for name, expected in payload.items():
            if zipped.read(name) != expected:
                raise ValueError(f"Archive bytes differ: {name}")
        for row in records:
            if digest(zipped.read(row["bundle_path"])) != row["sha256"]:
                raise ValueError(f"Archive hash differs: {row['bundle_path']}")
    for name, data in {"START_HERE.zh-CN.md": start, "PACKET_MANIFEST.csv": manifest,
                       "PACKET_METADATA.json": metadata}.items():
        (output / name).write_bytes(data)
    archive_hash = digest(archive.read_bytes())
    (output / "SHA256SUMS.txt").write_text(
        f"{archive_hash}  {archive.name}\n{digest(manifest)}  PACKET_MANIFEST.csv\n"
        f"{digest(metadata)}  PACKET_METADATA.json\n{digest(start)}  START_HERE.zh-CN.md\n",
        encoding="utf-8", newline="\n")
    report = {"packet_id": packet_id, "archive": archive.name,
        "archive_sha256": archive_hash, "archive_members": len(payload),
        "manifest_records": len(records), "reference_inputs": len(reference_rows),
        "crc": "passed", "all_member_bytes": "passed", "all_sha256": "passed",
        "source_branch_and_head": "matched", "pinned_dependencies": "matched",
        "new_lean_build": "not_run", "new_proofs": "not_started"}
    (output / "VERIFICATION_REPORT.json").write_bytes(json_bytes(report))
    print(json.dumps({"output": str(output), **report}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, OSError, subprocess.CalledProcessError) as exc:
        raise SystemExit(f"Task packet creation failed: {exc}")
