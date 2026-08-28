@def title = "Kitty Publication"
@def rss_title = "New Publication in Kitty Journal!"
@def rss_pubdate = Date(2026, 8, 7)
@def rss_description = "This is a kitty publication!"

~~~
<div id="pub1" class="card publication">
    <div class="normal-card">
        <div class="card-content">
            <p id="paper-title">Kitty Book</p>
            <p id="paper-author">Expert Kitty</p>
            <p style="font-size: small;">Released under a BEAUTIFUL licence</p>
        </div>
    </div>
    <div class="review-card hidden-content">
        <div class="card-content">
            <p class="paper-abstract">
                This publication covers essential feline skills, from mastering 18-hour naps to strategic window watching.
            </p>
        </div>
    </div>
    <div class="publication-buttons">
        <a onclick="togglePublicationContent(this)" class="button-6" role="button">Abstract</a>
    </div>
</div>
~~~