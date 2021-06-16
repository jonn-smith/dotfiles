function wrapxml () 
{ 

  echo "<HANDYDANDYGENERICXMLWRAPPER>"

  if [[ $# == 0 ]] ; then 

    while read data; do
      echo $data
    done

  else 

    for arg in $@ ; do
      cat $arg
    done

  fi

  echo "</HANDYDANDYGENERICXMLWRAPPER>"
}
