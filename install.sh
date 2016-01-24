#!/bin/sh

# Illustrator default template folder:
INSTALL_DIR="$(cd /Applications/Adobe\ Illustrator*/Presets.localized/en_US/Swatches/; pwd)/@mhulse";

# Remote repo zip file containing all templates:
SOURCE_ZIP="https://github.com/mhulse/swatches/tarball/master";

# Clean previous installs:
rm -rf "$INSTALL_DIR";

# Create installation folder:
mkdir -pv "$INSTALL_DIR";

# Get the zip file and extract all template files:
curl -sS -#L "$SOURCE_ZIP" | tar -xzv --strip-components 1 -C "$INSTALL_DIR" "*.ase";

# Done!
# For more information about this script, see:
# https://github.com/mhulse/illy-profiles
