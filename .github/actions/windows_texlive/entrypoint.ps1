
$ErrorActionPreference = "Stop"

& latex -interaction=nonstopmode graphicscache.ins
if (-not $?)
{
    throw 'graphicscache compilation failed'
}

cd example

. .\test.ps1
