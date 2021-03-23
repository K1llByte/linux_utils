# Markdown

Markdown is a simple markup language for text formating


## Index

* [Basic Syntax](#Basic-Syntax)
    * [Headers](#Headers)
    * [Modifiers](#Modifiers)
    * [Items List](#Items-List)
    * [Horizontal Separator](#Horizontal-Separator)
    * [Line break](#Line-break)
    * [Tables](#Tables)
    * [Blockquotes](#Blockquotes)
* [HTML Extensions](#HTML-Extensions)
    


## Basic Syntax

Original designed syntax for markdown documents

### Headers
```md
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6
```

### Modifiers
<!-- NOT Basic Syntax -->
<!-- <ins>Underline</ins> -->
```md
**Bold** or __Bold__
*Italic* or _Italic_
~~Strikethrough~~
```

### Items List
```md
- Item 1
- Item 2
- Item 3
```

### Horizontal Separator
```md
___
```

### Line break

```md
<!-- Two spaces after text (trailing whitespace) -->
Text1  
Text2
<!-- or -->
Text1<br/>
Text1
```

### Tables
```md
| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
```

### Blockquotes
```md
<!--  -->
> ##### This is a blockquote
>
> This is the next paragraph of the blockquote
> - Topic 1
> - Topic 2
>
>  *Everything* is going according to **plan**.

```

## HTML Extensions

```md
<!-- Colored text -->
<span style="color:#FF00FF">Pink</span>

<!-- Horizontal divided blocks -->
<div>
    <div style="float: left; width: 50%;">
        Text1
    </div>
    <div style="float: left; width: 50%;">
        Text2
    </div>
</div>

<!-- Small characters in superior and inferior opsitions -->
e<sup>-1</sup>

<!-- Underline -->
<ins>Hello World!</ins>

<!-- Keyboard Keys -->
<kbd>Alt</kbd> + <kbd>F4</kbd>
```