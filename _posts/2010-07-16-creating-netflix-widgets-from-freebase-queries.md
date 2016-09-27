---
id: 193
title: Creating Netflix Widgets from Freebase Queries
date: 2010-07-16T14:55:15+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=193
permalink: /creating-netflix-widgets-from-freebase-queries.html
aktt_notify_twitter:
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1878791441
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
tags:
  - freebase
  - netflix
  - widget
---
Freebase has just finished creating a process to import Netflix film data on a daily basis. Freebase now includes in their movie metadata the key for the Netflix API. For Netflix API developers, this makes it possible to leverage Freebase&#8217;s powerful query engine and create amazing application interfaces. But even for those people who have never used the Netflix API, this functionality allows developers to leverage Netflix&#8217; widgets to create interfaces within their existing applications, without the hassle of OAuth. I&#8217;ll walk through the process of creating a Netflix widget based on a freebase query here.

## Getting the Movie

Mel Gibson is a popular guy, who&#8217;s done a bunch of movies. But what has he done for us lately? The following freebase query asks what movies he&#8217;s done since January 1, 2009. I&#8217;ll go ahead and ask for the Netflix &#8220;Tiny URL&#8221; as that&#8217;s what we&#8217;ll need to create the Netflix widget.

<pre>[{
  "name" : "Mel Gibson",
  "film": [{
    "film":  [{"initial_release_date>":"2009-01-01", "name":null,
               "key":[{"namespace":"/authority/netflix/tiny", "value":null}]}],
    "id":    null
  }],
  "type":          "/film/actor"
}]​</pre>

Turns out, he&#8217;s been taking it easy recently. There&#8217;s just a couple of movies released on DVD since the beginning of last year.

<pre>{
  "code":          "/api/status/ok",
  "result": [{
    "film": [
      {
        "film": [{
          "key": [{
            "namespace": "/authority/netflix/tiny",
            "value":     "BVmIj"
          }],
          "name": "Edge of Darkness"
        }],
        "id": "/m/04lr63t"
      },
      {
        "film": [{
          "key": [{
            "namespace": "/authority/netflix/tiny",
            "value":     "BVssN"
          }],
          "name": "The Beaver"
        }],
        "id": "/m/09vnjl6"
      }
    ],
    "name": "Mel Gibson",
    "type": "/film/actor"
  }],
  "status":        "200 OK",
  "transaction_id": "cache;cache01.p01.sjc1:8101;2010-07-16T21:13:40Z;0034"
}</pre>

## Creating the Widget

Now that we have the tiny URL, we can create a widget. The [Netflix widget builder](http://developer.netflix.com/Widgets) can be used to create a template for the widget you want to create. When you&#8217;re done configuring your widget, you&#8217;ll end up with some Javascript code that looks like this:

<script src=&#8221;http://jsapi.netflix.com/us/api/w/s/sp100.js&#8221; settings=&#8221;id=http://movi.es/BVdT5&#8243;></script>

Once you&#8217;ve got that, it&#8217;s a simple task to create new widgets. The Tiny URL you grabbed above is used to update the ID, so in the case of &#8220;Edge of Darkness&#8221; you&#8217;d put &#8220;BVmIj&#8221; in place of BVdT5 and end up with this:

<script src=&#8221;http://jsapi.netflix.com/us/api/w/s/sp100.js&#8221; settings=&#8221;id=http://movi.es/BVmIj&#8221;></script>

Which will render on your page like so:



Once you&#8217;ve gotten this all working to your satisfaction, you can even set up the widgets to include your developer key and earn money from Netflix via the [developer Affilliate Program](http://developer.netflix.com/docs/Affiliate_Program).