#!/bin/bash

# http://www.unixcl.com/2008/03/creating-menus-using-select-bash.html
# http://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_06.html
# http://unix.stackexchange.com/questions/257290
# http://www.thegeekstuff.com/2010/07/bash-case-statement/

# Install files:
function install() {
	
	# Installation folder:
	target="@mhulse"
	
	# Illustrator default template folder:
	INSTALL_DIR="/Applications/$1/Presets.localized/en_US/Swatches/"
	
	# Navigate to the installation directory:
	cd "$INSTALL_DIR"
	
	# Clean previous installs:
	rm -rf "./$target"
	
	# Create installation folder:
	mkdir -pv "$target"
	
	# Remote repo zip file containing all templates:
	SOURCE_ZIP="https://github.com/mhulse/swatches/tarball/master"
	
	# Get the zip file and extract all template files:
	curl -sS -#L "$SOURCE_ZIP" | tar -xzv --strip-components 1 -C "./$target" "*.ase";
	
	# Let the use know that we are done:
	echo $'\n'"Congrats! Installation was successful!"$'\n'
	
	# Open installation folder:
	open "./$target"
	
}

# Check if Illustrator is installed:
function check() {
	
	for f in "$1"; do
		
		# Check if the glob gets expanded to existing files.
		# If not, f here will be exactly the pattern above
		# and the exists test will evaluate to false.
		[ -e "$f" ] && return 0  || return 1 # 0 = true, 1 = false
		echo "loop"
		
	done
	
}

# Pick Illustrator version:
function choose() {
	
	# Set the prompt string used by `select`:
	PS3=$'\n'"Enter a number: "
	
	echo "Please pick the version of Illustrator"
	echo "you would like to install these files to:"$'\n'
	
	select folder in "Cancel" "$1"
		do
			case $folder in
				"Cancel")
					# User cancled:
					echo "Exiting …"
					exit
					;;
				*[![:blank:]]*)
					# Not blank or empty and is set:
					echo $'\n'"Installing files into $folder …"$'\n'
					break
					;;
				*)
					# Contains only blanks, is empty or unset:
					echo $'\n'"Your choice (${REPLY}) does not exist!"
					echo "Please try again or enter 1 to cancel."
					;;
			esac
		done
	
}

# Tidy up the terminal window:
clear

# Switch to glob folder location:
cd "/Applications"

if check "Adobe Illustrator"*; then
	
	# Create menu:
	choose "Adobe Illustrator"* # `$folder` is now a global.
	
	install "$folder"
	
else
	
	echo "Sorry, but Illustrator is not installed."
	echo "Please install Illustrator and try again."$'\n'
	
fi

# Exit program:
exit 0

# Done!
# For more information about this script, see:
# https://github.com/mhulse/illy-templates
