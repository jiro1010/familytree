
Dir ?= /tmp
export Dir
InstallDir ?= ${HOME}/lib/texinputs/

include cmd.mk
Gcid ?= $(shell git log -1 --pretty=format:"%h %aI" | tr -d -- '-:+')
Lo = '\def\Gcid{'${Gcid}'}'

########################################

Name = familytree
Tgt = ${Dir}/${Name}.sty ${Dir}/${Name}-ja.pdf
Dtx = $(addsuffix .dtx, ${Name} lib individual sibling gens)

Fig = fig1base fig1Ieyasu fig1Hidetada
Fig += fig2base fig2Hidetada fig2ival fig2cfg
Fig += fig3Hidetada fig3Ietsuna fig3Iemitsu
figLily = $(addprefix fig3Lily, 1 2 3 4)
Fig += ${figLily}

figTY = $(addsuffix T, ${Fig}) $(addsuffix Y, ${Fig})
figTYPdf = $(addprefix ${Dir}/, $(addsuffix .pdf, ${figTY}))
figPdf = $(addprefix ${Dir}/, $(addsuffix .pdf, ${Fig}))
figPrint = $(addprefix ${Dir}/, $(addsuffix print.tex, \
		${Fig} \
		$(addsuffix T, fig3Iemitsu) \
		$(addsuffix Y, ${figLily}) \
		))

########################################

all: ${Tgt}

clean:
	${RM} *~ ${Tgt} ${figPdf} ${figTYPdf} ${figPrint}

install: ${Dir}/${Name}.sty
	install -m 444 -p ${Dir}/${Name}.sty ${InstallDir}

########################################

sty: ${Dir}/${Name}.sty
${Dir}/${Name}.sty: ${Name}.ins ${Dtx}
	$(call Latex, $<)
	ls -l $@

${Dir}/${Name}-ja.pdf: %-ja.pdf: %.sty ${figPdf} ${figPrint}
	$(call Latex, ${Name}.dtx)
	$(call Latex, ${Name}.dtx)
	cd ${Dir}; \
	${DVIPDFMX} -o $@ ${Name}.dvi

########################################

define MakeFigPdf # tgtname texname
	$(call Latex, ${2}.tex) && \
	cd ${Dir} && \
	${DVIPDFMX} ${2}.dvi && \
	${PDFCROP} ${2}.pdf $@ && \
	mv ${2}.dvi ${1}.dvi
endef

fig: ${figPdf}

${figTYPdf}: Lo += '\def\figsrc{$(basename $<)}'
${Dir}/%T.pdf: Lo += '\newif\ifmaketate\maketatetrue'
${Dir}/%Y.pdf: Lo += '\newif\ifmaketate\maketatefalse'
${Dir}/%T.pdf: %.tex figTY.tex ${Dir}/${Name}.sty
	$(call MakeFigPdf,$(basename $@),figTY)
	ebb $@
${Dir}/%Y.pdf: %.tex figTY.tex ${Dir}/${Name}.sty
	$(call MakeFigPdf,$(basename $@),figTY)
	ebb $@

${figPdf}: Lo = '\def\figsrc{$(notdir $(basename $@))}'
${figPdf}: ${Dir}/%.pdf: ${Dir}/%T.pdf ${Dir}/%Y.pdf fig.tex
	$(call MakeFigPdf,$(basename $@),fig)

########################################

untilComment = $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig1Ieyasu fig2Hidetada fig3Hidetada))
${untilComment}: ${Dir}/%print.tex: %.tex
	sed -e '/^%$$/,$$d' $< | grep -v '^%' > $@

noIndvdl =  $(addprefix ${Dir}/, $(addsuffix print.tex, \
	fig2ival fig2cfg))
${noIndvdl}: ${Dir}/%print.tex: %.tex
	fgrep -vw indvdldef $< > $@

${Dir}/fig3Lily2print.tex: ${Dir}/%print.tex: %.tex
	echo ' ... ' > $@
	tail -8 $< | grep -v '^%' >> $@

${Dir}/fig3Lily3print.tex: ${Dir}/%print.tex: %.tex
	echo ' ... ' > $@
	head -13 $< | tail -7 | grep -v '^%' >> $@
	echo ' ... ' >> $@

${Dir}/fig3Lily4print.tex: ${Dir}/%print.tex: %.tex
	echo ' ... ' > $@
	head -11 $< | tail -5 | grep -v '^%' >> $@
	echo ' ... ' >> $@

${Dir}/%Tprint.tex ${Dir}/%Yprint.tex: ${Dir}/%print.tex
	cp -p $< $@
${Dir}/%print.tex: %.tex
	grep -v '^%[^%]' $< |\
	tr '\n' '\r' |\
	sed -e 's/\r\r*$$/\r/' |\
	tr '\r' '\n' > $@

-include priv.mk
