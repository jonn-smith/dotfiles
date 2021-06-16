function openGsPath() 
{
	P=""
  if [[ $# -eq 0 ]] ; then
    P=$( sed -e \
        '[/^http[s]*/ {
           s#^http[s]*://console.cloud.google.com/storage/browser/#GSREP# 
           s#^http[s]*://console.cloud.google.com/#GSREP#
           s#^http[s]*://storage.cloud.google.com/#GSREP#
        }
        /^gs:\/\// {
           s#^gs://#HTTPSREP#
        }
        /^GSREP/ {
           s#^GSREP#gs://#
        }
        /^HTTPSREP/ {
           s#HTTPSREP#https://console.cloud.google.com/storage/browser/#
				 }' -e 's#gs://_details/#gs://#' -e 's#?.*##' - )
  else
    P=$( echo "${1}" | sed -e \
      '/^http[s]*/ {
          s#^http[s]*://console.cloud.google.com/storage/browser/#GSREP# 
          s#^http[s]*://console.cloud.google.com/#GSREP#
          s#^http[s]*://storage.cloud.google.com/#GSREP#
       }
       /^gs:\/\// {
          s#^gs://#HTTPSREP#
       }
       /^GSREP/ {
          s#^GSREP#gs://#
       }
       /^HTTPSREP/ {
          s#HTTPSREP#https://console.cloud.google.com/storage/browser/#
				}' -e 's#gs://_details/#gs://#' -e 's#?.*##' )
  fi

	echo $P
	open ${P}
}
