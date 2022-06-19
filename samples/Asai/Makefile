
Dir ?= /tmp
Tgt = ${Dir}/Asai.pdf

LATEX ?= platex -kanji=euc
include ../../cmd.mk

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install:
	install -m 444 -pD ${Tgt} \
		${InstallDir}/source/latex/${Name}/$(notdir ${Tgt})

${Tgt}: ${Dir}/%.pdf: %.tex ${Dir}/familytree.sty
	$(call Latex, $<)
	cd ${Dir}; ${DVIPDFMX} $(basename $<).dvi
