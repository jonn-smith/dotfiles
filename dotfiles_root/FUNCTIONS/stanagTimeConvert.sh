function stanagTimeConvert() 
{
  for t in $@ ; do

    #75908978

    st=`echo "scale=3;$t/1000" | bc`
    h=`echo  "scale=0;($st/3600)" | bc`
    m=`echo  "($st%3600)/60" | bc | sed 's#\.*##g'`
    s=`echo  "scale=3;$st-($m*60)-($h*3600)" | bc`
    mil=`echo "$s" | sed 's#.*\.##g'`
    s=`echo $s | sed 's#\..*##g'`

    printf "Midnight + %02d:%02d:%02d.%s" $h $m $s $mil
    echo

  done
}
