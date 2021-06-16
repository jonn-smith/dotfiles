#function dog () {
#
#  dr=".";
#
#  if [[ $# == 1 ]] ; then
#    if [[ ! -e $1 ]] ; then
#      echo "dog [DIRECTORY]"
#      exit 1;
#    else
#        dr="${1}"
#    fi
#  fi
#
#  echo "Contents of all files in directory: ${dr}:"
#
#  for f in `bash -c "ls ${dr}"`; do
#    echo -e "${f}:"    
#    cat ${dr}/${f}
#    echo
#  done
#}
