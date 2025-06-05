+++
title = "Quick Start"
hasmath = false
hascode = false

date = Date(2025, 2, 26)
tags = ["blog"]
+++

# Getting started with this template
A (very) basic guide on how I organized things and what to customize.

## Quick Start
**Updating your name.** Most of the updates are just html/markdown in `index.html`, but you should also change the `name` variable in [config.md](../../config.md).

**Header image.** Update the header image and favicon by changing the images in `_assets`. You may want to get rid of the padding if you have a portrait image.

**Blog posts.** To display properly, all blog posts must be in the "blog" folder (any subfolders are okay) and must have the "blog" tag. The function `hfun_recentblogposts` in [utils.jl](../../utils.jl) automatically shows the 4 most recent blog posts with this tag. Quick tip: to display with this function, write `{{recentblogposts}}`. I suggest changing `{{recentblogposts .}}` to `{{recentblogposts}}` in [index.md](../../index.md) and putting all your blog posts within the `blog` folder.

**Papers.** My current system for displaying papers is a bit clunky, but gets the job done. The function `hfun_paperswithtags` displays all papers with the given tags. This is useful for "selected papers", but links, videos, code, etc. all need to be manually entered. As is, the video, venue, and code are optional; if not specified, nothing will display. The idea of venue is to specify where the paper was published; you can leave it empty if it is only on arXiv.

## More Information
If you have any questions, please just raise a GitHub issue. I will update this page as needed to ensure the template is easy to use!