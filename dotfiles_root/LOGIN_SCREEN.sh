#\[\033[40m\]

################################################################################
##
## Display Login Info: 
##
################################################################################

# Only execute the following in an interactive prompt:
if ( tty -s ) ; then
  echo
  echo -e "\033[0;36m________________________________________________________________________________"
  echo -e "Welcome To ${HOSTNAME}\033[0;0m"

  which figlet &> /dev/null
  r=$?

  echo -en "\033[1;35;40m" 

  if [[ $r -ne 0 ]] ; then
    echo
    echo "    $HOSTNAME"
  else
    numCols=$( tput cols )

    #fonts=( epic larry3d )
		fonts=( 3-d 3x5 5lineoblique computer gothic roman acrobatic alligator alligator2 alphabet avatar banner banner3-D banner3 banner4 barbwire basic bell big bigchief binary block broadway bubble bulbhead calgphy2 caligraphy catwalk chunky coinstak colossal computer contessa contrast cosmic cosmike crawford cricket cyberlarge cybermedium cybersmall decimal diamond digital doh doom dotmatrix double drpepper dwhistled eftichess eftifont eftipiti eftirobot eftitalic eftiwall eftiwater epic fender fourtops fraktur fuzzy goofy gothic graceful gradient graffiti hex hollywood invita isometric1 isometric2 isometric3 isometric4 italic ivrit jazmine jerusalem katakana kban l4me larry3d lcd lean letters linux lockergnome madrid marquee maxfour mike mini mirror mnemonic morse moscow mshebrew210 nancyj-fancy nancyj-underlined nancyj nipples ntgreek nvscript o8 octal ogre os2 pawp peaks pebbles pepper poison puffy pyramid rectangles relief relief2 rev roman rot13 rounded rowancap rozzo runic runyc sblood script serifcap shadow short slant slide slscript small smisome1 smkeyboard smscript smshadow smslant smtengwar speed stacey stampatello standard starwars stellar stop straight tanja tengwar term thick thin threepoint ticks ticksslant tinker-toy tombstone trek tsalagi twopoint univers usaflag weird whimsy )
    maxChoice=${#fonts}
    maxChoice=$((maxChoice+1))
    choice=$(( ( RANDOM % maxChoice ) )) 

    case ${choice} in
      0) figlet -w ${numCols} $HOSTNAME ;;
      *) ((choice--)) ; figlet -w ${numCols} -f ${fonts[choice]} $HOSTNAME ;;
    esac
    echo ''
  fi
  echo -en "\033[0;0m"
  echo ''

  echo -ne "Today is:\t\t" `date`; echo ""
  echo -e "\033[0;33mKernel Information: \t" `uname -smr`
  echo -ne "$HOSTNAME uptime is  \t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
  echo
  echo -e "\033[0;0mIP Configuration:\033[0;36m"
  ifconfig | \grep -A1 '^[a-zA-Z0-9]' | sed 's$-$$g' | sed 's$addr:$addr: $g'
  echo ""

  dateColor=$( echo -e "\033[0;32m" )
  dayColor=$( echo -e "\033[1;4;35;47m" )

  echo -en "$dateColor"
  getCalendar ${dayColor} ${dateColor}
  echo -en "\033[0;0m"
  echo ""

  ################################################################################
  ##
  ## Source server-specific files:
  ##
  ################################################################################

  ################################################################################
  ##
  ## Display messages to the user:
  ##
  ################################################################################

  echo ""
  echo '----------------------------------------'
  echo ""
  which screen &> /dev/null
  r=$?
  if [[ $r -eq 0 ]] ; then
    screen -list
  else
    echo "WARNING: SCREEN IS NOT INSTALLED" 1>&2
  fi
  echo '----------------------------------------'
  echo ""
	which tmux &> /dev/null
	r=$?
	if [[ $r -eq 0 ]] ; then
		echo "tmux sessions:"
		tmux list-sessions
	else 
		echo "WARNING: TMUX IS NOT INSTALLED" 1>&2
	fi
  echo '----------------------------------------'
  echo ""
  echo ""
  echo '________________________________________________________________________________'
  echo ''
fi

