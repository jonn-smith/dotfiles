function man2txt()
{
  if [[ $# -ne 1 ]] ; then
    echo "Error: Must give a command for which to get man info." 1>&2
    return 1
  fi

  cmd=$1

  man $cmd | col -bx > ${cmd}.man
}
