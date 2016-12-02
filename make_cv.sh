#!/usr/local/bin/bash

LANG=${1}

if [[ ${LANG} == "" ]] ; then
  LANG="french"
fi

NAME="CV_JohnDoe.pdf"

xelatex -jobname=${LANG} "resume.tex"
xelatex -jobname=${LANG} "resume.tex"

mv "${LANG}.pdf" ${NAME}

open ${NAME}
