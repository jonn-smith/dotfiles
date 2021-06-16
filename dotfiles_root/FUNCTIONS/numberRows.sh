#!/usr/bin/env bash

function numberRows() {
	
	if [[ $# -eq 0 ]] ; then
		awk '{printf "%d\t%s\n", NR, $0}' -
		return $?
	elif [[ $1 -eq '--help' ]] || [[ $1 -eq '-h' ]] ; then
		echo "Usage: numberRows FILE"
		echo "Prepend the number of each line to each line in FILE."
		return 0
	else
		awk '{printf "%d\t%s\n", NR, $0}' $1 
		return $?
	fi

}
