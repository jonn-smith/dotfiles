function absPath()
{
  for arg in $@; do
    if [[ ! -e $arg ]];  then
      echo "ERROR: Given path does not exist: $arg" 1>&2
      continue;
    fi

    python -c "import os; print os.path.abspath('$arg');"
  done
}
