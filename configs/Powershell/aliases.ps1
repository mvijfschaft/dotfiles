# Aliases (autocomplete-friendly)
Set-Alias -Name 'console' -Value 'New-ConsoleApp'
Set-Alias -Name 'dn' -Value 'dotnet'
Set-Alias -Name 'g' -Value 'git'
Set-Alias -Name 'l' -Value 'ls'

# Utilities
Set-Alias -Name 'e' -Value 'edit'
Set-Alias -Name 'edit' -Value 'code'
Set-Alias -Name 'o' -Value 'open'

# Move to Recycle Bin instead of deleting
# https://www.powershellgallery.com/packages/Recycle
Set-Alias -Name 'del' -Value 'Remove-ItemSafely' -Option AllScope
Set-Alias -Name 'erase' -Value 'Remove-ItemSafely'
Set-Alias -Name 'rd' -Value 'Remove-ItemSafely'
Set-Alias -Name 'ri' -Value 'Remove-ItemSafely' -Force
Set-Alias -Name 'rm' -Value 'Remove-ItemSafely'
Set-Alias -Name 'rmdir' -Value 'Remove-ItemSafely'

# .NET CLI
function dna { dotnet add @args }
function dnap { dotnet add package @args }
function dnar { dotnet add reference @args }
function dnb { dotnet build @args }
function dnn { dotnet new @args }
function dnr { dotnet run @args }
function dnw { dotnet watch @args }
function dnwr { dotnet watch run @args }
function dnc { cleanup @args }
function dob { dnc -p "bin" -p "obj" }
function dns { dotnet search @args}

# Git
function Get-GitMainGranch {
  foreach ($branch in @('main', 'prod')) {
    if (git branch --list $branch) {
      return $branch
    }
  }
  return 'master'
}

function a { git add @args }
function aa { git add --all @args }
function b { git branch @args }
function c { git commit @args }
function ca { git commit --amend @args }
function can { git commit --amend --no-edit @args }

function clone($repository) {
  # TODO: Support all URLs syntaxes - https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a
  if ($repository -notmatch '^(?:git@.*?:|https://.*?/)(?<path>.*?)(?:.git)?$') { throw 'Unsupported URL syntax' }
  $directory = $Matches.path -replace '/', '_' # flatten path
  git clone -- $repository $directory
  Set-Location $directory
}

function co { git checkout @args }
function d { git diff @args }
function dd { git diff 'develop...HEAD' @args }
function ddx { git diff 'develop..HEAD' @args }
function dm { git diff "$(Get-GitMainGranch)...HEAD" @args }
function dmx { git diff "$(Get-GitMainGranch)..HEAD" @args }
function dr { git diff '@{push}...HEAD' @args }
function drx { git diff '@{push}..HEAD' @args }
function ds { git diff --staged @args }
function dt { git difftool @args } # allows "Alt+Right", but diff one file at a time
function dtd { git difftool --dir-diff @args } # diffs all files, but no "Alt+Right"

# git-flow
function gf { git flow @args }
function gff { git flow feature @args }
function gffd { git flow feature delete @args }
function gfff { git flow feature finish @args }
function gffp { git flow feature publish @args }
function gffs { git flow feature start @args }
function gfft { git flow feature track @args }
function gfid { git flow init -d }

function gh {
  git ls-files | ForEach-Object {
    New-Object psobject -Property ([ordered]@{
        Path    = (Resolve-Path -Path $_ -Relative)

        # https://stackoverflow.com/a/11729072/88709
        Commits = (git log --oneline -- $_ | Measure-Object).Count

        # https://stackoverflow.com/a/13598028/88709
        Oldest  = [System.DateTimeOffset]::Parse((git log --max-count=1 --format="%ai" --diff-filter=A -- $_))

        # https://stackoverflow.com/a/4784629/88709
        Newest  = [System.DateTimeOffset]::Parse((git log --max-count=1 --format="%ai" -- $_))
      })
  }
}

# git merge
function gmd { git merge develop @args }
function gmm { git merge "$(Get-GitMainGranch)" @args }

function gr { git recent @args }
function gra { git rebase --abort @args }
function grc { git rebase --continue @args }
function gri { git rebase --interactive @args }
function grid { git rebase --interactive develop @args }
function grim { git rebase --interactive (Get-GitMainGranch) @args }
function grd { git rebase develop @args }
function grm { git rebase (Get-GitMainGranch) @args }
function mt { git mergetool @args }
function sw { git show @args }

function lg { git log --pretty=small @args }
function lgd { git log --pretty=small --reverse 'develop..HEAD' @args }
function lgdx { git log --pretty=small --reverse 'develop...HEAD' @args }
function lgm { git log --pretty=small --reverse "$(Get-GitMainGranch)..HEAD" @args }
function lgmx { git log --pretty=small --reverse "$(Get-GitMainGranch)...HEAD" @args }
function lgr { git log --pretty=small --reverse '@{push}..HEAD' @args }
function lgrx { git log --pretty=small --reverse '@{push}...HEAD' @args }

function pull { git pull @args }
function push { git push @args }
function s { git status @args }
function show { git show @args }

# Visual Studio
function dob { Get-ChildItem bin, obj -Directory -Recurse | Remove-Item -Force -Recurse }

function sln {
  $path = Get-ChildItem *.sln -Recurse -Depth 1 -File | Select-Object -First 1
  if ($path) {
    Write-Output "Starting $path"
    Start-Process $path
  }
  else {
    Write-Error 'Solution file not found'
  }
}

# Navigation
function / { Set-Location '/' }
function \ { Set-Location '\' }
function ~ { Set-Location '~' }
function .. { Set-Location '..' }

# Miscellaneous
function la { Get-ChildItem -Force @args }
function mcd { Set-Location (mkdir @args) }
function open { if ($args) { Start-Process @args } else { Start-Process . } }

$env:COLORTERM = 'truecolor'
$env:COLUMNS = 170
$env:DELTA_PAGER = 'less -rFX'
$env:EDITOR = 'code --wait'
$ESC = "`e"
