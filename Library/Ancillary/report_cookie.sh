cookies="SYNOPSIS TARGET VARIABLE EN DOCUMENTATION"
wiki="$HOME/Wiki/bsdmakepscripts"

make_report()
{
    printf '# Progress for the %s Cookie\n\n' "$1"
    find . -type f \
	| xargs grep -l "Cookie:.* $1\\( \\|\$\\)" \
	| sed -e 's/^\.\//    /'
}

for cookie in $cookies; do
    make_report $cookie > "$wiki/ReportCookie$cookie.md"
done
