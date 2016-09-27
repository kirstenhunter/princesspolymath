---
id: 300
title: Watching Craigslist Feeds using Safari or Mac Mail
date: 2011-01-11T17:25:20+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=300
permalink: /watching-craigslist-feeds-using-safari-or-mac-mail.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877197477
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - craigslist
  - rss
  - safari
  - webkit
---
Around June 28 of last year, Craigslist made a change to their feed structure which caused applications using Apple&#8217;s WebKit to be unable to load them. Safari doesn&#8217;t work (neither version 4 or 5), Mac Mail doesn&#8217;t work&#8230; This problem has been discussed on the Apple Support Forms [here](http://discussions.apple.com/thread.jspa?threadID=2492529&start=0&tstart=0) and [here](http://discussions.apple.com/thread.jspa?threadID=2491900&start=15&tstart=0). While this problem is specific to Apple applications, it seems to only be occurring with a few different feed sources, one of them Craigslist.

There are a couple of ways to get around this problem, each of which uses the same general theory. If the structure of the RSS feed is not possible to read in your RSS reader, then use a different structure. What you need to do is pipe the feed through another feed aggregator, such as Yahoo! Pipes or Google Reader &#8211; and then add this feed to your reader.

**Google Reader (requires a Google Reader Account)**

  * Go to http://reader.google.com
  * Add the Craigslist feed to your Google Reader list
  * Select &#8220;Browse for stuff&#8221; in the navigation bar
  * Click &#8220;Create a bundle&#8221;
  * Drag the feed from your list into the bundle, and add it to your shared items
  * Save the bundle and then copy the link from the &#8220;Add a Link&#8221; link to use in your RSS reader

**Yahoo! Pipes (requires a Yahoo! Account)**

  * Go to http://pipes.yahoo.com
  * Click &#8220;Create a Pipe&#8221;
  * Choose &#8220;Fetch Feed&#8221;
  * Type the Craigslist feed URL in the Fetch Feed box
  * Connect the boxes by dragging from the &#8220;dot&#8221; at the bottom of the Fetch Feed box to the Pipe Output
  * Click &#8220;Save&#8221;
  * Add the &#8220;Pipe Web Address&#8221; for your pipe in your RSS reader (or in Safari)

I&#8217;m sure there are countless other ways to achieve the same goal, but these are relatively simple and use tools available to all of us for free. Someday perhaps Apple will fix the issue in WebKit, or the feeds at Craigslist will be adjusted so that they work, but in the meantime you can stay on top of the listings you want to see without having to constantly visit the site.