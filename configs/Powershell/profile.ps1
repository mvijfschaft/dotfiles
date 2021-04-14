$configPath = (Get-Item $PSCommandPath).Target.Split("\Powershell\profile.ps1")[0];

Import-Module oh-my-posh
Import-Module posh-git
Import-Module PSColor
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
Import-Module PSReadLine
Import-Module Recycle

Set-PoshPrompt -Theme  "$configPath\oh-my-posh\mtheme.omp.json"

$files = (Get-ChildItem -path $configPath"\powershell\" | Where-Object { $_.attributes -ne "directory" -and (
      ($_.name -NotLike "profile*.ps1") -and  ($_.name -Like "*.ps1"))
})
foreach ($file in $files) { . $file }

. $configPath"\powershell\profile.custom.ps1"
