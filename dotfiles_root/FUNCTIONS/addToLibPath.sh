function addToLibPath()
{
  local absPath=""

  if [[ $# -eq 0 ]] ; then
    absPath=$( python -c "import os; print os.path.abspath('.');" )
    echo "Adding directory to LD_LIBRARY_PATH:"
    echo "    ${absPath}"
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${absPath}
    echo "Done."
  else
    for d in $@ ; do
      if [ -f $d ] ; then
        d=$( echo ${d} | perl -pe 's#(.*)/.*?$#\1#g' )
      fi
      if [ -d $d ] ; then
        absPath=$( python -c "import os; print os.path.abspath('$d');" )
        echo "Adding directory to LD_LIBRARY_PATH:"
        echo "    ${absPath}"
        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${absPath}
        echo "Done."
      else
        echo "ERROR: skipping non-existent directory: $d" 1>&2
      fi
    done
  fi
}
