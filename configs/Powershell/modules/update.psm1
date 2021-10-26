<#
  .SYNOPSIS
  Update powershell
#>
function Update-Powershell {
    iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
}