@def title = "The Stranger"
@def rss_title = "New Book from Camus!"
@def rss_pubdate = Date(2026, 8, 7)
@def rss_description = "This is a kitty book!"

~~~
<div id="book1" class="card publication" style="width: 100% !important; margin: 0 !important; box-sizing: border-box !important;">
    <div class="normal-card">
        <div class="card-content">
            <img alt="The Stranger Cover" 
                    src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='150' height='200' viewBox='0 0 150 200'%3E%3Crect width='150' height='200' fill='%23e74c3c'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' font-family='Arial' font-size='18' fill='white'%3ECover 1%3C/text%3E%3C/svg%3E" 
                    style="width: 100%; height: auto; display: block; border-radius: 4px; margin-bottom: 8px;" />
            <p id="paper-title" style="margin: 4px 0; font-weight: bold;">The Stranger</p>
            <p id="paper-author" style="margin: 0; font-size: 0.85rem;">Albert Camus</p>
        </div>
    </div>

    <div class="review-card hidden-content">
        <div class="card-content">
            <p id="paper-title" style="margin: 4px 0; font-weight: bold;">The Stranger</p>
            <p id="paper-author" style="margin: 0 0 8px 0; font-size: 0.85rem;">Albert Camus</p>
            <div class="review-text" style="text-align: left; font-size: 0.8rem; line-height: 1.4;">
                <p style="margin: 0;">A novel exploring the absurdity of life through Meursault in French Algeria.</p>
            </div>
        </div>
    </div>

    <div class="publication-buttons" style="margin-top: 8px;">
        <a onclick="toggleBookContent(this)" class="button-6" role="button" style="width: 100%; box-sizing: border-box; text-align: center; display: block;">My Review</a>
    </div>
</div>
~~~