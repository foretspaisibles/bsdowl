#! /bin/sh

### releng -- Release Engineering script

# Author: Michael Grünewald
# Date: Thu Mar 13 23:01:35 CET 2008

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


# Ce programme automatise des parties de la procédure de publication.
# Les parties actuellement prises en charge sont:
#  - La publication des `tarball'.

# On utilise SVN, PERL, TAR, GZIP, BZIP2 et CURL.

#
# Configuration
#

releng_project='bsdowl'
releng_sum_tools='md5 sha256'
releng_repository="$REPOSITORY"
releng_subversion='/usr/local/bin/svn'
releng_tmpdir="/tmp"
releng_target="file://$HOME/export/bsdowl/"

#
# Constantes
#

SUCCESS=0
FAILURE=1

#
# Procédures ancillaires
#

releng_info()
{
    echo '***' "$@" 1>&2
}

releng_svn()
{
    $releng_subversion --non-interactive "$@"
    return $?
}

releng_exists()
# $1 sub folder of the repository
{
    releng_svn list "$releng_repository/$1" 1>&- 2>&-
    return $?
    # Le code de retour de SVN est imprécis
}

releng_distfile_validate()
# $1 a releng label
#    Checks the formal validity of a releng label to be distributed
{
    perl -e '
if($ARGV[0] =~ m/releng-[0-9]+\.[0-9]+-(bp|rc[0-9]+)/) {
  exit 0;
} elsif ($ARGV[0] =~ m/release-[0-9]+\.[0-9]+/) {
  exit 0;
} else {
  exit 1;
}' $1
    return $?
}

releng_distfile_mkname()
# $1 a validated releng label
#    Computes a public name corresponding to the releng label
{
    perl -e '
$_ = $ARGV[0];
s/^releng-//;
s/^release-//;
print $_;
' $1
}

#
# Procédures principales
#

releng_usage_display()
{
    cat - <<EOF
Usage: releng TAG
 Produit les fichiers de distribution pour TAG
EOF
}

releng_help()
{
    releng_usage_display
    exit 0
}

releng_usage()
{
    releng_usage_display
    exit 64
}

releng_distfile()
# $1 name of the releng to distribute (e.g. releng-1.0-rc1)
{
    local distname
    local distfiles
    local sumfiles

    distfiles=''	# Tarballs
    sumfiles=''		# MD5
    otherfiles=''	# README
    allfiles=''		# Concatenation of the three above
    signfiles=''	# Fichiers de signature
    curlfiles=''	# Liste des fichiers pour CURL

    releng_distfile_validate "$1"	|| exit 1
    releng_exists tags/$1		|| exit 2

    distname=$releng_project-`releng_distfile_mkname $1`

    releng_info 'Starting the export'
    releng_svn export $releng_repository/tags/$1 $releng_tmpdir/$distname

    releng_info 'Creating the gzipped tarball'
    tar czfC $releng_tmpdir/$distname.tar.gz  $releng_tmpdir $distname \
	|| exit 3

    releng_info 'Creating the bzipped tarball'
    tar cjfC $releng_tmpdir/$distname.tar.bz2 $releng_tmpdir $distname \
	|| exit 4

    releng_info 'Cleaning the export directory'
    rm -Rf $releng_tmpdir/$distname || exit 5

    distfiles="$distname.tar.gz $distname.tar.bz2"	# sic

    releng_info 'Making sums'
    for sum_tool in $releng_sum_tools; do
	(
	    cd $releng_tmpdir
	    $sum_tool $distname.tar.gz $distname.tar.bz2 \
		> CHECKSUM.$sum_tool
    );
	sumfiles="$sumfiles${sumfiles:+ }CHECKSUM.$sum_tool"
    done

    allfiles="${distfiles}${sumfiles:+ ${sumfiles}}${otherfiles:+ ${otherfiles}}"
    releng_info 'Signing files'
    for file in $distfiles $sumfiles; do
	(
	    cd $releng_tmpdir
	    gpg --detach-sign --clearsign $file
        );
	signfiles="$signfiles${signfiles:+ }$file.asc"
    done


    case $releng_target in
	file://*)
	    releng_info 'Creating publication directory'
	    install -d ${releng_target#file://};;
    esac

    releng_info 'Publishing files with curl'
    for file in $allfiles $signfiles; do
	curlfiles="$curlfiles${curlfiles:+,}$file"
    done
    curl -T \
	"$releng_tmpdir/{${curlfiles}}" \
	"$releng_target" \
	|| exit 6

    releng_info 'Cleaning the temporary directory'
    (
	cd $releng_tmpdir
	rm $signfiles $allfiles
    )
}

releng_distfile "$1"

### End of file `releng'
