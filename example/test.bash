#!/bin/bash

set -e

function process {
    input=$1
    output=$2
    shift 2

    # Remove cache dirs
    rm -Rf graphicscache nonstandard

    echo "::group::Running $* paper"
    $* -interaction=nonstopmode $input
    mv $input.pdf $output
    echo "::endgroup::"
}

export TEXINPUTS=..:

process paper paper_noshellescape_pdflatex.pdf pdflatex
process paper paper_noshellescape_lualatex.pdf lualatex
process paper paper_shellescape_pdflatex.pdf pdflatex -shell-escape
process paper paper_shellescape_lualatex.pdf lualatex -shell-escape

process nonstandard_cachedir paper_nonstandard_pdflatex.pdf pdflatex -shell-escape
process nonstandard_cachedir paper_nonstandard_lualatex.pdf lualatex -shell-escape

echo "::group::Checking file sizes"

ls -lha paper_*.pdf

function check_much_smaller_than {
    size1=$(stat --printf="%s" $1)
    size2=$(stat --printf="%s" $2)
    ok=$(( size1 < (size2/2)))
    if [[ $ok -ne 1 ]]; then
        echo "FAIL: File $1 is not much smaller than $2 ($size1 vs $size2)!"
        exit 1
    else
        echo "OK: $1 is much smaller than $2."
    fi
}

check_much_smaller_than paper_shellescape_pdflatex.pdf paper_noshellescape_pdflatex.pdf
check_much_smaller_than paper_shellescape_lualatex.pdf paper_noshellescape_lualatex.pdf
check_much_smaller_than paper_nonstandard_pdflatex.pdf paper_noshellescape_pdflatex.pdf
check_much_smaller_than paper_nonstandard_lualatex.pdf paper_noshellescape_lualatex.pdf

echo "::endgroup::"

