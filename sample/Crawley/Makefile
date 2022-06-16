
Dir ?= /tmp
Tgt = ${Dir}/Crawley.pdf

include ../../cmd.mk

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install: all
	test "${InstallDir}" -a "${Name}"
	install -m 444 -pD ${Tgt} ${InstallDir}/source/latex/${Name}/

${Tgt}: a.tex ${Dir}/familytree.sty
	$(call Latex, a.tex)
	${DVIPDFMX} -o $@ ${Dir}/a.dvi
