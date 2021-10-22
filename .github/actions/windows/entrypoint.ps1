
$ErrorActionPreference = "Stop"

&initexmf --set-config-value [MPM]AutoInstall=1

& latex -interaction=nonstopmode graphicscache.ins
if (-not $?)
{
    throw 'graphicscache compilation failed'
}

cd example

. .\test.ps1
