## Basic GIT setup ##
$email = Read-Host -Prompt 'GIT Email'
$username = Read-Host -Prompt 'GIT username'

git config --global user.email $email
git config --global user.name $username

Remove-Variable email
Remove-Variable username
