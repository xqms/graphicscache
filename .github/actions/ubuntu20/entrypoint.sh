#!/bin/bash

set -e

echo "Compiling graphicscache"
latex -interaction=nonstopmode graphicscache.ins

cd example

echo "Compiling example using pdflatex"
TEXINPUTS=..: pdflatex -interaction=nonstopmode paper

echo "Compiling example using lualatex"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode paper

