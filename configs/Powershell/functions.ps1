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

function New-ConsoleApp {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Path
  )

  if (Test-Path $Path) {
    throw "Path '$Path' already exists. Choose a different one."
  }

  $DirectoryInfo = mkdir $Path
  $OutputName = (Get-Culture).TextInfo.ToTitleCase($DirectoryInfo.Name)
  Set-Location $DirectoryInfo

  git init
  git commit --message="initial" --allow-empty

  dotnet new gitignore
  git add --all
  git commit --message="dotnet new gitignore"

  dotnet new console --name=$OutputName --output=.
  git add --all
  git commit --message="dotnet new console"

  edit . ./Program.cs
}

function New-Item-Check {
  param (
      [Parameter(Mandatory=$true)][string]$Path,
      [Parameter(Mandatory=$true)][string]$Name,
      [Parameter(Mandatory=$false)][string]$SymlinkPath
  )

  if ($Path -notmatch "/$" -or $Path -notmatch "\\$")
  {
    $Path += "\"
  }

  if(!(Test-Path $Path$Name))
  {
    New-Item -Path $Path -Name $Name -Type File
  }

  if($SymlinkPath)
  {
    New-Link $Path$Name $SymlinkPath
  }
}
