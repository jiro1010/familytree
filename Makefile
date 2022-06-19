
Dir ?= /tmp
export Dir
InstallDir ?= ${Dir}/texmf-dist
export InstallDir

include cmd.mk
Gcid ?= $(shell git log -1 --pretty=format:"%h %aI" | tr -d -- '-:+')
Lo = '\def\Dir{'${Dir}'}\def\Gcid{'${Gcid}'}'

########################################

Name = familytree
export Name
Tgt = $(addprefix ${Dir}/${Name}., sty pdf)
Dtx = $(addsuffix .dtx, ${Name} $(addprefix ft-, \
	lib individual sibling gens marriage))

########################################

all: ${Tgt}
	${MAKE} -C samples $@
	${MAKE} -C doc-ja $@

clean:
	${RM} *~ ${Tgt}
	${MAKE} -C figs --no-print-directory $@
	${MAKE} -C samples --no-print-directory $@
	${MAKE} -C doc-ja --no-print-directory $@

install: ${Dir}/${Name}.sty
#	install -m 444 -pD ${Dir}/${Name}.sty \
#		${InstallDir}/tex/latex/${Name}.sty
	install -m 444 -pD ${Dir}/${Name}.pdf \
		${InstallDir}/source/latex/${Name}/${Name}.pdf
	${MAKE} -C samples --no-print-directory $@
	${MAKE} -C doc-ja --no-print-directory $@
#	install -m 444 -pD *.dtx *.tex sample/ \
#		${InstallDir}/source/latex/${Name}/

########################################

sty: ${Dir}/${Name}.sty
${Dir}/${Name}.sty: ${Name}.ins ${Dtx}
	$(call Latex, $<)
	ls -l $@

${Dir}/${Name}.pdf: %.pdf: %.sty
	${MAKE} -C figs
	$(call MakePdf,${Name},dtx)

-include priv.mk
