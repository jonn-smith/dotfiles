#\[\033[40m\]

# OSX settings / functions go here:
if [[ `uname` == 'Darwin' ]] ; then


	echo "+==========================================+"
	echo "| Enabling special OS settings for: Darwin |"
	echo "+==========================================+"
	
	#echo "Enabling special OS settings for:"
	#which figlet &> /dev/null
	#r=$?
	#if [[ $r -eq 0 ]] ; then
	#	figlet Darwin
	#else
	#	echo "        Darwin"
	#fi

	# Make `tar` do what we want it to do on OSX:
	alias tar='COPYFILE_DISABLE=1 tar -X ~/tar.uninclude'

  function getCalendar()
  {

    # Get the colors right:
    local highlightColor normColor;
    highlightColor=$( echo -e "\033[1;30;41m" )
    normColor=$( echo -e "\033[0;0m" )
    if [[ $# -eq 2 ]] ; then
      highlightColor=${1}
      normColor=${2}
    fi

    local mon;
    local day;
		local year;
    
		let year=$( date +%Y )
    let mon=$( date +%m | sed 's#^0##g' );
    let day=$( date +%d | sed 's#^0##g' );

    # Need to handle month=1 and month=12 for the purposes of getting the 
    # straddling months.

    local mf1 mf2 mf2_t mf3 

    mf1=$( mktemp )
    mf2=$( mktemp )
    mf2_t=$( mktemp )
    mf3=$( mktemp )

    # Get the calendar info, we need to pre-process the top line
    # And bottom line of the files to make sure they have the same width.
    # This width is nominally 18 characters for the normal week view.

		if [[ $mon -eq 1 ]] ; then
			local lastYear=$((year-1))
			cal -m 12 $lastYear | tail -n+27 | cut -c 45- | sed "s#      December#   December ${lastYear}#g" |sed -e 's#^#"#g' -e 's#$#"#g' | xargs printf "%-20s\n" > ${mf1} 
		else
    	cal -m $((mon-1)) | sed -e 's#^#"#g' -e 's#$#"#g' | xargs printf "%-20s\n" > ${mf1} 
		fi
    cal -m $((mon))   | sed -e 's#^#"#g' -e 's#$#"#g' | xargs printf "%-20s\n" > ${mf2_t}
		if [[ $mon -eq 12 ]] ; then
			local nextYear=$((year+1))
			cal -m 1 $nextYear | tail -n+3 | head -n8 | cut -c-22 | sed "s#      January#   January ${nextYear}#g" | sed -e 's#^#"#g' -e 's#$#"#g' | xargs printf "%-20s\n" > ${mf3} 
		else
    	cal -m $((mon+1)) | sed -e 's#^#"#g' -e 's#$#"#g' | xargs printf "%-20s\n" > ${mf3} 
		fi

    # Now we highlight the current day using ANSI escape sequences:
    sed "s# ${day} # ${highlightColor}${day}${normColor} #" ${mf2_t} > ${mf2} 

    # Output the calendar:
    paste ${mf1} ${mf2} ${mf3}

    # Clean up the cruft:
    rm ${mf1} ${mf2} ${mf2_t} ${mf3}
  }
fi


