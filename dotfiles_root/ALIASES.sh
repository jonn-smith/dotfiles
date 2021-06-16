#\[\033[40m\]

###############################################################################
##
## System specific aliases:
##
###############################################################################

if [[ `uname` == 'Darwin' ]] ; then
  alias cp='cp -p'
  alias ls='ls -GF';
  pr=$( sysctl -a | grep core_count | awk '{print $2}' )
else
  alias cp='cp --preserve=timestamps'
  alias ls='ls -F --color';
  #pr=`cat /proc/cpuinfo | egrep "processor" | awk '{print $3}'| sort -nr | head -n 1`; let pr=($pr)/2;
  pr=`cat /proc/cpuinfo | egrep "processor" | awk '{print $3}'| sort -nr | head -n 1`; let pr=($pr);
fi

# Set up make and bjam with the correct number of processors (we can be greedy and use them all):
if [[ $pr -eq 0 ]] ; then pr=1; fi
alias make="make -j${pr}"
alias make1="make -j1"
alias bjam="time bjam -j${pr}"

###############################################################################
##
## Project specific aliases:
##
###############################################################################

alias ka='echo "Keeping connection alive by tailing /dev/null";tail -vf /dev/null'

###############################################################################
##
## General timesaver aliases:
##
###############################################################################

#alias dir='ls --color=auto --format=vertical'
#alias vdir='ls --color=auto --format=long'

##IPTABLES STUFF:
#/sbin/iptables -I INPUT 1 -p tcp --dport %{stanag4607port} -m state --state NEW,ESTABLISHED -j ACCEPT
#/sbin/iptables -I OUTPUT 1 -p tcp --sport %{stanag4607port} -m state --state ESTABLISHED -j ACCEPT
#/sbin/service iptables save
#/sbin/service iptables restart

alias ec='epochConvert'

alias getline='getl'
alias u='up'

# Set up aliases for cols:
alias c1='cols 1'
alias c2='cols 2'
alias c3='cols 3'
alias c4='cols 4'
alias c5='cols 5'
alias c6='cols 6'
alias c7='cols 7'
alias c8='cols 8'
alias c9='cols 9'

alias enableMouse='printf "\033[?9h"'
alias disableMouse='printf "\033[?9l"'
alias getMouseInfo='read -n6 a; echo -n $a | hexdump -C'

alias ifconfig="ifconfig | sed 's#addr:#addr: #g'"

alias gitpp='git pull && git push'

#alias showFigletFonts="for f in \`find  \\\`figlet -I2\\\` | sort\`; do f=\`echo \$f | sed 's#.*/##g' | sed 's#\..*##g'\`; echo \"\${f}:\"; figlet -f \$f \$f > /tmp/figletTmp.txt; r=\$?; [ \$r -eq 0 ] && cat /tmp/figletTmp.txt; echo;echo; done"

alias exportGcloudCredentials='export GCS_OAUTH_TOKEN=`gcloud auth application-default print-access-token`'

alias whereami='curl -s https://ipvigilante.com/$(curl -s https://ipinfo.io/ip) | jq ".data.latitude, .data.longitude, .data.city_name, .data.country_name"'

alias vd='vimdiff'
alias svd='svn diff'

# Alias for tree depending on tree help:
tree --help 2>&1 | grep charset &> /dev/null
r=$?
if [[ $r -eq 0 ]] ; then
  alias tree='tree --charset=ASCII'
fi

alias findBinary='grep -Pn "[\x80-\xFF]"'

alias ssh='ssh -Y'

alias sl='screen -list'
alias sr='screen -r'

alias killmatlab='ps eaf | grep /atech/matlab-2010b/bin/ | grep -v grep | cols 2 | xargs kill'


#alias grep='grep --color'                     # show differences in colour
#alias egrep='egrep --color'

alias ll='ls -l'                              # long list
alias llh='ll -h'
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias lla='ls -lA'
alias lal='ls ./*'

alias lol='echo "HAHAHAHAHAHAHAHAHA"'

alias cls='clear;ls'
alias c='clear'

alias s='sudo'
alias hs='history | egrep $1'
alias wcl='wc -l'
alias j='jobs'
alias p='ps'
alias pj='ps;jobs;'
alias jp='ps;jobs;'
alias cd='if [[ $lastDir_cd != `pwd` ]] ; then lastDir_cd=`pwd`; fi; cd'
alias back='cd - > /dev/null'
alias b='back'

alias v='vim'
alias vt='vimto'

alias psu='ps eaf | egrep "^$USER|^$UID" | grep -v grep'
alias pst='ps eaf | grep -v grep | egrep $1'



alias umc='sync;sudo umount /media/card'

alias therapy='cat /dev/urandom | hexdump -C | grep "ca fe"'


alias getLargestFiles='du -ka / | sort -r -n | head -n 1000'

# Set up tar uninclude to NEVER tar up the SVN files in the directory:
# Add the tar uninclude if it
[ ! -e ~/tar.uninclude ] && (echo ".svn" > ~/tar.uninclude)
alias tar='tar -X ~/tar.uninclude'

# Make svn diff work with vimdiff by default:
if [ -e ~/.subversion ] ; then
  [ ! -e ~/svnvimdiff.sh ] && (echo -e '#!/bin/bash\nshift 5\nvimdiff "$@"' > ~/svnvimdiff.sh) && chmod +x ~/svnvimdiff.sh
  \grep '^diff-cmd' ~/.subversion/config &> /dev/null
  r=$?
  homeDir=`(cd ~/;pwd)`
  if [ $r -eq 0 ] ; then sed -i "s%^diff-cmd.*\$%diff-cmd = $homeDir/svnvimdiff.sh%g" ~/.subversion/config 
  else echo "" >> ~/.subversion/config &> /dev/null ; fi 
fi
alias svnx="svn ps svn:executable '*'"

# Statistical aliases:
alias mean="awk '{sum+=\$1} END {printf \"%02.9f\", sum/NR}'"
alias stdev="awk '{sum+=\$1; sumsq+=\$1*\$1} END {printf \"%02.9f\" sqrt(sumsq/NR - (sum/NR)**2)}'"
alias min="sort -n $1 | head -n 1"
alias max="sort -rn $1 | head -n 1"
alias median="sort -n $1 | awk '{count++; values[count]=\$1;} END { if (count % 2) print values[(NR)-((NR-1)/2)]; else print (values[NR-((NR)/2)] + values[NR-(NR/2)+1])/2;}'"
alias sum="awk '{sum+=\$1} END {print sum}'"
alias dif="awk 'p{print \$0-p}{p=\$0}'"

alias stats="awk '{count++; values[count]=\$1;sum+=\$1; sumsq+=\$1*\$1;} END {asort(values); print \"MIN:\",values[1]; print \"MAX:\",values[NR]; print \"MEAN:\",sum/NR;if (count % 2) print \"MEDIAN:\",values[(NR)-((NR-1)/2)]; else print \"MEDIAN\",(values[NR-((NR-1)/2)] + values[NR-(NR/2)+1])/2;print \"STDEV:\",sqrt(sumsq/NR - (sum/NR)**2); print \"NUM LINES:\",count;}'"

# Alias for timing stuff:
alias ttic='pStartTime=`date +%s.%N`';
alias ttock='pEndTime=`date +%s.%N`;pTotalTimeTaken=`echo "scale = 8; $pEndTime - $pStartTime" | bc`;echo "$pTotalTimeTaken"';

# Aliases for making code:
alias compile='g++ -g3 -fno-inline -O0'

# Mail that the last command has completed:
#NOTE: Need to fix email address:
alias notify='r=$?;history -w;s=$( tail -n 1 ~/.bash_history );echo -e "TASK COMPLETE:\n\n$( pwd )\n\n${s}\n\nReturn Status: $r\n\n$( whoami )@$( hostname ) on $( date ) \n\n\n" | mail -n -s "Task Complete [$( hostname )]!" __Z91e35c89Z__USER_NOTIFY_EMAIL__Zb802891efZ__'
alias zotify='r=$?;history -w;s=$( tail -n 1 ~/.bash_history );zenity --info --text="JOB DONE\n${s}\n@\n$(date)\nresult = $r" &'
alias saytify='r=$?;history -w;s=$( tail -n 1 ~/.bash_history | sed "s#;[ \t]*saytify##g");result="Success";if [[ $r -ne 0 ]] ; then result="Failure";fi;say "JOB DONE.  ${s} . ${result}" &'

#create a notification file that the notification daemon will read and send to your email address:
#file format:
#user name
#machine / host name
#task name
#full task command
#working directory
#time
#message to append to email [OPTIONAL]
alias createNotification='r=$?;history -w;fullTask=`tail -n 1 ~/.bash_history`; if [[ ${fullTask} =~ ^[[:blank:]]*createNotification[[:blank:]]*$ ]] ; then fullTask=`tail -n 3 ~/.bash_history | head -n 1`; fullTask="${fullTask}   returned = $r"; fi; f=`mktemp`;echo $USER > $f; echo `hostname` >> $f; echo $fullTask | awk "{print \$1}" >> $f; echo $fullTask >> $f; echo `pwd` >> $f; echo `date` >> $f;while [[ -e /home/jsmith/notifications/LOCKED ]] ; do sleep 0.5 ; done; touch /home/jsmith/notifications/LOCKED; mv $f ${HOME}/notifications/.; rm /home/jsmith/notifications/LOCKED'

###############################################################################
##
## Compiler calls:
##
###############################################################################

#alias makearm='make ARCH=arm CROSS_COMPILE=/opt/crosstool/gcc-4.1.0-glibc-2.3.2/arm-unknown-linux-gnu/bin/arm-unknown-linux-gnu- '
#alias makearm='make ARCH=arm CROSS_COMPILE=/opt/crosstool/gcc-4.4.2-glibc-2.3.6/arm-unknown-linux-gnu/bin/arm-unknown-linux-gnu- '
#alias makearm='make ARCH=arm CROSS_COMPILE=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/arm-unknown-linux-gnu/bin/arm-unknown-linux-gnu- '

#alias makearm='make ARCH=arm CROSS_COMPILE=/opt/codesourcery/arm-2009q3/bin/arm-none-linux-gnueabi- '


alias maps='telnet mapscii.me'

