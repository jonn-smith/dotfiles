# CD to a directory in cygwin:
function wincd () 
{

  if [[ $# -eq 0 ]] ; then
    cd
    return $?
  else

    pathString=''
    for arg in $@ ; do
      arg=`echo ${arg} | sed 's#\\\\#/#g'`
      pathString="${pathString}\\ $arg"
    done

    pathString=`echo $pathString | sed 's#^\\\\ ##g'`

    cygdriveLetter=`echo $pathString | sed 's#^\([a-zA-Z]\):.*#\1#g' | tr [A-Z] [a-z]`
    pathString=`echo $pathString | sed "s#^\([a-zA-Z]\):#/cygdrive/$cygdriveLetter#g"`

    if [[ ! -e "$pathString" ]] ; then
      echo "Error: $pathString does not exist."
      return 1
    elif [[ ! -d "$pathString" ]] ; then
      echo "Error: $pathString is not a directory." 
      return 2
    fi

    cd "$pathString"
    return $?
  fi
}
