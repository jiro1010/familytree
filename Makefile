
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
Dtx = $(addsuffix .dtx, ${Name} lib individual sibling gens marriage)

Fig = $(addprefix fig1Robert, 1 2)
Fig += fig2baseEN fig2sis fig2ivalEN
Fig += $(addprefix fig3Robert, 1 2) $(addprefix fig3Lily, 1 2 3 4)
Fig += fig4Robert fig4HenryVIII $(addprefix fig4Lily, 1 2 3 4)

figPdf = $(addprefix ${Dir}/, $(addsuffix .pdf, ${Fig}))
figPrint = $(addprefix ${Dir}/, $(addsuffix print.tex, \
		${Fig} \
		))

########################################

all: ${Tgt}
	${MAKE} -C sample $@
	${MAKE} -C ja $@

clean:
	${RM} *~ fig/*~ ${Tgt} ${figPdf} ${figTYPdf} ${figPrint}
	${MAKE} -C sample --no-print-directory $@
	${MAKE} -C ja --no-print-directory $@

install: ${Dir}/${Name}.sty
#	install -m 444 -pD ${Dir}/${Name}.sty \
#		${InstallDir}/tex/latex/${Name}.sty
	install -m 444 -pD ${Dir}/${Name}.pdf \
		${InstallDir}/source/latex/${Name}/${Name}.pdf
	${MAKE} -C sample --no-print-directory $@
	${MAKE} -C ja --no-print-directory $@
#	install -m 444 -pD *.dtx *.tex sample/ \
#		${InstallDir}/source/latex/${Name}/

########################################

sty: ${Dir}/${Name}.sty
${Dir}/${Name}.sty: ${Name}.ins ${Dtx}
	$(call Latex, $<)
	ls -l $@

${Dir}/${Name}.pdf: %.pdf: %.sty ${figPdf} ${figPrint}
	$(call Latex, ${Name}.dtx)
	$(call Latex, ${Name}.dtx)
	cd ${Dir}; \
	${DVIPDFMX} -o $@ ${Name}.dvi
	ls -l $@

########################################

define MakeFigPdf # tgtname texname
	$(call Latex, ${2}.tex) && \
	cd ${Dir} && \
	${DVIPDFMX} ${2}.dvi && \
	${PDFCROP} ${2}.pdf $@ && \
	mv ${2}.dvi ${1}.dvi
endef

fig: ${figPdf}

${figPdf}: Lo = '\def\figsrc{fig/$(notdir $(basename $@))}'
${figPdf}: ${Dir}/%.pdf: fig.tex fig/%.tex ${Dir}/${Name}.sty
	$(call MakeFigPdf,$(basename $@),fig)

########################################

define MakePrintTex # src
	grep -v '^%[^%]' ${1} |\
	tr '\n' '\r' |\
	sed -e 's/^\r\r*//' -e 's/\r\r*$$/\r/' |\
	tr '\r' '\n'
endef

untilComment = $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig1Robert1 fig2baseEN fig2sis fig3Lily1 fig4Robert))
${untilComment}: ${Dir}/%print.tex: fig/%.tex
	sed -e '/^%$$/,$$d' -e 's/.hfill//' $< | grep -v '^%' > $@

noIndvdl =  $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig2ivalEN fig3Robert2))
${noIndvdl}: ${Dir}/%print.tex: fig/%.tex
	fgrep -vw indvdldef $< |\
	fgrep -vx '' |\
	$(call MakePrintTex, -) > $@

${Dir}/fig3Lily2print.tex: ${Dir}/%print.tex: fig/%.tex
	{ \
	echo ...; \
	fgrep -vw indvdldef $< |\
	sed -e '/tabular/,$$d' |\
	$(call MakePrintTex, -); \
	} > $@

$(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig3Lily3 fig3Lily4 fig4Lily2)): ${Dir}/%print.tex: fig/%.tex
	{ \
	echo ...; \
	sed -e '0,/newsavebox/d' -e '/tabular/,$$d' $< |\
	$(call MakePrintTex, -); \
	} > $@

${Dir}/fig4Lily3print.tex: n = 4
${Dir}/fig4Lily4print.tex: n = 2
${Dir}/fig4Lily3print.tex ${Dir}/fig4Lily4print.tex: ${Dir}/%print.tex: fig/%.tex
	{ \
	echo ...; \
	tail -${n} $<; \
	} > $@

${Dir}/%print.tex: fig/%.tex
	$(call MakePrintTex, $<) > $@

-include priv.mk
