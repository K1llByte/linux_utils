# Commands

Manual for some commands and utilities 

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


### grep
```bash
# Ignore case
grep -i "[search term]"
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
```