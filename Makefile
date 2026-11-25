# STI2D SIN – course website and Canoprof archives
#
#   make install    create the Python venv with MkDocs and md2canoprof
#   make serve      live preview on http://127.0.0.1:8000
#   make build      build the site in site/ (fails on broken links)
#   make scar       every lesson -> build/scar/**/*.scar (FILTER=02_cour_info for one theme)
#   make check      verify the generated archives against Canoprof's structure
#   make figures    KiCad / Fritzing sources -> clean SVG (SRC=... OUT=...)
#   make clean      remove generated files

VENV   ?= $(HOME)/.venv/md2canoprof
BIN    := $(VENV)/bin
FILTER ?=
SRC    ?= sources
OUT    ?= docs/img

export NO_MKDOCS_2_WARNING := 1

.PHONY: install serve build scar check figures clean

install:
	test -d $(VENV) || python3 -m venv $(VENV)
	$(BIN)/pip install -q --upgrade -r requirements.txt

serve:
	$(BIN)/mkdocs serve

build:
	$(BIN)/mkdocs build --strict

scar:
	PATH="$(BIN):$$PATH" tools/build_scar.sh docs build/scar "$(FILTER)"

check: scar
	find build/scar -name '*.scar' -print0 | xargs -0 $(BIN)/canoprof-check

figures:
	$(BIN)/export_figures.sh "$(SRC)" "$(OUT)"

clean:
	rm -rf site build
