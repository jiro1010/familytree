
Dir ?= /tmp
Tgt = ${Dir}/Asai.pdf

include ../../cmd.mk
include ../common.mk

${Tgt}: $(wildcard *.tex) ${Dir}/familytree.sty
	$(call Latex, a.tex)
	${DVIPDFMX} -o $@ ${Dir}/a.dvi
