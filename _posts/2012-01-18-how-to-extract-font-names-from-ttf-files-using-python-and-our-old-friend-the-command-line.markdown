---
layout: post
title: "How to extract font names from TTF files using Python and our old friend 'the command line'"
description: "Learn how to extract human-readable names from TTF fonts."
date: 2012-01-18 18:19
---

So you're given an archive containing 10,000,000 .ttf files, most 
of which are named things like "bs019dfk.ttf". How do you extract human
readable names from these things?

<!--more-->

If you're like me you think, "No problem! There has to be a command line
utility for that!"

...then about an hour later you think, "I hope to god there's a command line
utility for this".

...then you open a .ttf file in a text editor just in case the name will
somehow magically be there.

...then you start drinking.


Well, good news for your liver. While I couldn't find a stock utility to 
extract the name from the .ttf file, I was able to find a little code to do
so.

It's in python, and you'll need the FontTools library installed. And you should
know that this code is blatently copied from the [TTFQuery project](http://pypi.python.org/pypi/TTFQuery/1.0.2).

<script src="https://gist.github.com/1637310.js"> </script>

To use it, just do this:

 ttf_name somefont.ttf

Or to get all of the font names in a directory tree:

$ find . -iname "*.ttf" -exec ttf_name {} \;
