ARTICLE_FILE        = text/article.md
GIT_PATH            = C:/users/pauli/git

CUSTOM_TEMPLATE_PATH    = $(GIT_PATH)/pandoc-templates
CUSTOM_REFERENCE_PATH   = $(CUSTOM_TEMPLATE_PATH)/csl
TEMPLATE_FILE_HTML      = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.html
TEMPLATE_STYLE_HTML     = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.css
DOCX_REFERENCE_FILE     = $(CUSTOM_TEMPLATE_PATH)/templates/paper/template.docx
TEMPLATE_FILE_LATEX     = $(CUSTOM_TEMPLATE_PATH)/templates/paper/latex/manuscript-pandoc.tex
CLASS_FILE_LATEX        = $(CUSTOM_TEMPLATE_PATH)/templates/paper/latex/setting/own/ownarticle
PANDOC_SCHOLAR_PATH     = $(GIT_PATH)/pandoc-scholar

PANDOC_READER_OPTIONS   = --data-dir=$(CUSTOM_TEMPLATE_PATH)
PANDOC_READER_OPTIONS  += --defaults=base


PANDOC_LATEX_OPTIONS    = --pdf-engine=xelatex
PANDOC_LATEX_OPTIONS   += --variable=documentclass:$(CLASS_FILE_LATEX)
# PANDOC_LATEX_OPTIONS   += --natbib
PANDOC_LATEX_OPTIONS   += --filter=pandoc-citeproc

PANDOC_HTML_OPTIONS     = --toc --self-contained
PANDOC_EPUB_OPTIONS     = --toc

DEFAULT_EXTENSIONS    ?= html doc tex pdf

include $(PANDOC_SCHOLAR_PATH)/Makefile

# Must be prepended to the options, as has to come before citeproc
PANDOC_WRITER_OPTIONS := --filter=pandoc-xnos $(PANDOC_WRITER_OPTIONS)
PANDOC_WRITER_OPTIONS += --csl=$(CUSTOM_REFERENCE_PATH)/ieee.csl