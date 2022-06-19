
Dir ?= /tmp
export Dir

include ../cmd.mk
Lo = '\def\Dir{'${Dir}'}'

Fig = $(addprefix fig1Robert, 1 2)
Fig += fig2base fig2sis fig2ival
Fig += $(addprefix fig3Robert, 1 2) $(addprefix fig3Lily, 1 2 3 4)
Fig += fig4Robert fig4HenryVIII $(addprefix fig4Lily, 1 2 3 4)

figPdf = $(addprefix ${Dir}/, $(addsuffix .pdf, ${Fig}))
figPrint = $(addprefix ${Dir}/, $(addsuffix print.tex, ${Fig}))
Tgt = ${figPdf} ${figPrint}

########################################

all: ${Tgt}

clean:
	${RM} *~ ${Tgt}

install:
# do nothing

########################################

fig: ${figPdf}
${figPdf}: Lo = '\def\figsrc{$(notdir $(basename $@))}'
${figPdf}: ${Dir}/%.pdf: fig.tex %.tex #${Dir}/${Name}.sty
	$(call MakeFigPdf,$(basename $@),fig)

########################################

untilComment = $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig1Robert1 fig2base fig2sis fig3Lily1 fig4Robert))
${untilComment}: ${Dir}/%print.tex: %.tex
	sed -e '/^%$$/,$$d' -e 's/.hfill//' $< | grep -v '^%' > $@

noIndvdl =  $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig2ival fig3Robert2))
${noIndvdl}: ${Dir}/%print.tex: %.tex
	fgrep -vw indvdldef $< |\
	fgrep -vx '' |\
	$(call MakePrintTex, -) > $@

${Dir}/fig3Lily2print.tex: ${Dir}/%print.tex: %.tex
	{ \
	echo ...; \
	fgrep -vw indvdldef $< |\
	sed -e '/tabular/,$$d' |\
	$(call MakePrintTex, -); \
	} > $@

$(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig3Lily3 fig3Lily4 fig4Lily2)): ${Dir}/%print.tex: %.tex
	{ \
	echo ...; \
	sed -e '0,/newsavebox/d' -e '/tabular/,$$d' $< |\
	$(call MakePrintTex, -); \
	} > $@

${Dir}/fig4Lily3print.tex: n = 4
${Dir}/fig4Lily4print.tex: n = 2
$(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig4Lily3 fig4Lily4)): ${Dir}/%print.tex: %.tex
	{ \
	echo ...; \
	tail -${n} $<; \
	} > $@

${Dir}/%print.tex: %.tex
	$(call MakePrintTex, $<) > $@

-include priv.mk
