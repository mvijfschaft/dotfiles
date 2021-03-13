function Confirm-Elevated {
  # Get the ID and security principal of the current user account
  $myIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $myPrincipal = new-object System.Security.Principal.WindowsPrincipal($myIdentity)
  # Check to see if we are currently running "as Administrator"
  return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

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
