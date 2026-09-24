#!/usr/bin/env python3
"""Apply config.yaml theme to resume.html, writing a themed temp file."""
import re
import sys
import yaml

def main():
    # Args: [base] [config] -> reads <base>.html + <config>, writes .<base>_themed.html
    base = sys.argv[1] if len(sys.argv) > 1 else "resume"
    config_path = sys.argv[2] if len(sys.argv) > 2 else "config.yaml"
    INPUT = f"{base}.html"
    OUTPUT = f".{base}_themed.html"

    with open(config_path) as f:
        config = yaml.safe_load(f)

    theme = config["theme"]

    # Build the @import and :root block
    font_import = f"  @import url('{theme['font_import']}');"
    root_lines = [
        f"    --bg: {theme['bg']};",
        f"    --text: {theme['text']};",
        f"    --muted: {theme['muted']};",
        f"    --accent: {theme['accent']};",
        f"    --border: {theme['border']};",
        f"    --code-bg: {theme['code_bg']};",
        f"    --bright: {theme['bright']};",
        f"    --font: {theme['font']};",
    ]
    root_block = "  :root {\n" + "\n".join(root_lines) + "\n  }"

    with open(INPUT) as f:
        html = f.read()

    # Replace @import url(...)
    html = re.sub(
        r"@import url\([^)]+\);",
        f"@import url('{theme['font_import']}');",
        html,
    )

    # Replace :root { ... }
    html = re.sub(
        r":root\s*\{[^}]+\}",
        root_block,
        html,
    )

    # Replace body padding
    html = re.sub(
        r"(body\s*\{[^}]*?)padding:\s*[^;]+;",
        rf"\1padding: {theme['padding']};",
        html,
    )

    with open(OUTPUT, "w") as f:
        f.write(html)

    print(f"Themed: {OUTPUT}")


if __name__ == "__main__":
    main()
