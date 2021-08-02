#!/bin/bash

set -e

echo "::group::Compiling graphicscache"
latex -interaction=nonstopmode graphicscache.ins
pdflatex -interaction=nonstopmode graphicscache.dtx
echo "::endgroup::"

(
cd example

echo "::group::Compiling example using pdflatex"
TEXINPUTS=..: pdflatex -interaction=nonstopmode paper
echo "::endgroup::"

echo "::group::Compiling example using lualatex"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode paper
echo "::endgroup::"

echo "::group::Clearing cache..."
rm -Rf graphicscache
echo "::endgroup::"

echo "::group::Compiling nonstandard_cachedir using pdflatex"
TEXINPUTS=..: pdflatex -interaction=nonstopmode nonstandard_cachedir
echo "::endgroup::"

echo "::group::Compiling nonstandard_cachedir using lualatex"
rm -f paper.aux
TEXINPUTS=..: lualatex -interaction=nonstopmode nonstandard_cachedir
echo "::endgroup::"
)

echo "::group::Creating CTAN package"
ctanify --pkgname=graphicscache graphicscache.ins graphicscache.pdf README.md LICENSE
echo "::endgroup::"

