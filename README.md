# MFWGen

Inspired by [Motherfucking Website](http://motherfuckingwebsite.com) and its offspring: [Better motherfucking Website](https://bettermotherfuckingwebsite.com) and [Best Motherfucking Website](https://bestmotherfucking.website/).

## How to use it?

You can't actually :sweat_smile:. Meaning that the content is hardcoded in the bloody code, as of now!

Still you can run it and see the output. For that you need Ruby (2.x I guess, tested with 2.3 and 2.5).

So here are the steps...

First install Ruby with your pkg manager or better yet, with [RVM](http://rvm.io/). If you're using Debian/Ubuntu you need to install `ruby` and `ruby2.x-dev` (`x` depending on your OS release). It's **needed** in order to build some Ruby gems' native code.

Then install the gems; FYI `mustache` is the logic-less template engine, RedCarpet is a Markdown-to-HTML renderer, Rouge is a syntax highlighter (not used yet but soon).

    gem install mustache
    gem install redcarpet
    gem install rouge

Then you're good to go! Just run `ruby mfwgen.rb > index.html` and see the magic happen :D (I need a build system I guess).

Among other things it also generates a `tags.css` file from `palette.yml` (which defines the tags' colors).

## Why oh why?

I'm in a minimalist mood, tired of bloated software/websites/etc.

I'm also learning Ruby, so while it would have made much more sense to use Jekyll, I thought to myself: "well, why not brew _yet another fucking website generator_?".

Though I like the idea of a static site, I'd like to add a comment system. I might take one off-the-shelf from [this huge list](https://lisakov.com/projects/open-source-comments/). But maybe I'll just add a tiny Sinatra backend, so that I can have comments and a nice contact form. We'll see!

## Features/Todo-list

* [x] Generate HTML content from a Mustache template and a "view" hash
* [x] Parse a Jekyll-like "front-matter"
* [ ] Add separator to the front-matter
* [ ] Read posts from disk
* [ ] Generate archive/tags links
* [ ] Paginate content
* [ ] Add comment system
* [ ] Add contact form
* [ ] Customize tags (pick colors from a Material palette)
* [ ] Generate SEO tags
* [ ] Generate sitemap.xml
* [ ] Handle multilingual content
* [ ] Minify HTML and assets
* [ ] Benchmark with Google PageSpeed Insights
* [ ] Setup Git push hooks to auto-update the bloody thing
