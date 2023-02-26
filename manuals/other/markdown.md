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
    * [Images](#Images)
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

### Images
```md
![Alt Text][image_url]

<!-- Or -->

<img src="image_url" alt="Alt Text" width="200" height="200"/>
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
<!-- Underline -->
<ins>Hello World!</ins>

<!-- Strikethrough -->
<s>Hello World!</s>

<!-- Colored text -->
<span style="color:#FF00FF">Pink</span>

<!-- Small text -->
<small>Hello World!</small>

<!-- Horizontal divided blocks -->
<div>
    <div style="float: left; width: 50%;">
        Text1
    </div>
    <div style="float: left; width: 50%;">
        Text2
    </div>
</div>

<!-- Small characters in superior and inferior positions -->
e<sup>-1</sup>
x<sub>0</sub>

<!-- Keyboard keys -->
<kbd>Alt</kbd> + <kbd>F4</kbd>

<!-- Dropdown box -->
<details>
    <summary>This is a dropdown box</summary>
    Hello World!
</details>
<!--
This box can be open by default
with '<details open>'
-->

<!-- Marked text -->
Hello <mark>World!</mark>

<!-- Audio player -->
<audio
    controls
    src="https://www.myinstants.com/media/sounds/fart-with-reverb_NcgStsA.mp3">
	 Couldn't load audio
</audio>

<!-- Video player -->
<video 
    controls muted
    width="550" height="200">
    <source
        src="https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
        type="video/mp4">
    Couldn't load video
</video>

<!-- Progress bar -->
<meter id="progress"
    min="0" max="100"
    low="33" high="66" optimum="80"
    value="78"/>
<!-- Or -->
<progress id="file" max="100" value="78"/>

<!-- Fieldset box -->
<fieldset>
<legend>Pretty box</legend>
This is text
</fieldset>
```
