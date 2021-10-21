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

echo "Compiling example using pdflatex with shell-escape"
TEXINPUTS=..: pdflatex -interaction=nonstopmode -shell-escape paper

echo "Compiling example using lualatex with shell-escape"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode -shell-escape paper

echo "Clearing cache..."
rm -Rf graphicscache

echo "Compiling nonstandard_cachedir using pdflatex"
TEXINPUTS=..: pdflatex -interaction=nonstopmode -shell-escape nonstandard_cachedir

echo "Compiling nonstandard_cachedir using lualatex"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode -shell-escape nonstandard_cachedir
