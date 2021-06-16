function despace()
{
  local line=""

  if [[ $# -eq 0 ]] ; then
    read line 
  fi
  line="${line}${@}"

  echo "$line" | tr ' ' '_'
}
