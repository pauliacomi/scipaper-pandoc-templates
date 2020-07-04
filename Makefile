set path=%path:git\bin=;%
set path=%path:mingw64\bin=;%
set path=%path:mingw-64\bin=;%
set path=%path:usr\bin=;%

ARTICLE_FILE        = text/cuk1.md
GIT_PATH            = C:/users/pauli/git

CUSTOM_TEMPLATE_PATH    = $(GIT_PATH)/pandoc-templates
TEMPLATE_FILE_HTML      = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.html
TEMPLATE_STYLE_HTML     = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.css
DOCX_REFERENCE_FILE     = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.docx
PANDOC_SCHOLAR_PATH     = $(GIT_PATH)/pandoc-scholar

PANDOC_LATEX_OPTIONS  = --pdf-engine=xelatex
PANDOC_LATEX_OPTIONS += --filter=pandoc-citeproc

PANDOC_HTML_OPTIONS   = --toc --self-contained
PANDOC_EPUB_OPTIONS   = --toc

DEFAULT_EXTENSIONS    ?= html

include $(PANDOC_SCHOLAR_PATH)/Makefile

# Must be prepended to the options, as has to come before citeproc
PANDOC_WRITER_OPTIONS := --filter=pandoc-xnos $(PANDOC_WRITER_OPTIONS)