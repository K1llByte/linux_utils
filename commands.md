# Commands

Manual for some commands and utilities 

### fdisk
```bash
# List all disks
fdisk -l

# Manipulate disk partition table
fdisk /dev/[device name]
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

___
## Simple commands
```bash
# Time counting
time <command>

# Sleep
sleep [seconds]

# Translate or delete characters
tr A B # Changes all A's to B's
```