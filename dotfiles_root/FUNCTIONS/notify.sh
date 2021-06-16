function notify()
{
  local r=$?
  local pfstring='PASS'
  [[ $r -ne 0 ]] && pfstring='FAIL'
  history -w
  local s=$( \tail -n5 ~/.bash_history | \grep -v '^#' | \tail -n2 )

  local SUBJECT="Task Complete [${HOSTNAME}] [${pfstring}]: $( echo ${s} | head -n1 ) "
  local MAILSERVER=None
  local PORT="25"

	if [[ "${MAILSERVER}" == "None" ]] ; then
		echo "ERROR: YOU MUST SET UP YOUR MAIL SERVER INFO IN THIS SCRIPT BEFORE USING IT." 1>&2
		return 77
	fi
		
  local MAILTO='__Z91e35c89Z__USER_NOTIFY_EMAIL__Zb802891efZ__'
  local MAILFROM=randy@${HOSTNAME}.com

  local dataFile=$(mktemp)
  echo -en "TASK COMPLETE:\r\n"  >> $dataFile
  echo -en "${HOSTNAME}:$(pwd)\r\n"  >> $dataFile
  echo -en " \r\n"  >> $dataFile
  echo -en "${s}\r\n"  >> $dataFile
  echo -en " \r\n"  >> $dataFile
  echo -en "RS: ${r}\r\n"  >> $dataFile
  echo -en " \r\n"  >> $dataFile
  echo -en "${USER}@${HOSTNAME} on $( date )\r\n"  >> $dataFile
  echo -en " \r\n"  >> $dataFile
  echo -en "==========================================================================\r\n"  >> $dataFile

  local artFile2=$(mktemp)
  echo "</pre><marquee scrolldelay=\"50\"><pre>" >> $artFile2
  echo "                     \`. ___" >> $artFile2
  echo "                    __,' __\`.                _..----....____" >> $artFile2
  echo "        __...--.'\`\`;.   ,.   ;\`\`--..__     .'    ,-._    _.-'" >> $artFile2
  echo "  _..-''-------'   \`'   \`'   \`'     O \`\`-''._   (,;') _,'" >> $artFile2
  echo ",'________________                          \`-._\`-','" >> $artFile2
  echo " \`._              \`\`\`\`\`\`\`\`\`\`\`------...___   '-.._'-:" >> $artFile2
  echo "    \`\`\`--.._      ,.                     \`\`\`\`--...__\-." >> $artFile2
  echo "            \`.--. \`-\`                       ____    |  |\`" >> $artFile2
  echo "              \`. \`.                       ,'\`\`\`\`\`.  ;  ;\`" >> $artFile2
  echo "                \`._\`.        __________   \`.      \\'__/\`" >> $artFile2
  echo "                   \`-:._____/______/___/____\`.     \\  \`" >> $artFile2
  echo "                               |       \`._    \`.    \\" >> $artFile2
  echo "                               \`._________\`-.   \`.   \\\`.___" >> $artFile2
  echo "                                                  \`------'\`" >> $artFile2
  echo "</pre></marquee><pre>" >> $artFile2

  DATA=$( cat ${dataFile} ${artFile2} )
  DATA="<pre>${DATA}</pre>"

  #### SEND MAIL via RAW TCP #######
  exec 3<>/dev/tcp/$MAILSERVER/$PORT 

  if [ $? -ne 0 ] ; then
    echo
    echo "ERROR: Cannot connect to the Mail Server";
    echo "Please check the servername and/or the port number"
    return 
  fi

  echo -en "HELO $HOSTNAME\r\n"  >&3 

  echo -en "MAIL FROM:$MAILFROM\r\n" >&3
  echo -en "RCPT TO:$MAILTO\r\n" >&3
  echo -en "DATA\r\n" >&3
  echo -en "From: \"[RANDY@${HOSTNAME}][${pfstring}] - Robotic Automated Notifying Daemon Yawl\" <$MAILFROM>\r\n" >&3
  echo -en "To: $MAILTO\r\n" >&3
  echo -en "MIME-Version: 1.0\r\n" >&3
  echo -en "Content-Type: text/html; charset=ISO-8859-1\r\n" >&3
  echo -en "Subject: $SUBJECT\r\n\r\n" >&3
  echo -en "<html><body style=\"font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;\">$DATA</body></html>\r\n" >&3
  echo -en ".\r\n" >&3

  echo -en "QUIT\r\n" >&3

  rm $dataFile $artFile 
}
