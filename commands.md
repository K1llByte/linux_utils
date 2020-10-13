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