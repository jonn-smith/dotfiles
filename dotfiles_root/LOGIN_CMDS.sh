#\[\033[40m\]

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# File creation defaults:
umask u=rwx,g=rwx,o=rx

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

################################################################################
# Fix SVN global ignores when you log in:
if [[ -e ~/.subversion/config ]] ; then

	# Did we find global ignores already specified in our config file?
	grep '^[ \t]*global-ignores' ~/.subversion/config &> /dev/null 
	r=$?

	# If the return code is not 0, we did not find our global ignores string:
	if [[ $r -eq 1 ]] ; then
		# Add in our global ignores to the right line:
		n=$( \grep '^[#\t ]*global-ignores' ~/.subversion/config | \grep -o '^[0-9]*' )
		if [[ ${#n} -eq 0 ]] ; then
			echo "global-ignores = " >> ~/.subversion/config
		else
			sed "${n}iglobal-ignores = " ~/.subversion/config
		fi 
	fi
fi

################################################################################
# Save .bash_history from deletion:

hist_file=~/.bash_history
history_bak_folder=~/bash_history_logs
history_backup=${history_bak_folder}/$(date +%Y_%m_%d_%H%M%S)_bash_history.txt
mkdir -p ${history_bak_folder}
if [ ! -e "${history_backup}" ] || [ ${hist_file} -nt ${history_backup} ] ; then 

	# Make a subshell to copy the file without clobbering it:
	echo "Backing up ~/.bash_history to ${history_backup}"
	(set -o noclobber ; cp ~/.bash_history ${history_backup} ) 

#	# quick double-lock to not clobber the history backup file:
#	mkdir -p /var/lock
#	hist_lock="/var/lock/hist_lock"
#	if [[ ! -e /var/lock/hist_lock ]] ; then
#		sleep 0.1
#		if [[ ! -e /var/lock/hist_lock ]] ; then
#			touch /var/lock/hist_lock
#			cp -f ~/.bash_history ${history_backup}
#			rm -f /var/lock/hist_lock
#		fi
#	fi
fi

