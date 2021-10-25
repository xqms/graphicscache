#!/bin/bash

set -e

echo "::group::Compiling graphicscache"
latex -interaction=nonstopmode graphicscache.ins
pdflatex -interaction=nonstopmode graphicscache.dtx
echo "::endgroup::"

(
cd example

./test.bash
)

echo "::group::Creating CTAN package"
ctanify --pkgname=graphicscache graphicscache.ins graphicscache.pdf README.md LICENSE
echo "::endgroup::"
