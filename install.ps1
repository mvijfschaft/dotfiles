. "./configs/powershell/functions.ps1"

if (-Not (Confirm-Elevated)) {
  Write-Error -Message "you have to run this script with administrator rights" -Category PermissionDenied
}

Write-Host "Installing applications ..."
. "./applications.ps1"

Write-Host "Setup some parameters ..."
. "./setup.ps1"

Write-Host "Modify Windows configuration ..."
. "./windows.ps1"

Write-Host "Creating Windows tasks ..."
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-WindowStyle Hidden scoop update *"
Register-ScheduledTask -TaskName "Scoop Update" -User $env:UserName -Trigger  $trigger -Action $action

$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-WindowStyle Hidden scoop cleanup *"
Register-ScheduledTask -TaskName "Scoop Cleanup" -User $env:UserName -Trigger  $trigger -Action $action

Write-Host "Installation complete."
