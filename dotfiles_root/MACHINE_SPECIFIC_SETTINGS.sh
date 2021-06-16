#\[\033[40m\]

if [[ "${HOSTNAME}" == "EXAMPLE_MACHINE_1" ]] ; then 
	
	echo "SETTINGS FOR EXAMPLE_MACHINE_1"

elif [[ "${HOSTNAME}" == "EXAMPLE_MACHINE_2.DOMAIN.org" ]] || [[ "${HOSTNAME}" == "EXAMPLE_MACHINE_2" ]] ; then

	echo "SETTINGS FOR EXAMPLE_MACHINE_1"

fi 

