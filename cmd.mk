
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
