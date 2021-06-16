# Download a full mirror of a given website.
function getWebsite() 
{

  rc=0;  

  webAddress=""

  if [[ $# -eq 0 ]] ; then
    read line
    webAddress=$line
  elif [[ $# -eq 1 ]] ; then
    webAddress=$1
  else
    echo "usage: getWebsite [WEBSITEADDRESS]"
    return 10
  fi

  echo ""
  echo "Downloading website: $webAddress"
  echo "WARNING: THIS MAY TAKE A WHILE."

  response=""
  while [[ $response != "y" ]] && [[ $response != "n" ]] ; do
    echo -n "Do you want to continue? [y/n]: " 
    read response
  done

  if [[ $response == "n" ]] ; then
    echo "Aborting download."
    return 0;
  fi

  python -c 'print "*"*80'

  echo "Download starting..."

  # Random wait time
  # recursively get the website
  # get all page requisites (i.e. images)
  # execute robots=off as if it were in the .wgetrc file
  # Identify wget as mozilla
  # -l = recur infinitely to get all internal pages
  # convert links to be usable
  # turn on timestamping (only get files if they're newer than the local copy)
  wget --random-wait -r -p -e robots=off -U mozilla -l 0 -k -N $webAddress

  # Only gets a single file
  #wget --random-wait -e robots=off -U mozilla -N $webAddress #Only gets a single file

  return $rc
}
