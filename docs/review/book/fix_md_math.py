"""Instruction 35: mechanical delimiter/layout conversion, never chapter 8.

Run once on a clean baseline; the independent checker verifies preserved bytes.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
FENCE = re.compile(r'(?ms)^([ \t]*)(`{3,}|~{3,})[^\n]*\n.*?^\1\2[^\n]*(?:\n|$)')


def prose(text):
    # Work by contiguous prose segments, preserving fenced and inline code and URLs.
    protected = []
    def keep(m):
        protected.append(m[0])
        return f'\x00KEEP{len(protected)-1}\x00'
    text = re.sub(r'`+[^`\n]*`+|\]\([^\n)]*\)', keep, text)
    def display(m):
        body = re.sub(r'(?m)^\s*> ?', '', m[1])
        body = re.sub(r'\s+', ' ', body).strip()
        start = text.rfind('\n', 0, m.start()) + 1
        prefix = text[start:m.start()]
        if prefix.lstrip().startswith('|'):
            return '$' + body.replace('\\|', '\\Vert ').replace('|', '\\vert ') + '$'
        return '\n\n$$\n' + body + '\n$$\n\n'
    text = re.sub(r'\\\[(.*?)\\\]', display, text, flags=re.S)
    text = re.sub(r'\\\((.*?)\\\)', lambda m: '$'+m[1].strip()+'$', text, flags=re.S)
    # Avoid empty quote-only lines left at the old position of a display.
    text = re.sub(r'(?m)^>\s*\n(?=\n\$\$)', '', text)
    lines = []
    in_display = False
    for line in text.splitlines(keepends=True):
        if line.strip() == '$$':
            in_display = not in_display
        elif not in_display:
            line = re.sub(r'(?<!\$)\$([^$\n]+)\$(?!\$)', lambda m: '$'+m[1].strip()+'$', line)
            if line.lstrip().startswith('|'):
                line = re.sub(r'\$([^$]+)\$', lambda m: '$'+m[1].replace('\\|','\\Vert ').replace('|','\\vert ')+'$', line)
            # Literal identifiers outside math can trigger emphasis; escape only underscores.
            parts = re.split(r'(\$[^$\n]*\$)', line)
            for i in range(0, len(parts), 2):
                if not parts[i].lstrip().startswith('#'):
                    parts[i] = re.sub(r'(?<!\\)(?<=\w)_(?=[\w])', r'\\_', parts[i])
            line = ''.join(parts)
        if line.strip() != '$$':
            # Equation labels remain visible in tables and multi-equation displays.
            # MathJax permits only one tag in a display and none in inline math.
            if in_display and line.count('\\tag{') > 1:
                line = re.sub(r'\\tag\{([^{}]+)\}',r'\\quad\\text{(\1)}',line)
            elif not in_display:
                line = re.sub(r'\$([^$\n]+)\$',lambda m:'$'+re.sub(r'\\tag\{([^{}]+)\}',r'\\quad\\text{(\1)}',m[1])+'$',line)
            line = line.replace('\\daggeru','\\dagger u')
            if line.lstrip().startswith('|'):
                line = re.sub(r'\\{2,}Vert',lambda m:'\\Vert',line)
        lines.append(line)
    text = ''.join(lines)
    for i, original in enumerate(protected):
        text = text.replace(f'\x00KEEP{i}\x00', original)
    return text


def transform(text):
    out = []; pos = 0
    for m in FENCE.finditer(text):
        out += [prose(text[pos:m.start()]), m[0]]; pos = m.end()
    return ''.join(out) + prose(text[pos:])


if __name__ == '__main__':
    for p in sorted((ROOT/'docs/review').rglob('*.md')):
        if p.name.startswith('CH08_') or p.name == 'BOOK_RENDER_FIX.zh-CN.md':
            continue
        raw = p.read_bytes(); old = raw.decode('utf-8-sig')
        # Split/decode without universal newline conversion to preserve fenced bytes.
        new = transform(old)
        if new != old:
            p.write_bytes((b'\xef\xbb\xbf' if raw.startswith(b'\xef\xbb\xbf') else b'') + new.encode('utf-8'))
