function disable_jamf() {
	sudo chmod 000 /usr/local/jamf/bin/jamfAgent /usr/local/jamf/bin/jamf "/Library/Application Support/JAMF/Jamf.app/Contents/MacOS/JamfDaemon.app/Contents/MacOS/JamfDaemon"
	ps aux | grep -E "/usr/local/jamf/bin/jamf|JamfDaemon" | grep -v grep | awk '{print $2}' | xargs echo | xargs sudo kill -9
}

function enable_jamf() {
	sudo chmod 555 /usr/local/jamf/bin/jamfAgent /usr/local/jamf/bin/jamf "/Library/Application Support/JAMF/Jamf.app/Contents/MacOS/JamfDaemon.app/Contents/MacOS/JamfDaemon"
}

