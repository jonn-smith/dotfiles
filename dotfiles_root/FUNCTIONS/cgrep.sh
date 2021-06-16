##Find something in source code, excluding binary files and SVN logs.
function cgrep () 
{

  if [[ $# < 1 ]] ; then
    echo "cgrep [OPTIONS] PATTERN"
    return 1
  elif [[ $1 == "--help" ]] ; then
    egrep --help
  else

    args=""
    pattern=""

    for arg in "${@}"; do
      if [[ ${arg:0:1} == "-" ]] ; then
        args="${arg} ${args}"
      else
        pattern="${arg}"
      fi
    done

    #    echo "#ARGS: $#"
    #    echo "ARGS: ${args}"
    #    echo "PATTERN: ${pattern}"

    if [[ $args == *-v* ]] ; then
      grep -rn ${args} "${pattern}" * | grep -v .svn | egrep -v "^Binary" 
    else
      grep -rn ${args} "${pattern}" * | grep -v .svn | egrep -v "^Binary" | egrep "${pattern}"
    fi
  fi
}
