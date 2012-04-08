--- 
title: "Fuzzy Text Search in Postgresql"
description: "Using postgresql's built-in fuzzy text search"
date: 2012-02-15 15:31:53 -0800
layout: post
---

On my latest project, one of our guiding principles was to keep then
number of moving parts to a minimum. (That sphinx/solr server your running is
just one more server that can go down)

Fortunately, postgres provides some nice fuzzy text search features out
of the box. And they're super easy to use.

<!--more-->

To enable the trigram and fuzzy string match extensions, just do this:

{% highlight sql %}
CREATE EXTENSION pg_trgm;
{% endhighlight %}

Now you can play around. Searching for "wiliam" will return people named "william".

{% highlight sql %}
SELECT name FROM people WHERE name % 'wiliam' ORDER BY similarity(name, 'wiliam') DESC;
{% endhighlight %}

It's important to use the % operator as the condition for the select,
because it uses available indices. (The similarity function doesn't.)
BTW, similarity is a float between 0 and 1, where 1 means "identical".

Once you're ready to create an index, just do this:

{% highlight sql %}
CREATE INDEX people_name_trigram_index ON people USING gist (name gist_trgm_ops);
{% endhighlight %}

Easy peasy.

{% highlight sql %}
select similarity('bob ross', 'ross bob');
{% endhighlight %}

One thing to watch out for is that the % operator and the similarity
function don't take position into account. For example, in the above
query they show "bob ross" and "ross bob" as being identical.
