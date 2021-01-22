# Git

## Clone
Clone a repository into a new directory

```bash
# Clone repository locally
# folder name will be the same as the repository
git clone <git:url>

# folder name will be the one specified
git clone <git:url> <dir_name>
```

### Branch

List, create, or delete branches

```bash
# List branches
git branch
# or
git branch -l

# Create new branch
git branch <branch_name>

# Rename branch
git branch -m <old_name> <new_name>

# Delete branch
git branch -m
```

### Checkout
Switch branches or restore working tree files

```bash
# Switch branch
git checkout <branch_name>

# Create a new branch and switch to it
git checkout -b <new_branch_name>
```


___

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
git commit -m "General commit"

# Set the origin to github with the url of a new repository
git remote add origin git@github.com:username/repo.git

# Push local data on branch 'master' to remote repository
git push -u origin master
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