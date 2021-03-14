# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

win_user=`echo $(powershell.exe '$env:UserName') | sed ' s/\\r//g'`
export WIN_USER=$win_user

eval "$(oh-my-posh --init --shell bash --config /mnt/c/Users/$win_user/Repos/dotfiles/configs/oh-my-posh/mtheme.omp.json)"

mesg n 2> /dev/null || true
