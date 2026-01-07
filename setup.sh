#!/bin/bash

# Set default version if not provided
SUITEVERSION=${SUITEVERSION:-"8.9.1"}

do_init () {
  echo "Downloading SuiteCRM version $SUITEVERSION"
  
  FILENAME="SuiteCRM-${SUITEVERSION}.zip"
  
  DOWNLOAD_URL="https://sourceforge.net/projects/suitecrm/files/v${SUITEVERSION}/SuiteCRM-${SUITEVERSION}.zip/download"
  echo "Trying URL: $DOWNLOAD_URL"
  
  wget -q --show-progress -O "$FILENAME" "$DOWNLOAD_URL"
  DOWNLOAD_STATUS=$?
  
  if [ $DOWNLOAD_STATUS -ne 0 ]; then
    echo "First URL failed, trying alternative URL pattern..."
    DOWNLOAD_URL="https://sourceforge.net/projects/suitecrm/files/SuiteCRM-${SUITEVERSION}.zip/download"
    echo "Trying URL: $DOWNLOAD_URL"
    wget -q --show-progress -O "$FILENAME" "$DOWNLOAD_URL"
    DOWNLOAD_STATUS=$?
  fi
  
  if [ $DOWNLOAD_STATUS -eq 0 ]; then
    echo "Download completed successfully"
    echo "Extracting $FILENAME"
    
    # Extract to suitecrm directory
    unzip -o -q "$FILENAME" -d suitecrm/
    
    if [ $? -eq 0 ]; then
      echo "Extraction completed successfully"
      rm -f "$FILENAME"
      echo "Cleanup completed"
    else
      echo "Error: Extraction failed"
      exit 1
    fi
  else
    echo "Error: Download failed from both URL patterns"
    echo "Tried:"
    echo "  1. https://sourceforge.net/projects/suitecrm/files/v${SUITEVERSION}/SuiteCRM-${SUITEVERSION}.zip/download"
    echo "  2. https://sourceforge.net/projects/suitecrm/files/SuiteCRM-${SUITEVERSION}.zip/download"
    exit 1
  fi
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  do_init
fi
