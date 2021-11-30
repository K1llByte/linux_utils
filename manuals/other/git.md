# Git

- [Get commands](#git-commands)
  - [Commit](#commit)
  - [Restore](#restore)
  - [Rm](#rm)
  - [Clone](#clone)
  - [Branch](#branch)
  - [Checkout](#checkout)
  - [Merge](#merge)
  - [Diff](#diff)
  - [Log](#log)
- [Usefull combinations](#usefull-combinations)

## Git commands

### Commit
Record changes to the repository

```sh
# Commit staged changes with a message
git commit -m "<Commit Message>"

# Stage all tracked files and commit 
git commit -a -m "<Commit Message>"

# Commit but without comment
git commit --allow-empty-message

# Commit changes to previous commit
# Use only in local branches or local commits
git commit --amend
```

### Restore
Restore working tree files

```sh
# Restore all tracked files to last commit state
git restore .
```

### Rm
Remove files from the working tree and from the index

```sh
# Remove file from git and directory
git rm <filename>

# Remove file just from git
git rm --cached <filename>
```


### Clone
Clone a repository into a new directory

```sh
# Clone repository locally
# folder name will be the same as the repository
git clone <git:url>

# folder name will be the one specified
git clone <git:url> <dir_name>
```

### Branch
List, create, or delete branches

```sh
# List branches
git branch
# or
git branch -l

# Create new branch
git branch <branch_name>

# Rename branch
git branch -m <old_name> <new_name>

# Delete branch
git branch -d <branch_name>
```

### Checkout
Switch branches or restore working tree files

```sh
# Switch branch
git checkout <branch_name>

# Create a new branch and switch to it
git checkout -b <new_branch_name>
```

### Merge
Merge two or more branches

```sh
# Merge current branch with <branch_name>
git merge <branch_name>
```

### Diff
Show changes between commits

```sh
# Difference of what changed but not yet staged
git diff

# Difference of what is staged and the last commit
git diff --staged
```

### Log
Show commit logs

```sh
# Commit log with authors and date and commit message
git log

# Oneline verion of logs
git log --oneline
```

___

## Use
## Create Repository GitHub

It's required that the repository is previously created on the platform. <br/>
This could also be automated with help of the GitHub cli interface `gh`.

```bash
# Create git repository with local origin
git init

# Do things . . .

# Add all modifications of the repository to stage
git add .

# Commit changes with a message
git commit -m "Commit message"

# Set the origin to github with the url of a new repository
git remote add origin git@github.com:username/repo.git

# Push local data on branch 'master' to remote repository
git push -u origin master
# or
git push -u origin $(git branch --show')
```

*Or*

```bash
# Clone remote repository on your current directory
git clone git@github.com:username/repo.git

cd repo

# Do things . . .

# Add all modifications of the repository to stage
git add .

# Commit changes with a message
git commit -m "General commit"

# Push local data to remote repository
git push
```


<!-- 
# Git
  ## Subcommands
    ### Clone
    ### Add
    ### Merge
    ### Rebase
    ### Stash
  ## Combinations of commands
  
  ## Configurations (optional)
 -->


<!--
git add           | ga
git commit        | gc
git push          | gp
git checkout      | gch
git clone         | gcl
git diff          | gd
git diff --staged | gds
-->