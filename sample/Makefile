
Dir ?= /tmp
Tgt = ${Dir}/Crawley.pdf

include ../cmd.mk

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install: all
	install -m 444 -pD ${Tgt} \
		${InstallDir}/source/latex/${Name}/$(notdir ${Tgt})

${Tgt}: ${Dir}/%.pdf: %.tex ${Dir}/familytree.sty
	$(call Latex, $<)
	cd ${Dir}; ${DVIPDFMX} $(basename $<).dvi
