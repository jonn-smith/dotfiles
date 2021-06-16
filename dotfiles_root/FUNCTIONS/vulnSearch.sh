function vulnSearch()
{

  HELPSTRING='vulnSearch PROGRAMorLIBRARY [PROGRAMorLIBRARY] ... '

  if [[ $# -eq 0 ]] ; then
    echo "${HELPSTRING}"
    return 1
  fi

  doNumberOnly=false
  doStrict=false
  firstLoop=true

  # Get the width for our printf below:
  width=0
  for arg in $@ ; do

    case $arg in
      -n|-c)
        doNumberOnly=true
        continue
        ;;
      -s)
        doStrict=true
        continue
        ;;
      --help|-h|-help)
        echo $HELPSTRING
        return 0;
        ;;
      *)
        if $firstLoop ; then
          echo "Searching National Vulnerability Database for: "
          printf "    "
          firstLoop=false
        fi

        if [[ ${#arg} -gt $width ]] ; then
          width=${#arg}
        fi
        printf "$arg "
        ;;
    esac

  done
  echo
  echo

  tf=`mktemp`

  for p in $@ ; do

    case $p in 
      -n|-c|-s|--help|-h|-help)
        continue
        ;;
    esac

    pf=$( printf "%-${width}s" $p )

    if $doStrict ; then
      curl "http://web.nvd.nist.gov/view/vuln/search-results?adv_search=true&cves=on&cpe_product=cpe%3a%2f%3a%3a${p}" 2>/dev/null 1>$tf
    else
      curl "http://web.nvd.nist.gov/view/vuln/search-results?query=${p}&search_type=all&cves=on&" 2>/dev/null 1> $tf
    fi
    numRecords=$( \grep -o 'There are <strong>[0-9,]*</strong> matching records.' $tf | tr -d ',' | sed 's#.*<strong>\(.*\)</strong>.*#\1#g' )

    rm $tf

    echo "$pf $numRecords records found"

    if $doNumberOnly || [[ $numRecords -eq 0 ]] ; then
      continue
    fi

    for i in $( seq 0 20 $numRecords ) ; do
      if $doStrict ; then
        curl "http://web.nvd.nist.gov/view/vuln/search-results?adv_search=true&cves=on&cpe_product=cpe%3a%2f%3a%3a${p}&startIndex=${i}" 2>/dev/null | grep -E 'href="detail\?vulnId|<span class="label">Summary:</span>' | sed -e 's#.*\(CVE-[0-9][0-9][0-9][0-9]-[0-9]*\)<.*#\1#g' -e 's#.*Summary:</span>\(.*\)</p>.*#\1#g' | perl -pe "s#^\s*(CVE.*)[\\r\\n]*#${pf} \1#gm"  
      else
        curl "http://web.nvd.nist.gov/view/vuln/search-results?query=${p}&search_type=all&cves=on&startIndex=${i}" 2>/dev/null | grep -E 'href="detail\?vulnId|<span class="label">Summary:</span>' | sed -e 's#.*\(CVE-[0-9][0-9][0-9][0-9]-[0-9]*\)<.*#\1#g' -e 's#.*Summary:</span>\(.*\)</p>.*#\1#g' | perl -pe "s#^\s*(CVE.*)[\\r\\n]*#${pf} \1#gm" 
      fi
    done  

  done

}
