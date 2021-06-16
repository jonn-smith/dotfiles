function rootCp()
{
  if [[ $# -ne 2 ]] ; then
    echo "ERROR: Must give a source and a destination" 1>&2
    return 1
  fi

  if [[ ! -e $1 ]] ; then
    echo "ERROR: Sourcefile does not exist: $1" 1>&2
    return 2
  fi

  echo $2 | grep '/\.$' &> /dev/null
  r=$?

  if [[ -e $2 ]] && [[ $r -ne 0 ]] ; then
    echo "ERROR: Destfile already exists: $2" 1>&2
    return 3
  fi

  sudo rm -rf /tmp/$1

  cp -rv $1 /tmp/$1 && sudo cp -rv /tmp/$1 $2

  return $?
}
