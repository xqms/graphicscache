
& latex -interaction=nonstopmode graphicscache.ins
if (-not $?)
{
    throw 'graphicscache compilation failed'
}

$env:TEXINPUTS="${pwd};"

cd example

& pdflatex -interaction=nonstopmode -shell-escape paper
if (-not $?)
{
    throw 'pdflatex failed'
}

& pdflatex -interaction=nonstopmode -shell-escape nonstandard_cachedir
if (-not $?)
{
    throw 'pdflatex failed'
}
