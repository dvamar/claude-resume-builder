# Claude Resume Builder

Build a polished, ATS-friendly resume styled to your liking — powered by Claude Code. Ships with a dark terminal theme by default, fully customizable via `config.yaml`.

Clone the repo, fire up `claude`, and have an interactive resume-building experience. Drop in your existing resume as a text file or start from scratch.

## Quick Start

### Prerequisites

- [Google Chrome](https://www.google.com/chrome/) (for headless PDF generation)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- Python 3 with `pyyaml` and `pypdf` (`pip install pyyaml pypdf`)
- Node.js (for `npx pa11y` accessibility testing)

### Build Your Resume

```bash
git clone <this-repo> && cd resume

# Option A: drop in your existing resume
cp ~/path/to/your/resume.txt resume.txt

# Option B: start from scratch — Claude will ask you questions

# Launch Claude Code and let it guide you
claude
```

Claude reads your `resume.txt` (if present), generates a styled `resume.html`, and builds the PDF.

### Commands

```bash
make build   # Apply theme + generate PDF
make test    # Run WCAG + ATS compliance checks
make open    # Build and open the PDF
make clean   # Remove generated files
```

## Customization

Edit `config.yaml` to change the theme:

```yaml
theme:
  bg: "#0d1117"        # background color
  text: "#c9d1d9"      # body text
  muted: "#8b949e"     # secondary text
  accent: "#e66386"    # headings, links, highlights
  border: "#30363d"    # divider lines
  code_bg: "#161b22"   # profile block background
  bright: "#f0f6fc"    # names, job titles
  font: "'JetBrains Mono', ..."
  padding: "0.5in 0.6in"
```

Run `make build` after changing the theme to regenerate the PDF.

## How It Works

1. `apply_theme.py` reads `config.yaml` and injects theme values into a temp copy of `resume.html`
2. `build.sh` runs headless Chrome to convert the themed HTML to PDF
3. `test_ats.py` verifies the PDF is parseable by applicant tracking systems
4. `npx pa11y` checks WCAG accessibility compliance

## Project Structure

```
config.yaml      # Theme customization
CLAUDE.md        # Instructions for Claude Code
apply_theme.py   # Applies config.yaml theme to HTML
build.sh         # Headless Chrome PDF generation
test_ats.py      # ATS parsability tests
Makefile         # Build commands
resume.html      # Your resume (gitignored)
resume.pdf       # Generated PDF (gitignored)
```
