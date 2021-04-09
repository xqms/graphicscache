
& latex graphicscache.ins

cd example

$env:TEXINPUTS="..:"

& pdflatex -shell-escape paper
