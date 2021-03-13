# Set Computer Name (add extra.ps1)
if($env:COMPUTER_NAME) {
    (Get-WmiObject Win32_ComputerSystem).Rename($env:COMPUTER_NAME) | Out-Null
}

# Enable Windows 10 Sandbox
dism /online /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All

Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

# Enable Developer Mode
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithDevLicense" 1

# Bash on Windows
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Enable-WindowsOptionalFeature -Online -All -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
wsl --set-default-version 2

###############################################################################
### Security                                                                  #
###############################################################################

# General: Disable key logging & transmission to Microsoft: Enable: 1, Disable: 0
# Disabled when Telemetry is set to Basic
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Input\TIPC" "Enabled" 0

# Camera: Don't let apps use camera: Allow, Deny
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" "Value" "Deny"

# Microphone: Don't let apps use microphone: Allow, Deny
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" "Value" "Deny"


###############################################################################
### Explorer, Taskbar, and System Tray                                        #
###############################################################################

# Ensure necessary registry paths
if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Type Folder | Out-Null}
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Type Folder | Out-Null}

# Explorer: Show path in title bar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

# Explorer: Avoid creating Thumbs.db files on network volumes
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailsOnNetworkFolders" 1

# Taskbar: Disable small icons
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSmallIcons" 0

# Taskbar: Show colors on Taskbar, Start, and SysTray: Disabled: 0, Taskbar, Start, & SysTray: 1, Taskbar Only: 2
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" 1

# Titlebar: Disable theme colors on titlebar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" 1

# Recycle Bin: Disable Delete Confirmation Dialog
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "ConfirmFileDelete" 0

###############################################################################
### Default Windows Applications                                              #
###############################################################################
Write-Host "Configuring Default Windows Applications..." -ForegroundColor "Yellow"

Import-Module -Name Appx -UseWindowsPowerShell

function Remove-Package {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $package
  )

  Get-AppxPackage $package -AllUsers | Remove-AppxPackage
  Get-AppXProvisionedPackage -Online | Where-Object DisplayNam -like $package | Remove-AppxProvisionedPackage -Online
}

Remove-Package "Microsoft.3DBuilder" # Uninstall 3D Builder
Remove-Package "*.AutodeskSketchBook" # Uninstall Autodesk Sketchbook
Remove-Package "Microsoft.BingFinance" # Uninstall Bing Finance
Remove-Package "Microsoft.BingNews" # Uninstall Bing News
Remove-Package "Microsoft.BingSports" # Uninstall Bing Sports
Remove-Package "Microsoft.BingWeather" # Uninstall Bing Weather
Remove-Package "king.com.BubbleWitch3Saga" # Uninstall Bubble Witch 3 Saga
Remove-Package "king.com.CandyCrushSodaSaga" # Uninstall Candy Crush Soda Saga
Remove-Package "*.DisneyMagicKingdoms" # Uninstall Disney Magic Kingdoms
Remove-Package "DolbyLaboratories.DolbyAccess" # Uninstall Dolby
Remove-Package "*.Facebook" # Uninstall Facebook
Remove-Package "Microsoft.MicrosoftOfficeHub" # Uninstall Get Office, and it's "Get Office365" notifications
Remove-Package "Microsoft.GetStarted" # Uninstall Get Started
Remove-Package "*.MarchofEmpires" # Uninstall March of Empires
Remove-Package "Microsoft.Print3D" # Uninstall Print3D
Remove-Package "Microsoft.SkypeApp" # Uninstall Skype
Remove-Package "*.SlingTV" # Uninstall SlingTV
Remove-Package "Microsoft.MicrosoftSolitaireCollection" # Uninstall Solitaire
Remove-Package "Microsoft.Office.Sway" # Uninstall Sway
Remove-Package "*.Twitter" # Uninstall Twitter
Remove-Package "Microsoft.WindowsSoundRecorder" # Uninstall Voice Recorder
Remove-Package "Microsoft.WindowsPhone" # Uninstall Windows Phone Companion
Remove-Package "Microsoft.MicrosoftMahjong" # Uninstall Microsoft Mahjong
Remove-Package "5319275A.WhatsAppDesktop" # Uninstall Whatsapp
Remove-Package "613EBCEA.PolarrPhotoEditorAcademicEdition" # Uninstall Polarr
Remove-Package "WinZipComputing.WinZipDesktopSubscription" # Uninstall WinZip
Remove-Package "SiliconBendersLLC.Sketchable" # Uninstall Sketchable
Remove-Package "6F71D7A7.HotspotShieldFreeVPN" # Uninstall Hotspot Shield

# Prevent "Suggested Applications" from returning
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Type Folder | Out-Null}
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

###############################################################################
### Windows Update & Application Updates                                      #
###############################################################################

# Ensure Windows Update registry paths
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate" -Type Folder | Out-Null}
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" -Type Folder | Out-Null}

# Enable Automatic Updates
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoUpdate" 0

# Disable automatic reboot after install
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate" "NoAutoRebootWithLoggedOnUsers" 1
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" 1

# Configure to Auto-Download but not Install: NotConfigured: 0, Disabled: 1, NotifyBeforeDownload: 2, NotifyBeforeInstall: 3, ScheduledInstall: 4
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" "AUOptions" 3

# Include Recommended Updates
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" "IncludeRecommendedUpdates" 1

# Opt-In to Microsoft Update
$MU = New-Object -ComObject Microsoft.Update.ServiceManager -Strict
$MU.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"") | Out-Null
Remove-Variable MU
