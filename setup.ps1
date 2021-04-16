## Basic GIT setup ##
$email = Read-Host -Prompt 'GIT Email'
$username = Read-Host -Prompt 'GIT username'

git config --file ./configs/git/.gitconfig.custom user.email $email
git config --file ./configs/git/.gitconfig.custom user.name $username

Remove-Variable email
Remove-Variable username
