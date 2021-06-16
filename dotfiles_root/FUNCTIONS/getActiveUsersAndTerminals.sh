# Used to find out who is where so you can use `write` to annoy them:
function getActiveUsersAndTerminals () 
{
  local tmpOutFile
  local the_users
  local usr
  tmpOutFile=`mktemp`

  w | grep -v "load average:" | awk '{n=$1;$1=$5;$5=n; print}' | grep -v ^IDLE | perl -pe 's#^(\d+)days #24*3600*$1." "#ge' | perl -pe 's#^(\d+):(\d+)m #(3600*$1)+(60*$2)." "#ge' | perl -pe 's#^(\d+):(\d+) #(60*$1)+$2." "#ge' | sed 's#^\([0-9]*\)\.[0-9]*s #\1 #g' | sort -n > $tmpOutFile

  the_users=""
  while read line ; do
    usr=`echo $line | awk '{print $5}'`
    if [[ ! ${the_users} =~ ${usr} ]] ; then
      echo $line | awk '{l=$5;$5=$1;$1=l;l=$3;$3=$5;$5=l;print}' 
      the_users=${usr}:${the_users}
    fi
  done < $tmpOutFile | awk '{ for(i=1;i<=NF;i++) { if (i < 8) printf("%-18s", $i); else printf("%s%c",$i, (i==NF) ? ORS : ""); } }' 

  rm $tmpOutFile
}
