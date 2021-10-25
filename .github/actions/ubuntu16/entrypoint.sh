#!/bin/bash

set -e

echo "Compiling graphicscache"
latex -interaction=nonstopmode graphicscache.ins

(
cd example

./test.bash
)
