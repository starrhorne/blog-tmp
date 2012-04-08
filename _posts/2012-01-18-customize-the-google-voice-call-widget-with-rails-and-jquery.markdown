---
layout: post
title: "Customize the Google Voice Call Widget With Rails &amp; jQuery"
description: "Starr Horne, a Seattle rails developer describes how to customize the google click-to-call widget"
date: 2012-01-18 18:19
---

So I have a client who needed a google voice widget embedded in their site.  
If you're not familiar with it, it's a little widget that your site's visitors 
can use to call you.

<!--more-->

It's really simple to set up...unless you want to customize the widget's graphics. 
But there is a way. Here's how you can do it:


A simple form post
==================

The Google Voice widget does a simple form post. You can see it <a href="http://www.stephenjc.com/2009/05/google-voice-call-widget-post-commands.html">Here.</a>

When there are no errors, google returns "ok=true". When there are problems, it returns "ok=false".

Easy


A Proxy
=======

The only kink here is that we can't AJAX post to a 3rd party domain like
google. So we need to implement a little proxy. You can do this by creating a
controller named "phone_calls".

It's pretty simple. It just takes params[:phone_call] and does a https post to
the google server.

<script src="https://gist.github.com/1637301.js"> </script>


The HTML
========

Now we just need to make a little form and add some javascript to submit it.
You'll need to get your api key from the google voice widget's embed code.

<script src="https://gist.github.com/1637295.js"> </script>

... and here's the javascript

<script src="https://gist.github.com/1637297.js"> </script>

You can make it a little fancier by showing "success" and "failure".
That's left as an exercise for the reader.


