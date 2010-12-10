SRCS+= main.sgml
SRCS+= head-css-global.sgml
SRCS+= more-news.sgml

SEARCH+= .
SEARCH+= ${PROJECTBASE}/Website/style
SEARCH+= ${PROJECTBASE}/Website/sgml

SCROLL_INCLUSION = head-css-local
SCROLL_INCLUSION+= more-news
SCROLL_INCLUSION+= more-ilink
SCROLL_INCLUSION+= more-elink
SCROLL_INCLUSION+= more-download

.for inclusion in ${SCROLL_INCLUSION}
.if !empty(SRCS:M${inclusion}.sgml)
INCLUDE+= with.${inclusion}
.endif
.endfor

.include "www.sgml.mk"
