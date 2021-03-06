#\[\033[40m\]

# Set the term to be something good.
export TERM=xterm;

# Needed for directories to be visible:
# See: http://linux-sxs.org/housekeeping/lscolors.html
export LS_COLORS='no=00:fi=00:di=1;94:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'

# Apparently this is a legacy option:
# Needed for color for Grep:
#export GREP_OPTIONS='--color=auto'

# History Path Variables:
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTSIZE=9999999999999
export HISTFILESIZE=99999999999999999999
export HISTTIMEFORMAT='%x::%X  ' 

# Default Editor: 
export EDITOR=vim

# Add relevant path locations:
export PATH=/sbin:/usr/sbin:~/scripts:~/bin:$PATH

