function getl () 
{
  if [[ $# == 1 ]] ; then

    x=`echo $1 | grep ":"`;

    if [[ $1 == "--help" ]] ; then
      echo "getl <line number> file1 [file2 file3 ... ]"
      return 0;

    elif [[ ${#x} != 0 ]] ; then
      linenumber=`echo ${1} | perl -pe "s/.*?:(\d+).*/\1/g"`;
      filename=`echo ${1} | perl -pe "s/(.*?):.*/\1/g"`;

      sed -n "${linenumber}p" $filename
    fi

  elif [[ $# < 2 ]] ; then
    echo "getl <line number> file1 [file2 file3 ... ]"
    return 1;
  else
    oneLoopDone=0;
    for arg in $@ ; do 
      if [[ $oneLoopDone == 1 ]] ; then
        sed -n "${1}p" $arg
      else
        oneLoopDone=1;
      fi
    done
  fi
}
