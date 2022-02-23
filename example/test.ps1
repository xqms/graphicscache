
$env:TEXINPUTS="${pwd}\..;"

function ProcessTex {
    param (
        [Parameter(Mandatory)][string] $inputName,
        [Parameter(Mandatory)][string] $outputName,
        [Parameter(Mandatory)][string] $latexCommand,
        [parameter(ValueFromRemainingArguments = $true)]
        [string[]]$args
    )

    # Remove cache dirs
    if (Test-Path ".\graphicscache")
    {
        Remove-Item ".\graphicscache" -Recurse
    }
    if (Test-Path ".\nonstandard")
    {
        Remove-Item ".\nonstandard" -Recurse
    }

    echo "::group::Running $latexCommand $args -interaction=nonstopmode $inputName"
    & $latexCommand @args -interaction=nonstopmode $inputName
    if ($LastExitCode -ne 0)
    {
        throw "Fail!"
    }
    echo "::endgroup::"

    $inputPDF = "${inputName}.pdf"
    Move-Item -Path $inputPDF -Destination $outputName
}

ProcessTex paper paper_noshellescape_pdflatex.pdf pdflatex
ProcessTex paper paper_noshellescape_lualatex.pdf lualatex
ProcessTex paper paper_shellescape_pdflatex.pdf pdflatex -shell-escape
ProcessTex paper paper_shellescape_lualatex.pdf lualatex -shell-escape

ProcessTex nonstandard_cachedir paper_nonstandard_pdflatex.pdf pdflatex -shell-escape
ProcessTex nonstandard_cachedir paper_nonstandard_lualatex.pdf lualatex -shell-escape

echo "::group::Checking file sizes"

Get-Item paper_*.pdf

function CheckMuchSmallerThan {
    param (
        [Parameter(Mandatory)][string] $file1,
        [Parameter(Mandatory)][string] $file2
    )
    $size1 = (Get-Item $file1).length
    $size2 = (Get-Item $file2).length
    $sizeThreshold = $size2 * 3 / 4
    if($size1 -lt $sizeThreshold)
    {
        echo "OK: $file1 is much smaller than $file2."
    }
    else
    {
        throw "FAIL: File $1 is not much smaller than $2 ($size1 vs $size2, threshold $sizeThreshold)!"
    }
}

CheckMuchSmallerThan paper_shellescape_pdflatex.pdf paper_noshellescape_pdflatex.pdf
CheckMuchSmallerThan paper_shellescape_lualatex.pdf paper_noshellescape_lualatex.pdf
CheckMuchSmallerThan paper_nonstandard_pdflatex.pdf paper_noshellescape_pdflatex.pdf
CheckMuchSmallerThan paper_nonstandard_lualatex.pdf paper_noshellescape_lualatex.pdf

echo "::endgroup::"
