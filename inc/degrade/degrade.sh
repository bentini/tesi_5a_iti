#!/bin/bash

## This script and the LaTeX extension "degrade.sty" may be distributed
## under the conditions of the LaTeX Project Public License
## (http://www.latex-project.org/lppl.txt).

X=
[ $1 = h ]&&X=x
FORMAT="%$1"
FILE="$5/$2.jpg"
DFILE="$6/$2.jpg"
DPI="$3"
IW="$4"
EXT="$7"
INCH=72.27

if [ -s "$FILE" ];then
	W=`identify -format "$FORMAT" "$FILE"`
else
	rm -f "$DFILE"
	exit 0
fi

NW=`echo "$DPI * $IW / $INCH"|bc`

if [ $NW -ge $W ];then
	rm -f "$DFILE"
else
	if [ -s "$DFILE" ]&&[ `identify -format "$FORMAT" "$DFILE"` -eq $NW ];then
		exit 0
	else
		convert -verbose -resize $X$NW "$FILE" "$DFILE"
		[ $EXT = EPS ]&&jpeg2ps "$DFILE" >"${DFILE/.jpg/.eps}"
	fi
fi
