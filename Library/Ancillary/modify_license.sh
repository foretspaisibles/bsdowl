license_subdir="Library bps misc ocaml rox snippets support test text www"
license_clue='THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'\'\'' AND ANY EXPRESS OR'

license_check()
{
    grep "$license_clue" $1 &>-
    return $?
}

license_find()
{
    local f
    find $license_subdir \( -name .svn -prune \) -or \( -type f -print \) |\
	while read f; do
	    if license_check $f; then
		echo $f;
	    fi
	    done
}

license_classify_prefix()
{
    sed -n -e "s@$license_clue.*@@p" $1
}

license_classify()
{
    local p
    p=`license_classify_prefix $1`
    case $p in
	'#'*)	echo shell;;
	'//')	echo cpp;;
	'/*')	echo c;;
	*)	echo unknown;;
    esac
}

license_dates_get()
{
    sed -n \
	-e 's/\(, [0-9][0-9][0-9][0-9]\)*, /-/' \
	-e 's/.*Copyright (c) \([-0-9, ]*\) .*/\1/p' \
	$1
}

license_make_shell()
{
    sed -e "s/@DATE@/$1/" -e 's/^/# /' <<'EOF'
BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
This file is part of BSDMake Pallàs Scripts

Copyright (C) Michaël Le Barbier Grünewald - @DATE@

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

EOF
}

license_modify()
{
    local o
    local n
    local d
    local l
    local c

    o="$1.bak"
    n="$1"
    mv "$1" "$o"
    d=`license_dates_get $o`
    c=`license_classify $o`
    l=`license_make_$c "$d"`
    gawk -v license="$l" '
BEGIN { license_output=0; license_block=0; }
/Copyright \(c\) /,/POSSIBILITY OF SUCH DAMAGE\./ {
    license_block=1
    if(!license_output) {
      print(license);
      license_output=1;
  }
}
// { if(!license_block) { print }
     license_block=0;
}
' $o > $n
}


license_find | while read file; do
    license_modify $file
done
