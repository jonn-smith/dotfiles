function fixHosts()
{
  if [[ $# -ne 1 ]] ; then
    echo "fixHosts LINE_NUMBER"
    echo "Removes the given line from the known hosts file:"
    echo "  /home/${USER}/.ssh/known_hosts"
    return 0
  fi

  local lineNum=$1

  #Make sure we got a number:
  echo $lineNum | grep '^[0-9]*$' &> /dev/null
  r=$?

  if [[ $r -ne 0 ]] ; then
    echo "Error: Must give a line number.  Given: $lineNum" 1>&2
  fi

  sed -i "${lineNum}d" /home/${USER}/.ssh/known_hosts
}
