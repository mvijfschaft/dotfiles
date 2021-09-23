function run {
  $Command = $args.ForEach( {
      if ($_ -isnot [string]) { return $_ }
      $Qualify = $_.ToCharArray().ForEach( { [char]::IsWhiteSpace($_) -or $_ -in @('"', "'") } ).Contains($true)
      $Value = $_.Replace("'", "''")
      if ($Qualify) { "'$Value'" } else { $Value }
    } ) -join ' '

  if (!$Quiet) { Write-Host "> $Command" -ForegroundColor DarkGray }
  Invoke-Expression $Command
}

function quietly { $Quiet = $true; run @args }

function New-ItemCheck {
  param (
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $false)][string]$SymlinkPath
  )

  if ($Path -notmatch "/$" -or $Path -notmatch "\\$") {
    $Path += "\"
  }

  if (!(Test-Path $Path$Name)) {
    New-Item -Path $Path -Name $Name -Type File
  }

  if ($SymlinkPath) {
    New-Link $Path$Name $SymlinkPath
  }
}

function New-Link ($target, $source) {
  if (Test-Path $source) {
    if ((Get-Item $source).LinkType -eq 'SymbolicLink') {
      Remove-Item $source
    }
    else {
      Move-Item -Path $source -Destination "$source.bak" -Force
    }
  }

  New-Item -ItemType SymbolicLink -Path $source -Target (Resolve-Path $target)
}

function Confirm-Elevated {
  # Get the ID and security principal of the current user account
  $myIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $myPrincipal = new-object System.Security.Principal.WindowsPrincipal($myIdentity)
  # Check to see if we are currently running "as Administrator"
  return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

