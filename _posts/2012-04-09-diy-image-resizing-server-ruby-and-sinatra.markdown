---
title: "DIY Image Resizing Server in Sinatra: Super Easy"
description: Learn how to build a service that does image resizing on the fly using sinatra, ruby and minimagick
date: 2012-04-09 19:43:06 -0700
layout: post
---

When building out officespace.com, one of the best decisions we made was
using an image server for all of our resizing. It's *really* nice to be
able to tweak your image size on the fly, rather than on upload.

<!--more-->

There are a few gems, like dragonfly, which do this. And lately, a
number of companies have started offering image processing as a service.
But it's super easy to throw together one of these yourself
using sinatra & minimagick.

We're going to make a sinatra app that takes an image url, downloads the
image, resizes it and spits it out.

Resizing Images
---------------

The resize action is really simple. One tip is to use to use the "box"
filter. This cut our resize time by over 50%.

{% highlight ruby %}
  get '/resize/:dimensions/*' do |operation, dimensions, url|

    image = MiniMagick::Image.open("http://#{ url }")

    image.combine_options do |command|
      #
      # The box filter majorly decreases processing time without much
      # decrease in quality
      #
      command.filter("box")
      command.resize(dimensions)
    end

    send_file(image.path, :disposition => "inline")
  end
{% endhighlight %}


Crop those bad boys
-------------------

The crop action is a little more complex though not much. First we do a
resize so that the image fills up the larger dimension of the crop box.
(That's what the ^^ is all about) Then we do the actual crop.

{% highlight ruby %}
  get '/crop/:dimensions/*' do |operation, dimensions, url|

    image = MiniMagick::Image.open("http://#{ url }")

    image.combine_options do |command|
      command.filter("box")
      command.resize(dimensions + "^^")
      command.gravity("Center")
      command.extent(dimensions)
    end

    send_file(image.path, :disposition => "inline")

  end
{% endhighlight %}

And that's basically it. Once you have this running, you can do a lot of neat
tricks like watermarking, serving a placeholder if there's an error,
etc.

For a more complete example, check out the [github repo](https://github.com/starrhorne/Toy-Image-Server).


Downsides and Caveats
---------------------

There are a few issues you'll want to address before you go to
production:

* Caching: You'll need to stick Amazon Cloudfront or some other cache
  infront of your server so images only get resized once.
* Url Validation: You'll need to restrict usage to allowed domains.
* Nasty characters: As it's shown, characters like .{}[] in the urls
  will cause errors.


