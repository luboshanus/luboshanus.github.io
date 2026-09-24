# Style notes — luboshanus.github.io

Everything below describes the site as it actually is: the Minimal Light
academic base (Klein blue on white, fixed left sidebar) plus the rebuilt top
menu.

The fenced block is written to be pasted into another project's Claude Code
terminal as a single prompt.

---

````text
Apply the "Klein Academic" style to this project. It is a restrained,
text-first academic personal site: white page, one saturated blue accent, a
fixed left sidebar for identity, a fixed top bar for navigation. No cards, no
gradients, no decorative chrome.

## Palette

```
#002fa7  Klein blue   — links, ALL headings, navbar, badges. The only accent.
#ffb81c  amber        — hover/focus accent only. Never a surface.
#333333  body text
#222222  <strong>, dt, th
#595959  de-emphasised text (affiliations, conference lists)
#828282  captions / light text
#ffffff  page background
#e5e5e5  hairlines (hr, table cell borders, blockquote rule)
#f8f8f8  <pre> background
#ddd     image shadows
```

Only ONE accent colour. Do not introduce a second brand hue.

## Type

```
Body   : "Alegreya Sans", "Helvetica Neue", Arial, sans-serif — 16px / 1.4, weight 300
Mono   : "Fira Mono", monospace — used for email addresses and code
h1     : 1.8em,  weight 500, colour #002fa7, padding 15px 0 10px
h2     : 157%,   weight 500, colour #002fa7, margin 10px 0 0, padding 10px 0 15px
h3–h6  : weight 500, colour #002fa7, margin 10px 0
h1,h2,h3 line-height: 1.1
strong : #222, weight 500
small  : 11px
email  : Fira Mono, 0.85em, weight 300
```

Headings are medium weight and always accent-coloured — never bold-black. Body
text is #333, never pure black. No heading rules, borders or underlines: the
spacing does the separating.

## Layout

```
.wrapper  960px, centred
header    232px, float: left, position: fixed, padding-top: 5.5em, centred text
section   650px, float: right, padding-top: 1.2em
footer    232px, fixed, bottom: 30px
```

The sidebar holds avatar (circular, border-radius 100%), name, position,
affiliations, emails and a row of social icons (2.4rem circles, accent colour,
scale 1.2 on hover). The right column holds all the prose.

Breakpoints: **960px** — sidebar and content stack into one column, section gets
1px #e5e5e5 top/bottom borders and 20px padding. **480px** — publication rows
switch from flex to block.

Anchor navigation uses empty `<h1 id="...">` elements as jump targets directly
above each visible `<h2>`.

## Publication rows

Flex row, image left, text right. Teaser image 270×123, `object-fit: cover`,
border-radius 4px, 1px #ddd border, `box-shadow: 2px 2px 3px #ddd`. A venue
badge (`<abbr class="badge">`) is absolutely positioned at the row's top-left
corner: accent background, white text, 75% font-size, weight 700. Links (PDF /
Code / Project Page) are small outlined pills, 1px #ccc, that turn accent on
hover.

## Top navigation bar — the component to copy verbatim

Fixed, full-bleed accent bar whose INNER container is width-matched to the page
wrapper, so the logos line up with the sidebar's left edge and the links with
the content column's right edge at every viewport width.

```css
.topnav {
  position: fixed; top: 0; left: 0; z-index: 999;
  width: 100%; min-height: 44px;
  background-color: #002fa7;
  overflow: hidden;
}

.topnav__inner {
  display: flex; align-items: center; justify-content: space-between;
  gap: 1rem;
  box-sizing: border-box;
  width: 100%;
  max-width: calc(960px + 2 * 1.25rem);  /* == .wrapper + gutters */
  min-height: 44px;
  margin: 0 auto;
  padding: 0 1.25rem;
}

.topnav .logos { display: flex; align-items: center; gap: 0.75rem; flex-shrink: 0; }
.topnav .logos img { display: block; width: 60px; height: auto; opacity: 0.92; }
.topnav .logos a:hover img { opacity: 1; }

/* row-reverse renders the YAML's right-to-left order left-to-right */
.topnav .nav-links {
  display: flex; flex-direction: row-reverse; align-items: center;
  gap: 0.25rem;
  margin-right: -0.75rem;   /* last link's text sits flush with the column edge */
}

.topnav a.normal, .topnav a.right {
  padding: 0.5rem 0.75rem;
  border-radius: 4px;
  color: rgb(246, 246, 246);
  font-size: 1rem; line-height: 1.2;
  text-decoration: none; white-space: nowrap;
  transition: background-color 120ms cubic-bezier(0.2, 0, 0.2, 1);
}
.topnav a.normal:hover { background-color: rgba(255, 255, 255, 0.16); color: #fff; }

.topnav a:focus-visible, .topnav button:focus-visible {
  outline: 2px solid #ffb81c; outline-offset: 2px;
}

.topnav .nav-toggle {
  display: none; align-items: center; justify-content: center;
  width: 2.5rem; height: 2.5rem;
  padding: 0; border: 0; border-radius: 4px;
  background: transparent; color: #fff; font-size: 1.15rem; cursor: pointer;
}
.topnav .nav-toggle:hover { background-color: rgba(255, 255, 255, 0.16); }

@media print, screen and (max-width: 960px) {
  .topnav { overflow: visible; }
  .topnav__inner { flex-wrap: wrap; }
  .topnav .nav-toggle { display: inline-flex; }
  .topnav .nav-links {
    display: none; order: 3; width: 100%;
    margin-right: 0; padding-bottom: 0.5rem;
    border-top: 1px solid rgba(255, 255, 255, 0.2);
    flex-direction: column; align-items: stretch; gap: 0;
  }
  .topnav .nav-links.is-open { display: flex; }
  .topnav a.normal, .topnav a.right {
    display: block; padding: 0.75rem; border-radius: 0; text-align: left;
  }
}

@media print { .topnav { display: none; } }
```

Markup:

```html
<nav class="topnav" aria-label="Main">
  <div class="topnav__inner">
    <span class="logos">
      <a href="…" rel="noopener" aria-label="…"><img src="…" width="60" height="26" alt="…"></a>
    </span>
    <button class="nav-toggle" type="button" aria-expanded="false"
            aria-controls="nav-links" aria-label="Toggle navigation menu">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
    <div id="nav-links" class="nav-links"> … <a class="normal" href="#x">Item</a> … </div>
  </div>
</nav>
```

Behaviour: a real `<button>`, not an `<a href="javascript:void(0)">`. JS only
toggles an `.is-open` class and keeps `aria-expanded` in sync — CSS owns the
breakpoint. Tapping any link closes the panel.

```js
document.addEventListener("DOMContentLoaded", function () {
  var btn = document.querySelector(".nav-toggle");
  var links = document.getElementById("nav-links");
  if (!btn || !links) { return; }
  btn.addEventListener("click", function () {
    var open = links.classList.toggle("is-open");
    btn.setAttribute("aria-expanded", open ? "true" : "false");
  });
  links.addEventListener("click", function (e) {
    if (e.target.closest("a")) {
      links.classList.remove("is-open");
      btn.setAttribute("aria-expanded", "false");
    }
  });
});
```

## Watch out for

- Do NOT align the bar's contents with a ladder of per-breakpoint percentage
  margins (`margin-left: 3% / 6% / 12% / 17% …`). One width-matched flex
  container replaces the whole ladder and is correct at every width.
- Keep the bar's `min-height` at or below the space the page already reserves
  above its first heading, or the heading hides underneath it.
- A `max-height` on a box containing an absolutely positioned child lets that
  child escape and overlap what follows once rows stack on mobile.
- Never ship `maximum-scale=1.0` or `user-scalable=no`; it blocks pinch-zoom.
````
