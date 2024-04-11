function / { Set-Location '/' }
function \ { Set-Location '\' }
function ~ { Set-Location '~' }
function .. { Set-Location '..' }

function la { Get-ChildItem -Force @args }
function mcd { mkdir @args | Set-Location }

function guid { (New-Guid).ToString("D").ToLower() | Set-Clipboard }

Set-Alias -Name 'l' -Value 'Get-ChildItem'
Set-Alias -Name 'o' -Value 'Start-Process'
Set-Alias -Name 'open' -Value 'Start-Process'
