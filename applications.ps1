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
scoop install docker-compose
scoop install dotnet-sdk
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
scoop install vscode-insiders
scoop install winrar
scoop install z

## PowerShell modules ##
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSColor -Scope CurrentUser
Install-Module -Name Recycle -Scope CurrentUser

Add-PoshGitToProfile

## Code Extensions (for correct settings) ##
code-insiders --install-extension GitHub.github-vscode-theme
code-insiders --install-extension vscode-icons-team.vscode-icons

## Npm ##
npm i -g cordova
npm install --global git-recent

## Add Fonts ##
scoop install cascadia-code
scoop install cascadia-code-pl
scoop install Meslo-NF

## Netcore tools ##
dotnet tool install -g dotnet-cleanup
dotnet tool install -g dotnet-search

New-Link ".\configs\git\.gitconfig" "~\.gitconfig"
New-Link ".\configs\vscode\settings.json" "$env:APPDATA\Code\User\settings.json"
New-Link ".\configs\vscode\keybindings.json" "$env:APPDATA\Code\User\keybindings.json"
New-Link ".\configs\vscode\settings.json" "$env:APPDATA\Code - Insiders\User\settings.json"
New-Link ".\configs\vscode\keybindings.json" "$env:APPDATA\Code - Insiders\User\keybindings.json"
New-Link ".\configs\windowsterminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
# https://github.com/microsoft/winget-cli/releases
New-Link ".\configs\winget\settings.json" "$env:LOCALAPPDATA\Microsoft\DesktopAppInstaller\LocalState\settings.json"
New-Link ".\configs\powershell\profile.ps1" $PROFILE.CurrentUserCurrentHost

## Add custom settings ##
New-Item-Check -Path ".\configs\git" -Name ".gitconfig.custom" -SymlinkPath "~\.gitconfig.custom"
$psPath = Split-Path $PROFILE.CurrentUserCurrentHost
New-Item-Check -Path ".\configs\powershell" -Name "profile.custom.ps1" -SymlinkPath "${psPath}\profile.custom.ps1"
Remove-Variable $psPath

## WINGET ##
winget install Docker.DockerDesktopEdge
winget install Microsoft.WindowsTerminalPreview -s msstore
winget install Microsoft.PowerToys
winget install Microsoft.PowerShell
winget install Mojang.MinecraftLauncher
