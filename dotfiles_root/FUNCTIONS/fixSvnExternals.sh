function fixSVNExternals() 
{
  #Converts new externals to old externals:
  # New Format:
  #   [-r <operative revision>] <URL>[@<peg revision>] <local folder name>
  #
  # Old Format:
  #   <local folder name> [-r <revision>] <URL>
  #

  # svn pg svn:externals . | awk '{print $2,$1}' | sed 's#\(.*\) \(svn://.*\)@\(.*\)#\1 -r \3 \2#g'

  local tmpfile

  tmpfile=`mktemp`.`uuidgen`.txt

  checkoutPath='.'
  if [[ $# -eq 1 ]] ; then
    checkoutPath=$1
  fi

  svn pg svn:externals $checkoutPath &> $tmpfile
  r=$?
  if [[ $r -ne $0 ]] ; then
    cat $tmpfile
    rm $tmpfile
    return $r
  fi

  while read xtern ; do

    # Make sure this extern is a new one:
    echo $xtern | grep '@' &> /dev/null
    r=$?
    if [[ $r -ne 0 ]] ; then
      continue
    fi

    # Check to see if the extern has an operative revision
    echo $xtern | grep '-r' &> /dev/null
    r=$?

    # No -r flag in the extern:
    if [[ $r -ne 0 ]] ; then
      echo $xtern | awk '{print $2,$1}' | sed 's#\(.*\) \(svn://.*\)@\(.*\)#\1 -r \3 \2#g'
    else
      echo $xtern | sed 's#.*\(svn://.*\)@\(.*\) \(.*\)#\3 -r \2 \1#g'
    fi

  done < $tmpfile

  rm $tmpfile
}
