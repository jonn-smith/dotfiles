#\[\033[40m\]

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETTINGS_DIR="${SCRIPTDIR}/OS_SPECIFIC_SETTINGS"
osName=`uname`

# If we have settings to use, use them:
[[ -e ${SETTINGS_DIR}/${osName}.sh ]] && source ${SETTINGS_DIR}/${osName}.sh

