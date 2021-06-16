function checkport () 
{

  if [[ $# -ne 1 ]] ; then
    echo "checkport PORTNUM"
    return 1;
  fi

  netstat -l 2>&1 | awk '{print $4;}' | egrep ':[0-9]+' | sed 's/.*:\([0-9]*\).*/\1/g' | grep '[0-9]' | grep $1
}
