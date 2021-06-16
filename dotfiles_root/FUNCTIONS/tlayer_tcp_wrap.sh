function tlayer_tcp_wrap()
{
  if [[ ! -e $1 ]] ; then
    echo "Error: file does not exist: $1" 1>&2
    return $?
  fi

  while read line ; do

    #headerVersionLength
    printf '%s%X%x%s' 'DEADBEEF' 2 ${#line} ${line}

  done < $1
}
