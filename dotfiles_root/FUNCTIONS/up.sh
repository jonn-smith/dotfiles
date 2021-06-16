function up () 
{
  retval=0

  if [[ $# -gt 1 ]] ; then
    echo "Error: Must provide only one argument." 1>&2
    retval=1
  elif [[ $# -eq 0 ]] ; then
    cd ..
    retval=$?
  elif [[ $# -eq 1 ]] ; then
    n=$1
    echo "$n" | grep '^[0-9]*$' &>/dev/null
    r=$?
    if [[ $r -ne 0 ]] ; then
      echo "Error: Must provide the number of directories to go up." 1>&2
      retval=$r
    else
      uds=""
      for (( i=0; i < n ; i++ )) ; do
        uds="${uds}../"
      done
      cd $uds
      retval=$?
    fi
  fi

  return $retval
}
