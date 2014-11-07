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
#    A string identifying the module being built.
#
#
#  PRODUCT [not set]
#    The list of products built by the current module
#
#
#  PRODUCTFILE [strategy]
#    A file exporting the list of available products

.if !target(__<bps.init.mk>__)
.error bps.product.mk cannot be included directly.
.endif

.if !target(__<bps.product.mk>__)&&defined(PRODUCT)
__<bps.product.mk>__:

PRODUCTFILE?=		${WRKDIR}/.product

.if defined(THISMODULE)&&defined(PRODUCT)&&!empty(PRODUCT)
do-product: .PHONY
	@${ECHO} "PRODUCT_${THISMODULE}+=${PRODUCT}" >> ${PRODUCTFILE}
do-depend:		do-product
.endif

do-distclean:		do-distclean-product
do-distclean-product:	.PHONY
	@${RM} -f ${PRODUCTFILE}

.if exists(${PRODUCTFILE})
.include "${PRODUCTFILE}"
.endif

.endif # !target(__<bps.product.mk>__)

.if!target(display-product)
display-product:
	${INFO} 'Display product information'
.for displayvar in PRODUCT PRODUCTFILE
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.for module in ${_MODULE_LIST}
	${MESG} "PRODUCT_${module}=${PRODUCT_${module}}"
.endfor
.endif

### End of file `bps.product.mk'
