#!/bin/bash
# Paste69 CLI script

# Check if `curl` is installed
if ! command -v curl &> /dev/null; then
  echo "Error: curl is not installed"
  exit 1
fi

# Check if `jq` is installed
if ! command -v jq &> /dev/null; then
  echo "Error: jq is not installed"
  exit 1
fi

# Show help text
function show_help {
  echo "Usage:"
  echo "  paste69 <file> [options]"
  echo "Options:"
  echo "  -l, --language <language>  Set the language of the paste"
}

# Check if a file was provided
if [ -z "$1" ]; then
  echo "Error: no file provided"
  show_help
  exit 1
fi

# Check if the file exists, is empty, or is a directory
if [ ! -f "$1" ]; then
  echo "Error: file does not exist"
  exit 1
elif [ ! -s "$1" ]; then
  echo "Error: file is empty"
  exit 1
elif [ -d "$1" ]; then
  echo "Error: file is a directory"
  exit 1
fi

# Check if a language was provided
if [ ! -z "$2" ]; then
  if [ "$2" == "-l" ] || [ "$2" == "--language" ]; then
    if [ -z "$3" ]; then
      echo "Error: no language provided"
      show_help
      exit 1
    fi
    language="$3"
  else
    echo "Error: invalid option $2"
    show_help
    exit 1
  fi
fi

# Build the URL
url="http://localhost:3000/api/v1/paste"
if [ ! -z "$language" ]; then
  url="$url?language=$language"
fi

# Make the request
response=$(curl -s -X POST -H "Content-Type: text/plain" --data-binary "@$1" $url)

if [ $? -ne 0 ]; then
  echo "Error: $response"
  exit 1
fi

# Check if `success` is true
if [ $(echo $response | jq -r '.success') != "true" ]; then
  echo "Error: $(echo $response | jq -r '.error')"
  exit 1
fi

# Print the URL from `paste.link`
echo $(echo $response | jq -r '.paste.link')