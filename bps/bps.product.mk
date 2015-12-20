### bps.product.mk -- Handle product information

# Author: Michael Grünewald
# Date: Wed Nov  5 16:48:35 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### DESCRIPTION

# Handle product information for modules.

# Variables:
#
#  THISMODULE [not set]
#   A string identifying the module being built.
#
#
#  PRODUCT [not set]
#   The list of products built by the current module
#
#
#  PRODUCTFILE [${WRKDIR}/.product]
#   A file exporting a table of available products
#
#
#  PRODUCT_AWK [${AWK} -F'|']
#   A awk program that can be used to process the product file

.if !target(__<bps.init.mk>__)
.error bps.product.mk cannot be included directly.
.endif

.if !target(__<bps.product.mk>__)
__<bps.product.mk>__:

PRODUCTFILE?=		${WRKDIR}/.product
PRODUCTTOOL?=		sh -c '\
printf "%s|%s|%s|%s\n"\
  "${THISMODULE}"\
  "${RELDIR}"\
  "$$1"\
  "$$2"\
  >> ${PRODUCTFILE}\
' PRODUCTTOOL

.if defined(THISMODULE)&&defined(PRODUCT)
do-product: .PHONY
.for product in ${PRODUCT}
	@${PRODUCTTOOL} '${product}' '${PRODUCT_ARGS.${product}}'
.endfor
do-depend:		do-product
.endif

do-distclean:		do-distclean-product
do-distclean-product:	.PHONY
	@${RM} -f ${PRODUCTFILE}

PRODUCT_AWK?=		${AWK} -F'|'

.if exists(${PRODUCTFILE})
_PRODUCT_MODULE_LIST!=	${PRODUCT_AWK}\
			  '{a[$$1]}END{for(m in a){print m}}'\
			  ${PRODUCTFILE}
.for module in ${_PRODUCT_MODULE_LIST}
PRODUCT_${module}!=	${PRODUCT_AWK} -v module='${module}'\
			  '$$1 == module {print $$3}'\
			  ${PRODUCTFILE}
.endfor
.endif

.endif # !target(__<bps.product.mk>__)

.if!target(display-product)
display-product:
	${INFO} 'Display product information'
.for displayvar in PRODUCT PRODUCTFILE
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.if exists(${PRODUCTFILE})
	${MESG} "---- Dump product file ----"
	@cat < ${PRODUCTFILE}
.endif
.endif

### End of file `bps.product.mk'
