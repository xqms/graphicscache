#!/bin/bash

echo "Downloading installer"
curl -o miktexsetup-x64.zip https://miktex.org/download/win/miktexsetup-x64.exe
echo "Unzipping"
unzip miktexsetup-x64.zip

echo "Running installer"
./miktexsetup_standalone.exe --verbose --local-package-repository=C:\miktex --package-set=basic download
echo "Done!"

ls -la C:/miktex

(
cd example

pdflatex -shell-escape paper
)

