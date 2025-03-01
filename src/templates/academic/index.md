+++
title = "Your Name"
hasmath = false
hascode = false
+++

~~~
<!-- Main "about me" section -->
<br>
<div class="row">
    <div class="col_left_home">
        <h1 class="title">Your Name</h1>
        <l>Title & Affiliation</l>
        <p>
        Welcome to my Franklin.jl template for a personal research website! This template is loosely modeled off of <a href="https://jonbarron.info"/>John Barron</a> and <a href="https://github.com/alshedivat/al-folio">al-folio</a> with some inspiration from <a href="https://paulbutler.org"/>Paul Butler</a>.
        </p>

        <p>
        This template is built for academic researchers in mind. Files in the blog folder with the tag "blog" are listed in the Blog section below by their title. Files under "papers" are listed with title, authors, and links according to their tags. For a guide to customizing the site, see the <a href="/blog/2025/quickstart">quick start page</a>. For an example, see <a href="https://lorenzos.io">my homepage</a>.
        </p>
        <div style="text-align: center;"><a href="mailto:yourname@mit.edu">email</a>&ensp;//&ensp;<a href="https://scholar.google.com/citations?user=you">scholar</a>&ensp;//&ensp;<a href='https://github.com/user'>github</a>&ensp;//&ensp;<a href='https://www.youtube.com/@yourname/videos'>youtube</a></div>
    </div>
    <div class="col_right_home" style="padding-top: 50px;">
        <img id="me" src="/assets/rndimg.jpg">
    </div>
</div>
<br>
~~~

<!-- Research Section -->
### Research
*What's a personal webpage without a few publications?*
{{paperswithtags selected physics}}


<!-- Blog Section -->
### Blog
*A couple example & tutorial pages to get you started.*
~~~<br>~~~
{{recentblogposts .}}
