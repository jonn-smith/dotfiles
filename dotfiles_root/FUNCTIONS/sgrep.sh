function sgrep () 
{

  if [[ $# != 3 ]] ; then
    echo "sgrep <include expression> <exclude expression> <file>"
    return 1;
  else
    grep $1 $3 | grep -v $2 | grep $1
  fi
}
