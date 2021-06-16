function getports 
{
  netstat -lean | grep -v "^Proto" |  grep -v '^Active' | grep -v '^unix' | awk '{print $4}' | sed 's#.*:##g' | sort -n | uniq
}
