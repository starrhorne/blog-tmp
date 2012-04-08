---
layout: post
title: "Warping Vector Text With Ruby &amp; Cairo"
description: "Starr Horne, a UX developer based in Seattle, WA, explains how to warp text along a path using the cairo graphics library."
date: 2012-01-18 18:16
---

I recently needed to create arched text in an application that uses Cairo. Unfortunately, Cairo doesn't support warping text out of the box.

<!--more-->

Luckily, the pycairo guys were cool enough to include an example of warped text in their distribution.

Here it is, ported to ruby:

<script src="http://gist.github.com/466898.js?file=gistfile1.rb"></script>

