---
layout: post
title: "Using Sunspot / Solr to Dramatically Simplify Tagging &amp; Other Stuff in Rails"
description: "Starr Horne, a Seattle web developer, explains how Solr can be used as an alternative to complex SQL queries"
date: 2012-01-18 18:20
---


Ok...If you really love SQL, this is not the article for you. I'm going to share
a little trick I've learned that will let you do really complex queries without
writing a lick of SQL.

<!--more-->

Here's the setup
----------------

I've been working on a niche job site for a client. It's pretty straightforward,
but it involves some monster queries.

A typical requirement might be to query all JobCandidates who:

+  Have any location, job_type or specialization matching those of any job belonging to a specific employer.
    -  JobSeekers and Jobs both have multiple, arbitry values for location, job_type, etc...
+  Have not replied to any of the employer's previous job postings
+  Have been active in the last month

... and we need to to fulltext search on top of this.


That sounds like a lot of work
------------------------------

Why yes, it does.

Sure, you can implement all of that using AR/Mysql. But it sounds like a heck of a lot
of work. And not very fun work.


The Solution
------------

On a lark, I decided to see if this could be implemented any more easily using Solr, 
and the excellent Sunspot gem.  

The basic trick is this:

1. Use AR's serialization to store an array of tags in the model
2. Tell Solr to index each tag.

An Example Model
----------------

<script src="https://gist.github.com/1637340.js"> </script>

How to search
-------------

<script src="https://gist.github.com/1637342.js"> </script>  

This will return all jobs where job.specializations includes one of 
'rails', 'python' or 'perl'.


Bonus!
------

You don't have to do anything different in your controllers/views
to take advantage of this approach.

Rails' views and controllers are set up to handle arrays like this 
just fine. In the example below, when the user submits the form,
the job's specializations are set, and will be indexed by Solr on 
save.


<script src="https://gist.github.com/1637346.js"> </script>


Wash, Rinse and Repeat
----------------------

If you can add one solr-indexed tag attribute to your model, you can 
add two.

Also, since solr can index integers, there's no reason you can't define
associations between models in terms of arrays of integers.

Here's a bit of production code, slightly cleaned up:


<script src="https://gist.github.com/1637348.js"> </script>


Caveats
-------

1. I'm pretty sure this won't scale well at all, since it requires you to 
   update the solr index whenever a new record is created or updated. 
   But this particular project is not going to be very high-traffic, so 
   it's no big deal.

2. Solr only promises 'eventual consistency', which could be an issure for
   some apps, but isn't here.


