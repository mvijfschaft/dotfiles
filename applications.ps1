## Install programs ##
scoop bucket add extras
scoop bucket add nonportable
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add TheRandomLabs https://github.com/TheRandomLabs/Scoop-Bucket.git
scoop bucket add sushi https://github.com/kidonng/sushi

scoop update *

scoop install 7zip
scoop install adb
scoop install android-studio
scoop install autohotkey
scoop install calibre-normal
scoop install delta
scoop install filezilla
scoop install firefox-developer
scoop install musescore
scoop install nodejs
scoop install nodejs-np
scoop install spotify-latest
scoop install steam
scoop install sudo
scoop install telegram
scoop install vlc
scoop install vscode
scoop install winrar
scoop install z

## PowerShell modules ##
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSColor -Scope CurrentUser
Install-Module -Name Recycle -Scope CurrentUser

Add-PoshGitToProfile

## Npm ##
npm i -g cordova
npm install --global git-recent

## Add Fonts ##
scoop install cascadia-code
scoop install cascadia-code-pl
scoop install Meslo-NF

New-Link ".\configs\Git\.gitconfig" "~\.gitconfig"
New-Link ".\configs\VSCode\settings.json" "$env:APPDATA\Code\User\settings.json"
New-Link ".\configs\VSCode\keybindings.json" "$env:APPDATA\Code\User\keybindings.json"
New-Link ".\configs\WindowsTerminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
# https://github.com/microsoft/winget-cli/releases
New-Link ".\configs\WinGet\settings.json" "$env:LOCALAPPDATA\Microsoft\DesktopAppInstaller\LocalState\settings.json"
New-Link ".\configs\Powershell\profile.ps1" $PROFILE.CurrentUserCurrentHost

## Add custom settings ##
New-Item-Check -Path ".\configs\Git" -Name ".gitconfig.custom" -SymlinkPath "~\.gitconfig.custom"
$psPath = Split-Path $PROFILE.CurrentUserCurrentHost
New-Item-Check -Path ".\configs\Powershell" -Name "profile.custom.ps1" -SymlinkPath "${psPath}\profile.custom.ps1"
Remove-Variable $psPath

## WINGET ##
winget install Microsoft.WindowsTerminalPreview -s msstore
winget install Microsoft.PowerToys
winget install Microsoft.PowerShell
