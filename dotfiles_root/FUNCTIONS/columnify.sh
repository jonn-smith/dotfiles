#!/usr/bin/env bash

function columnify() {

	if [[ $# -eq 0 ]] ; then
		echo "USAGE columnify COL_REGEX_1 [COL_REGEX_2 ... ] FILE"
		echo "Reformat a data file by removing rows matching a column regular"
		echo "expression and appending them as new columns to the end of the file."
		return 0
	else
		echo "ERROR - NOT IMPLEMENTED." 1>&2
		return 1
	fi

}
