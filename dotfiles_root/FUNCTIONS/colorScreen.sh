function colorScreen()
{ 
  local COLOR=$1

  if [[ $# -ne 1 ]] ; then
    COLOR="\033[0:41m"
  fi

  local MW=$(tput cols)
  local MH=$(tput lines)

  # Create text exactly the width of the terminal:
  local row=$( python -c "print ' '*${MW}" )

  # Set the BG color to RED:
  echo -e "${COLOR}"

  for (( y=0; y < $MH ; y++ )) ; do
    printf "\033[${y};0f${row}\n";
  done

  # Set the text back to normal colors.
  echo -e "\033[0;0m"
}

function redScreen()
{
  colorScreen "\033[0;41m"
}

function greenScreen()
{
  colorScreen "\033[0;42m"
}

function flashScreen()
{
  while true; do
    redScreen
    sleep 0.3
    greenScreen
    sleep 0.3
  done

  # Set the text back to normal colors.
  echo -e "\033[0;0m"
}

function rainbow()
{
  local t=0.05
  local i=0;

  local numTimes=$1
  if [[ $# -ne 1 ]] ; then
    numTimes=0
  elif [[ $numTimes -le 0 ]] ; then
    numTimes=1
  fi

  while [[ $numTimes -eq 0 ]] || [[ $i -lt $numTimes ]] ; do
    colorScreen "\033[0;40m" ; sleep $t 
    colorScreen "\033[0;41m" ; sleep $t 
    colorScreen "\033[0;42m" ; sleep $t 
    colorScreen "\033[0;43m" ; sleep $t 
    colorScreen "\033[0;44m" ; sleep $t 
    colorScreen "\033[0;45m" ; sleep $t 
    colorScreen "\033[0;46m" ; sleep $t 
    colorScreen "\033[0;47m" ; sleep $t 
    let i=$i+1
  done

  # Set the text back to normal colors.
  echo -e "\033[0;0m"
}


