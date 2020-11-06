#!/bin/bash

# settemplate [tag] [path/to/file] \ Set file as template
# template [tag]                   \ Paste template in current dir
# template [tag] -o [dir|file]         \ Paste template with name 'name'
# templates                        \ List templates by name
# deltemplate [tag]                \ Delete template by name

TEMPLATES=~/.config/templates/

# TODO: Templates namespaces 'template cpp::main'

# Create Templates folder if not exists
[ ! -d "$TEMPLATES" ] && \
mkdir -p "$TEMPLATES"

settemplate()
{
    [ -z "$1" ] && >&2 echo "error: settemplate [tag] [file]" && return 1
    [ ! -f "$2" ] && >&2 echo "error: invalid file" && return 1
    
    # Check if template tag exists
    [ $(ls -lA "$TEMPLATES" | awk -v key="$1" '{ if($9 == key) print $9 }') ] && \
    >&2 echo "Template already exists" && return 1
    
    cp "$2" "$TEMPLATES$1"
    echo "Template set: $2"
}

template()
{
    [ -z "$1" ] && >&2 echo "error: template [tag] <OPTIONS> " && return 1

    chosen="./"
    if [ "$2" == "-o" ]; then
        [ ! -z "$3" ] && chosen="$3" || >&2 echo "error: value not specified" return 1
    fi
    local VAL=$(ls -lA $TEMPLATES | awk -v key="$1" '{ if($9 == key) print $9 }')
    [ -z "$VAL" ] &&  echo "error: template not found" && return 1

    cp "$TEMPLATES$VAL" "$chosen"
}

templates()
{
    list_templates=$(ls -lA "$TEMPLATES" | awk '{ print $9 }' | tail -n +2)
    
    case "$1" in
    "") # List templates
        echo "$list_templates"
    ;;

    *) # Find template by name
        echo "$list_templates" | grep -i "^${1}.*$"
    ;;
    esac
}

deltemplate()
{
    if [ -z "$1" ]; then
        >&2 echo "error: deltemplate [tag]"
    else
        template="$TEMPLATES$1"
        [ $(templates | grep "^$1$") ] && \
        rm "$template" #&&                 \
        #echo "Removed" || echo "Template does not exist"
    fi
}