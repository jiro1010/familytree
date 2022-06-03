
Dir ?= /tmp
Tgt = ${Dir}/Tokugawa.pdf

include ../../cmd.mk
include ../common.mk

${Tgt}: $(wildcard *.tex) ${Dir}/familytree.sty
	$(call Latex, a.tex)
	${DVIPDFMX} -o ${Dir}/a.pdf ${Dir}/a.dvi
	${PDFCROP} ${Dir}/a.pdf $@
