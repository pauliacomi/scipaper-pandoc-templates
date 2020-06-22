## Put this Makefile in your project directory---i.e., the directory
## containing the paper you are writing. Assuming you are using the
## rest of the toolchain here, you can use it to create .html, .tex,
## and .pdf output files (complete with bibliography, if present) from
## your markdown file. 
## -	Change the paths at the top of the file as needed.
## -	Using `make` without arguments will generate html, tex, and pdf 
## 	output files from all of the files with the designated markdown
##	extension. The default is `.md` but you can change this. 
## -	You can specify an output format with `make tex`, `make pdf`,  
## - 	`make html`, or `make docx`.
## -	Doing `make clean` will remove all the .tex, .html, .pdf, and .docx files 
## 	in your working directory. Make sure you do not have files in these
##	formats that you want to keep!

## Style of document to generate
STYLE = report

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

## Location of Pandoc support files.
# PREFIX = .
PREFIX = C:/users/pauli/git/pandoc-templates

## Location of your working bibliography file
BIB = ./pandoc.bib

## CSL stylesheet (located in the csl folder of the PREFIX directory).
CSL = apsa

## Pandoc options to use for all document types
OPTIONS = markdown+simple_tables+table_captions+yaml_metadata_block+smart
ARGUMENTS = --data-dir=PREFIX

## Templates
HMTLTEMPLATE = $(PREFIX)/templates/$(STYLE)/template.html
CSSTEMPLATE = $(PREFIX)/templates/$(STYLE)/template.css
DOCXTEMPLATE = $(PREFIX)/templates/$(STYLE)/template.docx
LATEXTEMPLATE = $(PREFIX)/templates/$(STYLE)/template.tex


PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)
DOCX=$(SRC:.md=.docx)

all:	$(PDFS) $(HTML) $(TEX) $(DOCX)

pdf:	$(PDFS)
html:	$(HTML)
tex:	$(TEX)
docx:	$(DOCX)

%.html:	%.md
	pandoc -r $(OPTIONS) -w html --template=$(HMTLTEMPLATE) --css=$(CSSTEMPLATE) --self-contained -o $@ $< 


%.tex:	%.md
	pandoc -r $(OPTIONS) -w latex -s --pdf-engine=pdflatex --template=$(LATEXTEMPLATE) --filter pandoc-citeproc --csl=$(PREFIX)/csl/$(CSL).csl --bibliography=$(BIB) -o $@ $<


%.pdf:	%.md
	pandoc -r $(OPTIONS) -s --pdf-engine=pdflatex --template=$(LATEXTEMPLATE) -o $@ $<


%.docx: %.md
	pandoc -r $(OPTIONS) -w docx --filter pandoc-citeproc -o $@ $<

clean:
ifeq ($(OS),Windows_NT)
	del *.pdf *.tex *.docx *.html
else
	rm -f *.pdf *.tex *.docx *.html
endif
