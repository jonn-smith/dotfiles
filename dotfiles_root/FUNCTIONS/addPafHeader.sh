function addPafHeader() 
{
  (
    echo 'Q_NAME Q_LENGTH Q_START Q_END STRAND T_NAME T_LENGTH T_START T_END N_MATCH ALN_LEN MQ'
    if [[ $# -eq 0 ]] ; then
      cat - 
    else
      cat $@ 
    fi
  ) | column -t
}

