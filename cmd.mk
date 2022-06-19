
Lo =
LATEX ?= latex
define Latex # texsrc
	tmp=/tmp/$${$$}; \
	rc=0; \
	{ \
	${LATEX} \
		-halt-on-error -interaction=nonstopmode \
		-no-mktex tfm -file-line-error \
		-output-directory ${Dir} \
		${Lo}'\input' ${1} > $${tmp} ||\
		{ rc=$${?}; tail -20 $${tmp}; }; \
	${RM} $${tmp}; \
	test $${rc} -eq 0; \
	}
endef

TEXINPUTS := ${Dir}:${TEXINPUTS}
export TEXINPUTS
DVIPDFMX ?= dvipdfmx -q -f erewhon.map -f newtx.map -f Chivo.map
PDFCROP ?= pdfcrop --noverbose

define MakePdf
	$(call Latex, ${1}.${2})
	$(call Latex, ${1}.${2})
	cd ${Dir}; \
	${DVIPDFMX} -o ${1}.pdf ${1}.dvi
	ls -l ${Dir}/${1}.pdf
endef

define MakeFigPdf # tgtname texname
	$(call Latex, ${2}.tex) && \
	cd ${Dir} && \
	${DVIPDFMX} ${2}.dvi && \
	${PDFCROP} ${2}.pdf $@ && \
	mv ${2}.dvi ${1}.dvi
endef

define MakePrintTex # src
	grep -v '^%[^%]' ${1} |\
	tr '\n' '\r' |\
	sed -e 's/^\r\r*//' -e 's/\r\r*$$/\r/' |\
	tr '\r' '\n'
endef
