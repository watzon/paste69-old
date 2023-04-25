#!/bin/bash
# Paste69 CLI installer script

# Download the script
curl -s https://0x45.st/paste69.sh > paste69

# Check if the script was downloaded successfully
if [ $? -ne 0 ]; then
  echo "Error: failed to download the script"
  exit 1
fi

# Make the script executable
chmod +x paste69

# Move the script to /usr/local/bin
mv paste69 /usr/local/bin

# Run dependency checks, and warn if any are missing
if ! command -v curl &> /dev/null; then
  echo "Warning: curl is not installed"
fi

if ! command -v jq &> /dev/null; then
  echo "Warning: jq is not installed"
fi

# Show a success message
echo "Paste69 CLI installed successfully"
