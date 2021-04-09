#!/bin/bash

wget -O basic-miktex-x64.exe https://miktex.org/download/win/basic-miktex-x64.exe
./basic-miktex-x64.exe --unattended --auto-install=yes --shared --package-set=basic
echo "Done!"

