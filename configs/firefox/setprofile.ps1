$firefoxProfiles = "$env:APPDATA/Mozilla/Firefox/"
$settings = Get-IniFile "$firefoxProfiles\profiles.ini"
$profilePath = "$firefoxProfiles/$($settings.Profile0.Path)"
if(!(Test-Path -Path $profilePath/chrome )) { New-Item $profilePath/chrome -ItemType "directory" | Out-Null }

New-Link "./userChrome.css" "$profilePath/chrome/userChrome.css"

Add-Content $profilePath/prefs.js "user_pref(""toolkit.legacyUserProfileCustomizations.stylesheets"", true);"