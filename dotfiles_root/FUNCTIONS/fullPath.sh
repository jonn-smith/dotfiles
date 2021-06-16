function fullPath()
{
  if [[ $# -eq 0 ]] ; then
    echo "Error: Must give a file for which to get the full path." 1>&2
    return 1
  fi

  for arg in ${@} ; do
    python -c "import os; print os.path.abspath('$arg');"
  done

}
