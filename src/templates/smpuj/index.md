@def title = "Franklin Example"
@def tags = ["syntax", "code"]



# SMP UJ theme
\duallang{

This theme provides a template that:
 - Is responsive (works well on mobile devices).
 - Supports two languages.
 - All styling (colours, fonts, text size) can be changed by modifying a few variables, \\ similarly to a LaTeX preamble.
 - As an additional feature, it now supports light/dark mode.

This template doesn't remember the chosen language and light/dark mode when going to subpages.
See [Optional JavaScript](#optional_javascript) section on how to enable it.
}{
Ten szablon umożliwia stworzenie strony, która:
 - Jest responsywna (poprawnie wyświetla się na urządzeniach mobilnych).
 - Treść może być napisana w dwóch językach.
 - Estetyka (kolory, czcionki, rozmiar tekstu) może być zmieniona przez modyfikację kilku zmiennych. Podobnie jak preambuła w LaTeX-u.
 - Jako dodatkowa funkcjonalność, strona wspiera tryb jasny i ciemny.

Aktualnie szablon nie zapamiętuje języka oraz trybu jasny/ciemny prze przechodzeniu na podstronę.
Instrukcje do włączenia tej funkcjinalności są w sekcji [Optional JavaScript](#optional_javascript) poniżej.
}


## Multi-language support

The language is changed using the button in the bottom left.
Your chosen language is not remembered when clicking on a link to a different subpage; see [Optional JavaScript](#optional_javascript) section on how to enable it. 

Currently, the two languages are English (en) and Polish (pl).
To change the appearance of the button, edit `_css/dual-lang.css`,
find `content: "pl"` and change it to whatever you like; Unicode flags also work :).

To use multi-language, just use the predefined macro.
```LaTeX
\duallang{
English content
}{
Corresponding content in the second language
}
```
Inside the macro, you can put basically anything, including headers and images.

In pure HTML, you just need to use the following divs.
```html
&lt;div class="lang-en"&gt;
    English content
&lt;/div&gt;
&lt;div class="lang-native"&gt;
    Corresponding content in the second language
&lt;/div&gt;
```

\duallang{ ### Multi-language Example}{ ### Przykłady wielojęzykowości }

\duallang{
This paragraph is in a `\duallang` macro.
}{
Then paragraf jest w makrze `\duallang`.
}

If you write something without specifying the language, it is always visible.

## Configuration the style

The whole style can be changed by editing the top lines of `_css/smpuj.css`.
There you will find all relevant parameters.
```CSS
:root {
  --text-color: #0E1021;
  --background-color: #ffffff;
  --secondary-background-color: #b1c8db;
  --accent-color: #8eaac3; /* sidebar, top part of the page */

  --block-background: #b1c8db; /* Text blocks */
  --output-background: #b1c8db; /* Output of scripts */

  --links-color: #3262d1; /* e.g. hrefs and e-mails */
  --contrast-text-color: #3262d1; /* e.g. for bold */
  --header-text-color: #3F4F6E;
  --less-important-text-color: #9B9CBF; /* footers */

  --sidebar-width: 15.5rem;

  /* Font */
  --main-font: "Computer Modern Serif", Times, serif;
  --secondary-font: "Computer Modern Sans", Arial, sans-serif;
  --normal: 19px;
  --small: 14px;
}
```
The only exception is how code is displayed, as this is done through `highlight.js`.
To change the style, just modify `_layout/head_highlight.html`.

If you would like to make more modifications, then have a nice time hacking :). 



## Dark mode

To change from light to dark mode, just press the button in the bottom left.
Colours for both modes are configured using variables at the top of `_css/smpuj.css`.

Similarly, as with multi-language, to make the page remember the chosen theme, see [Optional JavaScript](#optional_javascript) section.


## Optional JavaScript

This template is currently JS-free.
However, to make it remember your selected language and light/dark mode when you go to a different subpage, you may like to enable JS.

Simply edit `_assets/foot.html` and uncomment the following code for light/dark mode tracking.
```html
&lt;script&gt;
      // Fetch the light/dark mode from storage
      const themeCheckbox = document.getElementById('theme-checkbox');
      const savedTheme = localStorage.getItem('theme');
      if (savedTheme === 'dark') {
        themeCheckbox.checked = true;
      }
      
      // Save the chosen mode on switching it
      themeCheckbox.addEventListener('change', function() {
        localStorage.setItem('theme', this.checked ? 'dark' : 'light');
      });
&lt;/script&gt&gt;
```
The following code keeps track of the selected language.
```html
&lt;script&gt;
      // Fetch the language from storage
      const langCheckbox = document.getElementById('lang-checkbox');
      const savedLang = localStorage.getItem('lang');
      if (savedLang === 'native') {
        langCheckbox.checked = true;
      }
      
      // Save the chosen lang on switching it
      langCheckbox.addEventListener('change', function() {
        localStorage.setItem('lang', this.checked ? 'native' : 'en');
      });
&lt;/script&gt;
```



# How to use Franklin

\tableofcontents <!-- you can use \toc as well -->

This section is meant as a refresher if you're new to Franklin.
Have a look at both how the website renders and the corresponding markdown (`index.md`).
Modify at will to get a feeling for how things work!

Ps: if you want to modify the header or footer or the general look of the website, adjust the files in
* `src/_css/` and
* `src/_html_parts/`.

## The base with Markdown

The [standard markdown syntax](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) can be used such as titles using `#`, lists:

* element with **bold**
* element with _emph_

or code-blocks `inline` or with highlighting (note the `@def hascode = true` in the source to allow [highlight.js](https://highlightjs.org/) to do its job):

```julia
abstract type Point end
struct PointR2{T<:Real} <: Point
    x::T
    y::T
end
struct PointR3{T<:Real} <: Point
    x::T
    y::T
    z::T
end
function len(p::T) where T<:Point
  sqrt(sum(getfield(p, η)^2 for η ∈ fieldnames(T)))
end
```

You can also quote stuff

> You must have chaos within you to ...

or have tables:

| English         | Mandarin   |
| --------------- | ---------- |
| winnie the pooh | 维尼熊      |

Note that you may have to do a bit of CSS-styling to get these elements to look the way you want them (the same holds for the whole page in fact).

### Symbols and html entities

If you want a dollar sign you have to escape it like so: \$, you can also use html entities like so: &rarr; or &pi; or, if you're using Juno for instance, you can use `\pi[TAB]` to insert the symbol as is: π (it will be converted to a html entity).[^1]

If you want to show a backslash, just use it like so: \ ; if you want to force a line break, use a ` \\ ` like \\ so (this is on a new line).[^blah]

If you want to show a backtick, escape it like so: \` and if you want to show a tick in inline code use double backticks like ``so ` ...``.

Footnotes are nice too:

[^1]: this is the text for the first footnote, you can style all this looking at `.fndef` elements; note that the whole footnote definition is _expected to be on the same line_.
[^blah]: and this is a longer footnote with some blah from veggie ipsum: turnip greens yarrow ricebean rutabaga endive cauliflower sea lettuce kohlrabi amaranth water spinach avocado daikon napa cabbage asparagus winter purslane kale. Celery potato scallion desert raisin horseradish spinach carrot soko.

## Basic Franklin extensions

### Divs

It is sometimes useful to have a short way to make a part of the page belong to a div so that it can be styled separately.
You can do this easily with Franklin by using `@@divname ... @@`.
For instance, you could want a blue background behind some text.

@@colbox-blue
Here we go! (this is styled in the css sheet with name "colbox-blue").
@@

Since it's just a `<div>` block, you can put this construction wherever you like and locally style your text.

### LaTeX and Maths

Essentially three things are imitated from LaTeX

1. you can introduce definitions using `\newcommand`
1. you can use hyper-references with `\eqref`, `\cite`, ...
1. you can show nice maths (via KaTeX)

The definitions can be introduced in the page or in the `config.md` (in which case they're available everywhere as opposed to just in that page).
For instance, the commands `\scal` and `\R` are defined in the config file (see `src/config.md`) and can directly be used whereas the command `\E` is defined below (and therefore only available on this page):

\newcommand{\E}[1]{\mathbb E\left[#1\right]}

Now we can write something like

$$  \varphi(\E{X}) \le \E{\varphi(X)}. \label{equation blah} $$

since we've given it the label `\label{equation blah}`, we can refer it like so: \eqref{equation blah} which can be convenient for pages that are math-heavy.

In a similar vein you can cite references that would be at the bottom of the page: \citep{noether15, bezanson17}.

**Note**: the LaTeX commands you define can also incorporate standard markdown (though not in a math environment) so for instance let's define a silly `\bolditalic` command.

\newcommand{\bolditalic}[1]{_**!#1**_} <!--_ ignore this comment, it helps atom to not get confused by the trailing underscore when highlighting the code but is not necessary.-->

and use it \bolditalic{here for example}.

Here's another quick one, a command to change the color:

\newcommand{\col}[2]{~~~<span style="color:~~~#1~~~">~~~!#2~~~</span>~~~}

This is \col{blue}{in blue} or \col{#bf37bc}{in #bf37bc}.

### A quick note on whitespaces

For most commands you will use `#k` to refer to the $k$-th argument as in LaTeX.
In order to reduce headaches, this forcibly introduces a whitespace on the left of whatever is inserted which, usually, changes nothing visible (e.g. in a math settings).
However there _may be_ situations where you do not want this to happen and you know that the insertion will not clash with anything else.
In that case, you should simply use `!#k` which will not introduce that whitespace.
It's probably easier to see this in action:

\newcommand{\pathwith}[1]{`/usr/local/bin/#1`}
\newcommand{\pathwithout}[1]{`/usr/local/bin/!#1`}

* with: \pathwith{script.jl}, there's a whitespace you don't want 🚫
* without: \pathwithout{script.jl} here there isn't ✅

### Raw HTML

You can include raw HTML by just surrounding a block with `~~~`.
Not much more to add.
This may be useful for local custom layouts like having a photo next to a text in a specific way.

~~~
<div class="row">
  <div class="container">
    <img class="left" src="/assets/rndimg.jpg">
    <p>
    Marine iguanas are truly splendid creatures. They're found on the Gálapagos islands, have skin that basically acts as a solar panel, can swim and may have the ability to adapt their body size depending on whether there's food or not.
    </p>
    <p>
    Evolution is cool.
    </p>
    <div style="clear: both"></div>      
  </div>
</div>
~~~

**Note 1**: again, entire such blocks can be made into latex-like commands via `\newcommand{\mynewblock}[1]{...}`.

**Note 2**: whatever is in a raw HTML block is *not* further processed (so you can't have LaTeX in there for instance). A partial way around this is to use `@@...` blocks which *will* be recursively parsed. The following code gives the same result as above with the small difference that there is LaTeX being processed in the inner div.

@@row
@@container
@@left ![](/assets/rndimg.jpg) @@
@@
Marine iguanas are **truly splendid** creatures. They're not found in equations like $\exp(-i\pi)+1$. But they're still quite cool.
~~~
<div style="clear: both"></div>
~~~
@@

## Pages and structure

Here are a few empty pages connecting to the menu links to show where files can go and the resulting paths. (It's probably best if you look at the source folder for this).

* [menu 1](/menu1/)
* [menu 2](/menu2/)
* [menu 3](/menu3/)

## References (not really)

* \biblabel{noether15}{Noether (1915)} **Noether**,  Körper und Systeme rationaler Funktionen, 1915.
* \biblabel{bezanson17}{Bezanson et al. (2017)} **Bezanson**, **Edelman**, **Karpinski** and **Shah**, [Julia: a fresh approach to numerical computing](https://julialang.org/research/julia-fresh-approach-BEKS.pdf), SIAM review 2017.

## Header and Footer

As you can see here at the bottom of the page, there is a footer which you may want on all pages but for instance you may want the date of last modification to be displayed.
In a fashion heavily inspired by [Hugo](https://gohugo.io), you can write things like

```html
Last modified: {{ fill fd_mtime }}.
```

(cf. `src/_html_parts/page_foot.html`) which will then replace these braces with the content of a dictionary of variables at the key `fd_mtime`.
This dictionary of variables is accessed locally by pages through `@def varname = value` and globally through the `config.md` page via the same syntax.

There's a few other such functions of the form `{{fname p₁ p₂}}` as well as support for conditional blocks. If you wander through the `src/_html_parts/` folder and its content, you should be able to see those in action.
