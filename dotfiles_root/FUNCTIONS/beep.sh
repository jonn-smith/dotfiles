function beep() 
{
  numBeeps=100
  if [[ $# -ne 0 ]] ; then
    numBeeps=$1
  fi

  let i=0
  while [[ $i -lt $numBeeps ]] ; do 
    printf '\a'
    sleep 0.1 
    let i=$i+1
  done

}
