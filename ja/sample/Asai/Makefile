
Dir ?= /tmp
Tgt = ${Dir}/Asai.pdf

LATEX ?= platex -kanji=euc
include ../../../cmd.mk

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install:
	install -m 444 -pD ${Tgt} ${InstallDir}/source/latex/${Name}/

${Tgt}: $(wildcard *.tex) ${Dir}/familytree.sty
	$(call Latex, a.tex)
	${DVIPDFMX} -o $@ ${Dir}/a.dvi
