
Dir ?= /tmp
Tgt = ${Dir}/Crawley.pdf

include ../cmd.mk

all: ${Tgt}
	for i in Asai Tokugawa; \
	do ${MAKE} -C ${CURDIR}/$${i} $@; done

clean:
	${RM} *~ ${Tgt}
	for i in Asai Tokugawa; \
	do ${MAKE} -C ${CURDIR}/$${i} $@; done

install: all
	install -m 444 -pD ${Tgt} \
		${InstallDir}/source/latex/${Name}/$(notdir ${Tgt})
	for i in Asai Tokugawa; \
	do ${MAKE} -C ${CURDIR}/$${i} $@; done

${Tgt}: ${Dir}/%.pdf: %.tex ${Dir}/familytree.sty
	$(call Latex, $<)
	cd ${Dir}; ${DVIPDFMX} $(basename $<).dvi
