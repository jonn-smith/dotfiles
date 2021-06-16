# Prepend text to a file:
function prepend() 
{
  if [[ $# -ne 2 ]] ; then
    echo "prepend TEXT FILE"
    return 1;
  else

    if [[ ! -e $2 ]] ; then
      echo "ERROR: FILE does not exist: $2"
      return 1;
    fi

    tmpFile="/tmp/out`date +%s.%N`"
    echo -e $1 | cat - $2 > $tmpFile && mv $tmpFile $2
  fi
}
