--- 
title: "Frontend Code Doesn't Have to Suck: 5 Tips for Rails Developers"
description: "Starr Horne, a professional rails UI developer based in Seattle WA,  shares 5 secrets for building clean, maintainable front ends"
date: 2012-02-16 16:32:17 -0800
layout: post
---

Most front end code sucks. You know the situation. You start out with the best intentions every time, but every time you wind up with something "less than maintainable."

I'm a rails developer and a lot of my work has to do with building out the UI. Over the past few years I've developed a number of best practices that have really helped me to build solid, maintainable front ends for fairly complicated web apps. 

I believe that most rails developers could improve the quality of their front and builds by adopting a few of these suggestions.

<!--more-->

Namespace the Hell Out of Your CSS
----------------------------------------------------

(Then namespace it some more)

> The worst part about CSS is that style conflicts are guaranteed to happen. 

When a project is still young you may think that all H1s are going to look a certain way (just like you thought you were always going to wear those acid wash jeans).

But then you need an H1 with an underline, and then one in a different color. Soon, you first step when you style any H1 will be to undo half of the the original, global H1 style. It ain’t pretty. 

Your salvation lies in using a CSS reset, then namespacing the hell out of everything. 

Personally, I like a two-pronged approach, where I break a site up into “components” and “pages”. Component styles are namespaced to the component container. Page styles are namespaced to the body class.

{% highlight css %}

/* Styles for the sidebar component */
.component.sidebar {
  width: 300px;
}

/* Page specific styles */
body.checkout {
  .component.sidebar {
    width: 100px;
  }
}
{% endhighlight %}

Global styles like “.error” are forbidden, with consequences of biblical proportion. (This is why I am morally opposed to things like the twitter bootstrap). 

If you follow this approach diligently, you can drop any CSS file into any page on your site with ZERO style conflicts.


Create a naming convention for files and classes
------------------------------------------------

Most people just stick their CSS in a single file. At first things may be organized. But after 6 months, more often than not you'll have an ungodly mess of unmaintainable css.

Naming conventions solve this problem. 

> You should always know exactly where the style for an element belongs.

A new developer on your team should be able to add a component to the page, and know exactly where to put the stylesheet. Then you should be able to come along later and know exactly where to find it. 

So in my projects, if you add a new component named “sidebar”, you will name the class “component.sidebar”, and the styles will go in /stylesheets/components/_sidebar.scss . 

Here are some examples:

{% highlight bash %}
app/assets/stylesheets/components/_component_name.scss
app/assets/javascripts/components/component_name.js.coffee
app/assets/images/components/component_name/lolcat.jpg
app/views/components/_component_name.html.haml
{% endhighlight %}

This system works quite well. It provides you with mechanism for defining general, reusable UI elements as well as for customizing them on a per-page basis.

Create a style guide
-------------------

If you have the luxury of working with a really good designer, you might find yourself given a style guide containg specs for all of the color, text styles, buttons, gradients and other visual elements used in a project. Buy this person a sandwich. They've just saved you a ton of time.

Even if your designer is to lazy to give you one of these, I suggest that you create one for yourself. You can do it based on mockups, or on the fly by continually refactoring your css.

You can use the styleguide to build a set of sass mixins which you can use throughout the project. This is how you can have DRY stylesheets without defining global classes. If you haven't done things this way, it's awesome. It saves so much time. 


Make your JavaScript independent of Dom structure
--------------------------------------------------

Once you've built enough projects you find yourself running into the same bugs over and over again. For example, I had one project where every few months the JS would just stop working, even though it hadn’t been touched.  

Inevitably, the problem turned out to be that someone had tweaked the HTML, caused the JS dependent on some DOM structure to explode. 

> Your project’s HTML will be changed all the time.

Your project’s HTML will be changed all the time. It is a fact of life. Every time you write JS that depends on a DOM structure, you’re linking the stability of your code to something that's inherently unstable.

An easy way around this is to use HTML 5 data attributes.  For example, if I have a link that causes a box to slide open, I might set `data-expand=”#the-thing-to-expand”` attribute.

Here's the html:

{% highlight html %}
<a data-toggle-trigger="token">Toggle that thing!</a>
<div data-toggle="token"></div>
{% endhighlight %}

And coffeescript:

{% highlight coffeescript %}
$("[data-toggle-trigger]").click (e) ->
  e.preventDefault()
  $("[data-toggle=#{ $(this).attr("data-toggle-trigger") }]").toggle()
{% endhighlight %}


Modularize your JavaScript
--------------------------

With Rails 3.1 and the asset pipeline, every piece of JS you add runs on every page of your site. So it’s time to namespace the hell out of your JS. 

> With Rails 3.1 and the asset pipeline, every piece of JS runs on every page of your site.

One neat approach is to create JavaScript classes which only operate on one particular component. If the component is present, they go to work. If not, they don’t do anything. These JS components only operate on children of the component container, and they don’t know anything about any other components on the page. But they can communicate via custom DOM events.

This method is simple, but can be really powerful. For example, in my work at OfficeSpace.com, we have a search form which update a Google map, a data display, and several other elements. All of these are separate components which communicate via custom DOM events. 

{% highlight coffeescript %}
#
# Simplified search form. Somewhat Nonsensical.
#
class SearchForm
  constructor: (@el) ->
    @el.find("form").submit (e) =>
      e.preventDefault()
      $(document).trigger("location:search", @searchParams())
  searchParams: => # Just an example
#
# Attach the component to dom elements
#
$ ->
  $(".component.search-form").attachComponent(SearchForm);
{% endhighlight %}


Conclusion
--------------

I hope these few tips will help you build awesome, maintainable UIs for your rails applications. They’ve definitely helped me. 
