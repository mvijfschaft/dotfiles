echo "Initializing bash configuration ..."

echo "Update packages ..."
sudo apt-get update

sudo "Installing packages"
sudo apt-get install nano
# sudo apt-get install fonts-powerline

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Add windows username environment variable
win_user=`echo $(powershell.exe '$env:UserName') | sed ' s/\\r//g'`
export WIN_USER=$win_user

# TODO: Allow other repo location
sudo cp /mnt/c/Users/$win_user/Repos/dotfiles/configs/Ubuntu/.profile ~/.profile
sudo cp /mnt/c/Users/$win_user/Repos/dotfiles/configs/Ubuntu/local.conf /etc/fonts/local.conf
