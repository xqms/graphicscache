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

echo "Clearing cache..."
rm -Rf graphicscache

echo "Compiling nonstandard_cachedir using pdflatex"
TEXINPUTS=..: pdflatex -interaction=nonstopmode nonstandard_cachedir

echo "Compiling nonstandard_cachedir using lualatex"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode nonstandard_cachedir
