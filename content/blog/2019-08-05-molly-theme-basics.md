+++
title = "Molly theme basics"

[extra]
banner_quote = "To Molly the dog..."
banner_footer = "Thank you for the company."
author = "Zekun"
+++

{{ section_begin(header="Introduction") }}

Molly is a [Zola](https://www.getzola.org/) blog theme based on [Tufte CSS](https://edwardtufte.github.io/tufte-css/).
The theme is a work in progress in its early stage of development.
Zola is a static site generator written in _Rust_;
checkout [the documentation](https://www.getzola.org/documentation/getting-started/installation/) to get started.

{{ section_con(header="Basics") }}

### Installation

To use Molly theme with your Zola site,
in your `themes` directory clone Molly theme's [repo](https://github.com/timokratia/timokratia.github.io.git){% sidenote(unique_id="clone-repo") %}
git clone https://github.com/timokratia/molly.git
{% end %}
and in your `config.toml` file add `theme = "molly"`.

### Configuration

In your `config.toml` file's `[extra]` field,
add your GitHub profile (e.g. mine is `github = "https://github.com/timokratia"`) for the `code` menu item to redirect to;
also add license information to the `license` field to display in the page footer;
as well as your global banner quote and footer (see next section).

{{ section_con(header="In your Markdown file") }}

At the time of writing Molly theme has implemented `sections`, `sidenotes`, and `margin notes` from _Tufte CSS_.
They are achieved by using [macros](https://tera.netlify.com/docs/templates/#macros) together with [shortcodes](https://www.getzola.org/documentation/content/shortcodes/).
Additionally, Molly theme uses epigraphs to display a pair of banner quote and footer on top of each page.

### Sections

_Tufte CSS_ recommends using "section tags around each logical grouping of text and headings".
In Molly theme, the content of your Markdown file is wrapped in a pair of `section` tags by default.
To add your __first__ additional section with heading, use the following shortcode

`{{/* section_begin(header="Your section header") */}}`

and __following__ sections with

`{{/* section_con(header="Another section header") */}}`.

Section headers are wrapped in `<h2>` tags.
You can add subsection headers using Markdown's `###`.

### Sidenotes and margin notes


Sidenotes and margin notes are easier to find than footnotes.
To add a numbered sidenote like this{% sidenote(unique_id="sample-sidenote") %}
The body of the sample sidenote.
{% end %},
use the following shortcode

`{%/* sidenote(unique_id="your-unique-id-for-sidenote") */%}Sidenote body{%/* end */%}`.

Similarly, an unnumbered margin note{% marginnote(unique_id="sample-marginnote") %}
Margin notes are unnumbered.
{% end %} can be created by

`{%/* marginnote(unique_id="your-unique-id-for-marginnote") */%}Margin note body{%/* end */%}`.

Please note that _Tufte CSS_ requires you to manually assign a reference id to each side or margin note.
It's used to toggle the note on mobile.

Also there's a sneaky difference between section and sidenote/margin note's shortcode.
The shortcode to use sections starts and ends with `{{` and `}}`,
while for sidenotes and margin notes it's `{%` and `%}`.
The reason is that Zola has different syntaxes for shortcodes with and without a body.
The `section` shortcode doesn't have a body because it only inserts `<section>` tags and a `<h2>` header.
On the other hand, sidenotes and margin notes require a note body in addition to a unique id.

### Banner quote and footer

A pair of banner quote and footer is displayed on top of each page to serve as a brief introduction.
The global quote and footer you set in `config.toml` will be used as the default for every page.
However, you can override them in individual page's front matter in the fields of
`banner_quote` and `banner_footer` under `[extra]`.

{{ section_con(header="Design considerations") }}

Inspired by [ayekat's website](http://ayekat.ch/),
Molly theme redirects the homepage of your site to the `about` page,
and the `blog` page to your latest post{% sidenote(unique_id="redirect-blog") %}
However, this is achieved partially.
If you manually enter base_url/blog/ in the browser, you will still be redirected to the about page.
{% end %}.
I consider it straightforward, and it also reduces some coding.

The color palette used in Molly theme is generated from the base color of _Tufte CSS_, `#fffff8`, in [ColorSpace](https://mycolor.space/).
It uses colors from the _Matching Gradient_ palette:
`#d9ded2`, `#89a191`, and `#36675f`.

{{ section_con(header="Epilogue") }}

Contribution, questions, and suggestions are welcome!
Contact me in Molly theme's [repo](https://github.com/timokratia/molly.git) or [tweet me](https://twitter.com/intent/tweet?screen_name=Timokratia&ref_src=twsrc%5Etfw) directly.

If you're looking for other implementations of _Tufte CSS_,
checkout [this awesome thread](https://github.com/edwardtufte/tufte-css/issues/26)
as well as both [Gertjan van den Burg](https://gertjanvandenburg.com/blog/how_i_made/) and [ayekat's](http://ayekat.ch/blog/tufte-css)
blog posts.
