# Author: Michael Grünewald
# Date: dim 16 jui 2013 13:41:46 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

ORIGINAL_IFS="$IFS"

lu_query()
{
    find "$1" -name fix_encoding_and_copyright.sh -prune -or -name '.git' -prune -or -type f -print \
	| xargs file -i \
	| sed -e 's/:[[:space:]]*/|/g' -e 's/;[[:space:]]*/|/g'
}

lu_remove_id()
{
    sed -n -e '/^[[:space:]]*$/N;/\$Id\$/d;p'
}

lu_remove_lang()
{
    sed -e '/Lang: fr_FR/d'
}

lu_fix_my_name()
{
    sed -e '
s/Michaël/Michael/g
s/Le Barbier Grünewald/Grünewald/g
s/Le Barbier/Grünewald/g
s/Gruenewald/Grünewald/g
s/<michael.le_barbier@laposte.net>/<michipili@gmail.com>/
'
}

lu_iconv()
{
    iconv -f LATIN-9 -t utf-8
}

lu_fix_copyright()
{
    sed -e '/Copyright.*Grünewald/{
s/(c)/(C)/;
s/<michael.le_barbier@laposte.net>//
s/Michaël Le Barbier Grünewald//
s/ -//
s/  */ /g
s/ $//
s/$/, 2013 Michael Grünewald/
}'

}

lu_filter()
{
    local lu_iconv_filter
    case $1 in
	charset=iso-8859-1)
	    lu_iconv_filter="lu_iconv";;
	*)
	    lu_iconv_filter="cat";;
    esac
    $lu_iconv_filter \
	| lu_remove_id \
	| lu_remove_lang \
	| lu_fix_copyright \
	| lu_fix_my_name
}

lu_select()
{
    awk -F'|' -v OFS='|' '$2 ~ "text" {print($1,$3)}'
}

lu_process()
{
    IFS='|'
    while read file encoding; do
	# grep -i 'Copyright.*Mich' $file
	mv "$file" "$file.bak"
	lu_filter "$encoding" < "$file.bak" > "$file"
	rm -f "$file.bak"
    done
    IFS="$ORIGINAL_IFS"
}

lu_query . | lu_select | lu_process
