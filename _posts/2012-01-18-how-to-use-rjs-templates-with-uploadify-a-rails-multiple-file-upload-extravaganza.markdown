---
layout: post
title: "How to use rjs templates with uploadify: a rails multiple file upload extravaganza!"
description: "Using RJS and Uploadify to create a seamles multi-file-upload UI"
date: 2012-01-18 18:18
---

John Nunemaker posted a great [article](http://railstips.org/2009/7/21/uploadify-and-rails23)
on using uploadify with rails.

[Uploadify](http://www.uploadify.com/) is a sweet jquery plugin that lets you do multiple file upload with progress indicators and everything,
using the magic of flash.

<!--more-->

But you know that magic always comes with a price. Specifically: flash sucks. It sucks in part because it doesn't
let you send cookies back with your request. John's post showed you a way around that.

But it also sucks because it doesn't send HTTP request headers either. Which means no RJS, kiddies. Unless you
use a workaround like so.

In your middleware:

<script src="https://gist.github.com/1637315.js"> </script>

And in your javascript, you'll need to add a bit of code to eval the response:

<script src="https://gist.github.com/1637317.js"> </script>

Now, bingo! You can just use responds_to like normal.

