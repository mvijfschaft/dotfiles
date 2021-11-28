# dotfiles
dotfiles for Windows, including Developer-minded system defaults. Built in PowerShell.

### Installation
1. Install Scoop
  ```powershell
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh') # Install Scoop
  ```
2. Install git
  ```powershell
  scoop install git
  ```
3. Clone repository

4. Install latest powershell core
```powershell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
```
5. Download the MesloLGS NF font:

    * [MesloLGS NF Regular.ttf](https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)

    * [MesloLGS NF Bold.ttf](https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf)

    * [MesloLGS NF Italic.ttf](https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf)

    * [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf)

6. Execute `install.ps1`

## Thanks to…

* @[Daniel Liuzzi](https://github.com/daniel-liuzzi/dotfiles/) for his dotfiles inspiration.
