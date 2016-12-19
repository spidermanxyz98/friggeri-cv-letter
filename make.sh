#!/usr/local/bin/bash
set -u

function USAGE() {
	printf "Usage:\n %s -t TEXFILE [-l LANG] [-n NAME]\n\n" $( basename ${0} )
	echo "Required argument : "
	echo " -r TEX_RESUME                                       [by default : resume/resume.tex]"
	echo " -c TEX_COVER                                        [by default : cover-letter/cover-letter.tex]"
	echo "Options :"
	echo " -l LANG (english or french)                         [by default : french]"
	echo " -n NAME (NAME_resume.pdf and NAME_cover-letter.pdf) [by default : JohnDoe]"
	echo
	echo "Help :"
	echo " -v activate verbose mode"
	echo " -h print this help"
	echo
	exit ${1:-0}
}

cleanlatex () {
	if [ -z "${1}" ]; then
		echo "File name is missing"
	else
		if [ -e "${1}.aux" ] ; then command rm ${1}.aux ; fi
		if [ -e "${1}.bcf" ] ; then command rm ${1}.bcf ; fi
		if [ -e "${1}.log" ] ; then command rm ${1}.log ; fi
		if [ -e "${1}.out" ] ; then command rm ${1}.out ; fi
		if [ -e "${1}.run.xml" ] ; then command rm ${1}.run.xml ; fi
	fi
}

TEX_RESUME="resume/resume.tex"
TEX_COVER="cover-letter/cover-letter.tex"
LANG="french"
NAME="JohnDoe"
VERBOSE="NO"

while getopts ":hvr:c:n:l:" OPTION
do
	case ${OPTION} in
		r)
			TEX_RESUME=${OPTARG}
			;;
		c)
			TEX_COVER=${OPTARG}
			;;
		l)
			LANG=${OPTARG}
			;;
		n)
			NAME=${OPTARG}
			;;
		v)
			VERBOSE="YES"
			;;
		h)
			USAGE
			;;
		:)
			echo "Error: option -${OPTARG} requires an argument."
			exit 1
			;;
		\?)
			echo "Error : invalid option -${OPTARG}"
			exit 1
			;;
	esac
done

if [[ ${LANG} != "french" && ${LANG} != "english" ]] ; then
	USAGE
	exit 1
fi

# RESUME
CMD1="xelatex -jobname=${LANG} ${TEX_RESUME} >> compilation_resume.log"
CMD2="mv ${LANG}.pdf ${NAME}_resume.pdf"
CMD3="cleanlatex ${LANG}"
CMD4="open ${NAME}_resume.pdf"
echo "Command : ${CMD1}" ; eval ${CMD1} # First compilation
echo "Command : ${CMD1}" ; eval ${CMD1} # Second compilation
echo "Command : ${CMD2}" ; eval ${CMD2}
echo "Command : ${CMD3}" ; eval ${CMD3}
# echo "Command : ${CMD4}" ; eval ${CMD4}

# COVER-LETTER
CMD1="xelatex -jobname=${LANG} ${TEX_COVER} >> compilation_cover-letter.log"
CMD2="mv ${LANG}.pdf ${NAME}_cover-letter.pdf"
CMD3="cleanlatex ${LANG}"
CMD4="open ${NAME}_cover-letter.pdf"
echo "Command : ${CMD1}" ; eval ${CMD1} # First compilation
echo "Command : ${CMD1}" ; eval ${CMD1} # Second compilation
echo "Command : ${CMD2}" ; eval ${CMD2}
echo "Command : ${CMD3}" ; eval ${CMD3}
# echo "Command : ${CMD4}" ; eval ${CMD4}

if [[ ${VERBOSE} == "NO" ]] ; then
	rm "compilation_resume.log"
	rm "compilation_cover-letter.log"
fi
