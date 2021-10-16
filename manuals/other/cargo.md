# cargo

Cargo is the package manager and crate host for rust.

This manual will summarize *cargo* main commands and some usefull options.

## Init

```bash
# If folder is already created initialize project files
cargo init
```

## New

```bash
# Creates new project (folder, git)
# default: Binary
cargo new <project_name>

# Creates new binary project (folder, git)
cargo new <project_name> --bin

# Creates new library project (folder, git)
cargo new <project_name> --lib

# Creates new project without git
cargo new <project_name> --vcs none
```

## Build

```bash
# Builds project
cargo build

# Builds project with optimizations
cargo build --release
```

## Run

```bash
# Compiles in debug (if not compiled) and then runs
cargo run
```