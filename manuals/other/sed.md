# sed

sed (stream editor) is a Unix utility that edits text using a compact syntax.

This manual will summarize sed syntax and some usefull options.

## Basic syntax

<!-- ### Input / Output -->

sed receives input from stdin or can be called to operate on a file

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

### <ins>Use matched string</ins>

When matching a set of characters, they can be called in the script with a `&`

```bash
echo "Hello WORLD!" | sed 's/WORLD/HAPPY &/'
```

### <ins>Use subpatterns</ins>

When matching a set of characters, they can be called in the script with a `&`

```bash
echo "Hello WORLD!" | sed 's/WORLD/HAPPY &/'
```