---
layout: post
title: "Track Pageviews Using MongoDB"
description: "Learn how mongodb can be used to collect and store site analytics"
date: 2012-01-18 18:20
---

Now, mongo isn't the solution to every problem. But for some things, like action 
tracking, it is close to perfect.

<!--more-->

Mongodb is pretty sweet, and mongo mapper makes it really easy to integrate with 
your rails app. 

For example, the following track method will create a Metric record with a 
certain action if it doesn't exist. Then it will push the current time to the 
timestamps array.

https://gist.github.com/1637337

The only caveat with this approach is that mongo documents have a max size of 5 megabytes.
So if you were tracking pageviews on a site that received 1000s of hits a day, you'd 
exceed that limit pretty quickly.

