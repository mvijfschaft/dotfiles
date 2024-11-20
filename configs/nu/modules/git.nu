export alias g = git
export alias a      = g add
export alias aa     = a --all
export alias b      = g branch
export alias c      = g commit
export alias ca     = c --amend
export alias can    = ca --no-edit
export alias dt     = g difftool # allows "Alt+Right", but diff one file at a time
export alias dtd    = dt --dir-diff # diffs all files, but no "Alt+Right"
export alias gb     = g blame
export alias mt     = g mergetool

export alias pull   = g pull
export alias push   = g push --set-upstream

# def pull [@args] {
#     if quietly lgu --grep="^WIP$" { error "WIP commits found. Please unwip before pulling." }
#     g pull @args
# }
# 
# def push [@args] {
#     if quietly lgp --grep="^WIP$" { error "WIP commits found. Please unwip before pushing." }
#     g push --set-upstream
# }

# git log
export def lg [...args] {
    git log --pretty=%h»¦«%aN»¦«%s»¦«%aD ...$args
    | lines
    | split column "»¦«" sha1 committer desc merged_at
}

export alias lgr    = g log --reverse
export alias lgp    = lgr '"@{push}..HEAD"'
export alias lgpa   = lgr '"@{push}...HEAD"'
export alias lgu    = lgr '"@{upstream}..HEAD"'
export alias lgua   = lgr '"@{upstream}...HEAD"'