function packageDotfiles 
{
  # Make a place to save our dotfiles:
  timeStamp=$( date +%Y%m%dT%H%M%S )
  dotFileDir=~/DOTFILES_${timeStamp}

  echo "Creating folder for dotfiles (${dotFileDir})..."
  mkdir -p -v ${dotFileDir}

  # Get all our dotfiles to start with:
  echo "Archiving all dot files..."
  find ~ \( -type l -o -type f \) -maxdepth 1 -name .\* -exec cp -a -v {} ${dotFileDir} \;
  
  # Get the dotfiles root:
  echo "Archiving dotfiles root..."
  cp -a -v ~/.dotfiles_root ${dotFileDir}/.

	# Save some metadata about this machine:
	echo "Extracting machine metadata..."
	metadataFile=${dotFileDir}/README.metadata.txt

	echo "Dotfiles preserved on: ${timeStamp}" > ${metadataFile}
	echo "" >> ${metadataFile}
	echo "Machine Info:" >> ${metadataFile}
	echo "${HOSTNAME}" >> ${metadataFile}
	echo "$(uname -a)" >> ${metadataFile}
	echo "" >> ${metadataFile}
	echo "User Info:" >> ${metadataFile}
	echo "$(whoami)" >> ${metadataFile}
	echo "" >> ${metadataFile}

	# Set as read only:
	echo "Setting archival permissions..."
	chmod -R a-w ${dotFileDir}

  echo 'Done!'
}

