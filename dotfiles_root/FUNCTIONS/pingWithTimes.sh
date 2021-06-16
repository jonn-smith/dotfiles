#!/usr/bin/env bash

function pingWithTimes() 
{
	urls=$( echo "${@}" | sed -e 's#^http[s://]*##g' -e 's#www.##g' | tr ' ' '_' )
	of="$HOME/pingWithTimes_$(date +%Y%m%dT%H%M%S)_urls.log"

	echo "Verifying connectivity with ${@} :" | tee ${of}
	# The  system("") here is to force flushing to stdout after every print statement.
  # Taken from https://unix.stackexchange.com/a/83853
  #   (in response to https://unix.stackexchange.com/questions/33650/why-does-awk-do-full-buffering-when-reading-from-a-pipe) 
	#ping $@ | gawk '{print strftime("%Y-%m-%d @ %H:%M:%S -"), $0;  system("")}' | tee -a ${of}
	ping $@ | gawk "{print strftime(\"%Y-%m-%d @ %H:%M:%S [$(ifconfig | grep inet | grep -v inet6 | grep broadcast | awk '{print $2}' | head -n1)] -\"), \$0;  system(\"\")}" | tee -a ${of}
}

# Use this function with the matlab script below (usually ~/plotPingLatencies.m) to plot the statistics over time.
function createPingTimeCsv() 
{
	cat ~/pingWithTimes_* | grep 'bytes from' | awk '{print $1,$3,$(NF-1)}' | sed 's# time=#,#g' | tr '[ :\-]' ',' > pingTimes.csv
}


#%% Read in the data
#DATA = csvread('~/pingTimes.csv');
#
#times = datetime(DATA(:,1), DATA(:,2), DATA(:,3), DATA(:,4), DATA(:,5), DATA(:,6)); 
#latency=DATA(:,7);
#
#m = mean(latency);
#
#%% Plot the data
#
#badThreshold = .8; 
#highLatency = max(latency)*badThreshold;
#highLatency = 200;
#
#% Clear old plots:
#close all;
#
#figure;
#subplot(2,1,1);
#hold on;
#
#% Primary plot:
#plot( times, latency );
#
#% Mean plot:
#xl = xlim;
#yl = ylim;
#plot( xl, [m, m], '--', 'color', [.5, .5, .5] );
#xlim(xl);
#ylim(yl); 
#
#% Bad latency plot:
#plot( times(latency > highLatency), latency(latency > highLatency), 'or');
#
#grid on;
#xlabel('Date Time');
#ylabel('Ping Latency to Google (ms)');
#title('Internet Connection Latency Over Time');
#legend('Latency', sprintf('Mean Latency (%0.3f ms)', m), sprintf('High Latency (>%.0f ms)', highLatency));
#
#% Histogram of latencies:
#ax = subplot(2,1,2);
#histogram(latency, 30);
#set(ax,'YScale','log');
#grid on;
#xlabel('Ping Latency to Google (ms)');
#ylabel('Number of Pings');
#title('Connection Latency Distribution');
#


