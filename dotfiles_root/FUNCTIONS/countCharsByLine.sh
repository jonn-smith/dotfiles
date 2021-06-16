function countCharsByLine()  
{
	local delim=$1
	local f=$2
	local r=1

	# Check args:
	if [ $# -lt 1 ] || [ $# -gt 2 ] ; then
		echo 'countChars CHAR [FILE]'
	# Reading from stdin:
	elif [ $# -eq 1 ] ; then
		awk -F "${delim}" '{print NF-1}' - 
		r=$?
	# Reading from file:
	else 
		awk -F "${delim}" '{print NF-1}' $f
		r=$?
	fi

	return $r
}
