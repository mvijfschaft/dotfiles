## Install programs ##
scoop bucket add extras
scoop bucket add nonportable
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add TheRandomLabs https://github.com/TheRandomLabs/Scoop-Bucket.git
scoop bucket add sushi https://github.com/kidonng/sushi

scoop update *

scoop install adb
scoop install android-studio
scoop install autohotkey
scoop install calibre-normal
scoop install delta
scoop install docker-compose
scoop install filezilla
scoop install firefox-developer
scoop install Keypirinha
scoop install musescore
scoop install nodejs
scoop install nodejs-np
scoop install sudo
scoop install telegram
scoop install ventoy
scoop install vlc
scoop install winrar
scoop install z

## PowerShell modules ##
Install-Module -Name oh-my-posh -Scope CurrentUser -Force
Install-Module -Name posh-git -Scope CurrentUser -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -SkipPublisherCheck -Force
Install-Module -Name CompletionPredictor -Scope CurrentUser -Force
Install-Module -Name Recycle -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force

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
sudo scoop install Meslo-NF --global

## Netcore tools ##
dotnet tool install -g dotnet-cleanup
dotnet tool install -g dotnet-search

## WINGET ##
winget install Mojang.MinecraftLauncher
winget install Docker.DockerDesktopEdge
winget install --name "Windows Terminal Preview" -s msstore --accept-package-agreements
winget install --name "PowerToys (Preview)" -s winget --accept-package-agreements
winget install --Name Steam -s winget --accept-package-agreements
winget install Microsoft.dotnetPreview
winget install Microsoft.VisualStudioCode.Insiders
winget install --Name "7-Zip" -s winget --accept-package-agreements
winget install --id "Microsoft.VisualStudio.2022.Community-Preview" --accept-package-agreements -s winget

New-Link ".\configs\git\.gitconfig" "~\.gitconfig"
New-Link ".\configs\vscode\settings.json" "$env:APPDATA\Code\User\settings.json"
New-Link ".\configs\vscode\keybindings.json" "$env:APPDATA\Code\User\keybindings.json"
New-Link ".\configs\vscode\settings.json" "$env:APPDATA\Code - Insiders\User\settings.json"
New-Link ".\configs\vscode\keybindings.json" "$env:APPDATA\Code - Insiders\User\keybindings.json"
New-Link ".\configs\windowsterminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
New-Link ".\configs\windowsterminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
# https://github.com/microsoft/winget-cli/releases
New-Link ".\configs\winget\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
New-Link ".\configs\powershell\profile.ps1" $PROFILE.CurrentUserCurrentHost
New-Link ".\configs\keypirinha\Keypirinha.ini" "~\scoop\apps\Keypirinha\current\portable\Profile\User\Keypirinha.ini"
New-Link ".\configs\ahk\AutoHotkeyU64.ahk" "~\Documents\AutoHotkeyU64.ahk"
New-ItemCheck -Path ".\configs\ahk" -Name "AutoHotkeyU64.custom.ahk" -SymlinkPath "~\Documents\AutoHotkeyU64.custom.ahk"
New-Link ".\configs\PowerToys\keyboard-default.json" "$env:LOCALAPPDATA\Microsoft\PowerToys\Keyboard Manager\default.json"

## Add custom settings ##
New-ItemCheck -Path ".\configs\git" -Name ".gitconfig.custom" -SymlinkPath "~\.gitconfig.custom"
$psPath = Split-Path $PROFILE.CurrentUserCurrentHost
New-ItemCheck -Path ".\configs\powershell" -Name "profile.custom.ps1" -SymlinkPath "${psPath}\profile.custom.ps1"
Remove-Variable $psPath

