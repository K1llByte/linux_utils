# Git

## Create Repository GitHub

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