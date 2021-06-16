#!/bin/bash

function showFigletFonts()
{
  local f
  local cols=$( tput cols )
  local r

  tmpFontList=/tmp/figletTmpFontList.txt

  for f in $( find  $( figlet -I2 ) -type f -name \*.flf | sort ) ; do 
    f=$( echo $f | sed 's#.*/##g' | sed 's#\..*##g' )
    figlet -w ${cols} -f $f $f 1> /tmp/figletTmp.txt 2>/dev/null
    r=$?
    if [[ $r -eq 0 ]] ; then
      echo ${f} >> ${tmpFontList}
      echo "${f}:"
      cat /tmp/figletTmp.txt
      echo
      echo
    fi
  done

	if [[ $# -ne 0 ]] ; then
  	echo "Fonts are:"
		cat ${tmpFontList}
	fi 

  [ -f ${tmpFontList} ] && rm ${tmpFontList}
  [ -f /tmp/figletTmp.txt ] && rm /tmp/figletTmp.txt
}


