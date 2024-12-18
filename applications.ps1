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
scoop install Keypirinha
scoop install musescore
scoop install nvm
scoop install sudo
scoop install telegram
scoop install ventoy
scoop install vlc
scoop install wincompose
scoop install winrar
scoop install z
scoop install zoxide
scoop install helix

scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json

nvm install latest
nvm on

## PowerShell modules ##
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -SkipPublisherCheck -Force
Install-Module -Name CompletionPredictor -Scope CurrentUser -Force
Install-Module -Name Recycle -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force

Add-PoshGitToProfile

## Npm ##
npm i -g cordova
npm install --global git-recent

## Add Fonts ##
scoop install cascadia-code --global
scoop install cascadia-code-pl --global
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

## Code Extensions (for correct settings) ##
code-insiders --install-extension GitHub.github-vscode-theme
code-insiders --install-extension vscode-icons-team.vscode-icons

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
New-Link ".\configs\ahk\dotfiles.ahk" "~\Documents\dotfiles.ahk"
New-Link ".\configs\PowerToys\keyboard-default.json" "$env:LOCALAPPDATA\Microsoft\PowerToys\Keyboard Manager\default.json"
New-Link ".\configs\WinCompose\.XCompose" "~\.XCompose"
New-Link ".\configs\wsl\.wslconfig" "~\.wslconfig"
New-Link ".\configs\nu\config.nu" "$env:APPDATA\nushell\config.nu"
New-Link ".\configs\nu\.zoxide.nu" "~\.cache\.zoxide.nu"
New-Link ".\configs\nu\starship.nu" "~\.cache\starship\init.nu"

## Add custom settings ##
New-ItemCheck -Path ".\configs\git" -Name ".gitconfig.custom" -SymlinkPath "~\.gitconfig.custom"
$psPath = Split-Path $PROFILE.CurrentUserCurrentHost
New-ItemCheck -Path ".\configs\powershell" -Name "profile.custom.ps1" -SymlinkPath "${psPath}\profile.custom.ps1"
Remove-Variable $psPath
