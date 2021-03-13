# These components will be loaded when running Microsoft.Powershell (i.e. Not Visual Studio)

$files = (ls -path "$path/components/" | where { $_.attributes -ne "directory" })

foreach($file in $files)
{  
	# Load the contents of the into the profile
	$fileContents = [string]::join([environment]::newline, (get-content -path $file.fullname)) 
	Invoke-Expression $fileContents
}
