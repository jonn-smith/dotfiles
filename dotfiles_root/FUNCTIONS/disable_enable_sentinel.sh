function disable_sentinel() {
	sudo chmod 000 /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/SentinelAgent.app/Contents/MacOS/SentinelAgent /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_updater /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_guard /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_helper
	ps aux | grep '/Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentinel' | awk '{print $2}' | xargs echo | xargs sudo kill -9
}

function enable_sentinel() {
	sudo chmod 555 /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/SentinelAgent.app/Contents/MacOS/SentinelAgent /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_updater /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_guard /Library/Sentinel/sentinel-agent.bundle/Contents/MacOS/sentineld_helper
}

