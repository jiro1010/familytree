
Dir ?= /tmp
export Dir
InstallDir ?= ${HOME}/lib/texinputs/

include cmd.mk
Gcid ?= $(shell git log -1 --pretty=format:"%h %aI" | tr -d -- '-:+')
Lo = '\def\Gcid{'${Gcid}'}'

########################################

Name = familytree
Tgt = ${Dir}/${Name}.sty ${Dir}/${Name}-ja.pdf
Dtx = $(addsuffix .dtx, ${Name} lib)

########################################

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install: ${Dir}/${Name}.sty
	install -m 444 -p ${Dir}/${Name}.sty ${InstallDir}

########################################

sty: ${Dir}/${Name}.sty
${Dir}/${Name}.sty: ${Name}.ins ${Dtx}
	$(call Latex, $<)
	ls -l $@

${Dir}/${Name}-ja.pdf: %-ja.pdf: %.sty
	$(call Latex, ${Name}.dtx)
	$(call Latex, ${Name}.dtx)
	cd ${Dir}; \
	${DVIPDFMX} -o $@ ${Name}.dvi

-include priv.mk
