#!/bin/bash

# gitall    \ Add, commit and push changes if theres a remote
# ga        \ git add
# gc        \ git commit
# gp        \ git push
# gch       \ git checkout
# gb        \ git branch
# gcl       \ git clone
# gm        \ git merge

# gpo \ git push -u origin $(git branch --show)

# gnf \ Git new feature
# - git checkout -b <name>
# - git push -u origin $(git branch --show)

gitall() 
{
    if [ ! -z "$1" ]; then
        git add . && git commit -m "$1" && git push
    else
        # git add . && git commit -m "General commit" && git push
        git add . && git commit --allow-empty-message && git push
    fi
}

alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gch="git checkout"
alias gb="git branch"
alias gcl="git clone"
alias gm="git merge"
alias gpo="git push -u origin $(git branch --show)"