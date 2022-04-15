# Commands

Manual for some useful commands / options and utilities 

## Commands
- [ls](#ls)
- [fdisk](#fdisk)
- [NetworkManager](#NetworkManager)
- [grep](#grep)
- [lspci](#lspci)
- [realpath](#realpath)
- [wc](#wc)
- [watch](#watch)

### ls 
```bash
# -h Human readable size info
# -s Size
# --color=auto Color files by type
# -a List hidden files
# -A List hidden files (except ./ and ../)
# -l Long listing format
ls
```

### fdisk
```bash
# List all disks
fdisk -l

# Manipulate disk partition table
fdisk /dev/[device name]
```

### NetworkManager
```bash
# Terminal GUI for editing connections (normal connections)
nmtui

# GUI for editing connections (usually WPA-EAP)
nm-connection-editor
```


### curl
```bash
# -L flag will follow any redirect or 3XX code
curl -L <url>

# -s is silent mode, to avoid the download info prints
curl -s <url>

# Change user agent (some sites reject if none is present)
curl --user-agent 'Chrome/79' <url>

```

### grep
```bash
# -o Print match only
grep -o "[search term]"

# -i Ignore case
grep -i "[search term]"

# -q Quiet (outputs only the process exit code)
grep -q "[search term]"

# -A Print NUM lines of trailing context
grep -A <NUM> "[search term]"

# -B Print NUM lines of leading context
grep -B <NUM> "[search term]"

# -C Print NUM lines of trailing and leading context
grep -C <NUM> "[search term]"

# Find pattern in any file of the directory
grep -rnw '/path/to/dir' -e 'pattern'
```

### lspci
```bash
# Lists pci devices and corresponding kernel modules loaded (and supported ones)
lspci -k
```

### realpath
```bash
# File absolute path
realpath [filename]
```

### wc
More than 1 file may be passed as argument
```bash
# Count words
wc -w [filename]

# words -w
# bytes -c
# chars -m
# lines -l
```

### watch
```bash
# Watch the output of a command time to time
# -n<sec> execute every <sec> seconds
watch -n1 [command]
```

### htop
```bash
# Resource manager (CPU,MEMORY)
htop
```

### jq
```bash
# JSON Parser
jq '.'
# .                         unchanged input
# .foo, .foo.bar, .foo?     value at key
# .[], .[]?, .[2], .[10:15] array operation
# [], {}                    array/object construction
# length                    length of a value
# keys                      keys in an array
# ,                         feed input into multiple filters
# |                         pipe output of one filter to the next filter
# select(foo)               input unchanged if foo returns true
# map(foo)                  invoke filter foo for each input
# if-then-else-end          conditionals
# \(foo)                    string interpolation
```

### Dunst
```bash
# Turn off notifications
dunstctl set-paused true

# Turn on notifications
dunstctl set-paused false
```


### source and execute

**Sourcing** a script will run the commands in the _current_ shell process. <br/>
**Executing** a script will run the commands in a _new_ shell process.

```bash
# Sourcing
source script
. script

# Executing
./script
```

___
## Simple commands
```bash
# Time counting
time <command>

# Sleep
sleep [seconds]

# TODO
cut

# Translate or delete characters
tr A B # Changes all A's to B's

# Shift arguments
shift [n]

# Find file (filename may use wildcards)
find /path/to/dir -name "filename"

# Show hardware representation
lstopo

# Set keyboard layout
setxkbmap -layout pt
```

## Other
```bash
# Sync local file to remote machine
rsync -a dir user@host:/path/to/remote/dir

# Add a key manually if pacman has problems importing it
gpg --keyserver pool.sks-keyservers.net --recv-keys <key>

# Update keyring (if there's problems with PGP keys)
yay -S archlinux-keyring

# Show window info (need to click the window with mouse)
xprop

# OpenGL renderer
glxinfo | grep -E "OpenGL vendor|OpenGL renderer"


# Create symlink
ln -s <file> <symlink>

# Create hard link
ln <file> <symlink>

# List mounted devices
findmnt

# Generate slides
pandoc -t revealjs -s -i -o foo.html foo.md

# Connect to eduroam with nmcli
export NUM_ALUNO="a85272"; nmcli connection add type wifi con-name eduroam ifname wlp3s0  ssid "eduroam" -- wifi-sec.key-mgmt wpa-eap 802-1x.eap ttls 802-1x.identity $NUM_ALUNO@alunos.uminho.pt 802-1x.phase2-auth  mschapv2

# Nvidia GPU Usage and other info
nvidia-smi
```
