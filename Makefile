.PHONY: build open clean test wcag ats \
        build-dsp open-dsp test-dsp ats-dsp wcag-dsp \
        build-light build-dsp-light build-all

# ===== General resume (dark theme) =====
build:
	./build.sh

open: build
	open resume.pdf

test: wcag ats

wcag:
	npx pa11y resume.html

ats: build
	python3 test_ats.py resume.pdf

# ===== DSP-targeted resume (dark theme) =====
build-dsp:
	./build.sh resume_dsp

open-dsp: build-dsp
	open resume_dsp.pdf

test-dsp: wcag-dsp ats-dsp

wcag-dsp:
	npx pa11y resume_dsp.html

ats-dsp: build-dsp
	python3 test_ats.py resume_dsp.pdf

# ===== Printable light theme (white background) =====
build-light:
	./build.sh resume config_light.yaml resume_light

build-dsp-light:
	./build.sh resume_dsp config_light.yaml resume_dsp_light

# Build every variant
build-all: build build-dsp build-light build-dsp-light

clean:
	rm -f resume.pdf resume_dsp.pdf resume_light.pdf resume_dsp_light.pdf
