---
layout: post
title: "Making a million little color swatches with imagemagick and rake"
description: "Starr Horne, a UX/UI developer in Seattle, WA describes how to create color swatches using imagemagick."
date: 2012-01-18 18:18
---

Yesterday I was working on a project, and found myself needing to 
create a bunch of color swatches. CSS wasn't an option. No. They had to 
be little 16x16 images.

<!--more-->

In such situations, I often resort to a more-or-less socratic dialog:

"Is it not so that you are building this for a client"

"Yes."

"And do clients not inevitably change their minds"

"Very true, they usually do"

"Then would it not make sense to generate these swatches programmatically?"

The Rake Task
=============

Heartily agreeing with myself, I devised the following rake task for creating 
color swatches, based on input from a YAML file. BTW, You'll need to have imagemagick 
installed.

<script src="https://gist.github.com/1637322.js"> </script>

The YAML File
=============

Now create a "swatches.yml" file like so:

<script src="https://gist.github.com/1637325.js"> </script>


W00t!
======

Now you can just type in "rake swatches" and feel the magick.

<script src="https://gist.github.com/1637328.js"> </script>


