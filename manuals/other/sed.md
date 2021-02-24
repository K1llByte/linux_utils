# sed

Sed (stream editor) is a Unix utility that edits text using a compact syntax.

This manual will summarize sed syntax and some usefull options.

## Basic syntax

<!-- 
Commands
Pattern flags
-->

<!-- ### Input / Output -->

Sed receives input from stdin or can be called to operate on a file

```bash
echo "Hello WORLD!" | sed 's/WORLD/World/'
# or
sed 's/WORLD/World/' file.txt
```

By default sed prints to stdout the results which can be piped to a file or the input file can be edited in place with the `-i` option.

```bash
sed 's/WORLD/World/' file.txt > new_file.txt
# or
sed -i 's/WORLD/World/' file.txt
```

### <ins>Multiple scripts</ins>

Multiple sed functionality can be added with the `-e` option.

```bash
echo "Hello WORLD!" | sed -e 's/WORLD/World/' -e 's/Hello/HELLO/'
```

### <ins>Alternative delimeteres</ins>

`_`,`:` or `|` can be used as an alternative to `/`

```bash
sed 's_WORLD_world_'
sed 's:WORLD:world:'
sed 's|WORLD|world|'
```

### <ins></ins>

### <ins>Use matched string</ins>

When matching a set of characters, they can be called in the script with a `&`

```bash
echo "Hello WORLD!" | sed 's/WORLD/HAPPY &/'
```

### <ins>Use subpatterns</ins>

Subpatterns of the matched string can also be called in the script with `\1-9`

```bash
echo "Hello WORLD!" | sed 's/\(Hello\) \(WORLD\)\(!\)/\3\2 \1/'
```

### <ins>Extended regular expressions</ins>

To be able to use literal regex the option `-r` must be specified (`-E` in OS X), this allows you to not need to use escaped parenthesis in the script

### <ins>/g - Global replacement</ins>

Sed only operates a match per line, to allow for multiple matches in a line the flag `/g` must be used.

```bash
echo -e "HELLO hello HELLO\nHELLO" | sed 's/HELLO/hello/g' 
```

### <ins>/1, /2, etc. Specifying which occurrence</ins>

