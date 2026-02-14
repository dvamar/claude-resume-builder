.PHONY: build open clean test wcag ats

build:
	./build.sh

open: build
	open resume.pdf

test: wcag ats

wcag:
	npx pa11y resume.html

ats: build
	python3 test_ats.py

clean:
	rm -f resume.pdf
