
Dir ?= /tmp
Tgt = ${Dir}/Tokugawa.pdf

LATEX ?= platex -kanji=euc
include ../../../cmd.mk

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install:
	install -m 444 -pD ${Tgt} ${InstallDir}/source/latex/${Name}/

${Tgt}: $(wildcard *.tex) ${Dir}/familytree.sty
	$(call Latex, a.tex)
	${DVIPDFMX} -o ${Dir}/a.pdf ${Dir}/a.dvi
	${PDFCROP} ${Dir}/a.pdf $@
