# Send a message to a user on their most active terminal session
function sendMessage
{
  local tmpOutFile
  local tty
  local args
  local seen
  local arg

  tmpOutFile=`mktemp`
  getActiveUsersAndTerminals > $tmpOutFile

  if [[ $# -eq 1 ]] ; then
    echo "" > /dev/null
  else
    grep $1 $tmpOutFile &> /dev/null
    r=$?
    if [[ $r -ne 0 ]] ; then
      echo "Error: user $1 is not logged in"
    else
      tty=`\grep --binary-files=text "$1" $tmpOutFile | awk '{print $2}'`
      args=""
      seen=false
      for arg in $@ ; do
        if $seen ; then
          args="${args} ${arg}" 
        else
          seen=true
        fi
      done
      echo -e "\n${args}\n" | write $1 $tty
    fi
  fi

  rm $tmpOutFile
}
