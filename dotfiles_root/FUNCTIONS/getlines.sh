function getLines () 
{
	local HELPTEXT="getlines START END FILE"

  if [[ $1 == "--help" ]] || [[ $1 == "-h" ]] ; then
    echo "${HELPTEXT}" 1>&2
    return 0;
  elif [[ $# -ne 3 ]] ; then
    echo "${HELPTEXT}" 1>&2
    return 1;
  else
		startLine=$1
		endLine=$2
		fileName=$3
		let sedEnd=$e+1
		
		sed -n "${startLine},${endLine}p;${sedEnd}q" $fileName
  fi
}
alias getlines='getLines'
