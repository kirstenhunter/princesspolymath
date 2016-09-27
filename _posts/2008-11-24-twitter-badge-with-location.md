---
id: 138
title: Twitter badge with location
date: 2008-11-24T14:45:05+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=138
permalink: /twitter-badge-with-location.html
aktt_notify_twitter:
  - yes
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
tags:
  - location
  - twitter
---
In my job as an elf for Santa, I frequently have to travel back to the North Pole to visit with my fellow elves, so it&#8217;s not always easy to tell where I might be.  Given that fact, and my desire to procrastinate a bit, I decided to make a handy badge for my blog that tells people where I am.  Most twitter clients allow you to throw some location information in your posts, so it&#8217;s relatively easy to make it relatively easy for someone to stalk you. 

<div>
</div>

<div>
  So, I started with this excellent <a href="http://blog.pinkandyellow.com/css/create-a-twitter-box-in-your-sidebar-20081106/">post</a> describing how to make a basic twitter (Javascript/HTML) badge.  That page has some handy information on how to set up a badge with no location, and if you don&#8217;t want location, you should probably follow his guide.  But if you want to add in some location information as well, then here&#8217;s the info you need.
</div>

<div>
</div>

<div>
  First, you&#8217;ll need to create a local Javascript file to do your evil bidding.  I plopped mine in my mt-static directory (because I use Movable Type) but you can put it in any static spot on your server.  You can grab mine <a href="http://www.princesspolymath.com/mt-static/test.js">here</a>.
</div>

<pre></pre>

Now that you&#8217;ve got that put on your server, you just need to put some code in your blog template (wherever your other badge stuff is) to get your fabulous information to show up.  The code for the HTML looks yucky in my post, but you can view source and grab the stuff marked as &#8220;TWITTER&#8221;.

<div>
</div>

<div>
  The last piece is styling your box.  I have mine styled so that it matches the rest of my site, but you can make yours work however you like.
</div>

<div>
</div>

<pre>#twitter_div {
border-bottom-style: solid;
border-bottom-width: 1px;
margin-bottom: 10px;
font-family: Arial, Helvetica, sans-serif;
font-size: 0.9em;
padding-right: 5px;
padding-left: 5px;
text-decoration: none;
}
#twitter_location {
margin-left: 25px;
text-decoration: none;
margin-bottom: 10px;
}
#twitter_div ul li {
text-decoration: none;
border-bottom-style: solid;
border-bottom-width: 1px;
padding-bottom: 5px;
margin-bottom: 5px;
}
#twitter_div p {
text-align: right;
padding-right: 6px;
margin-bottom: 10px;
}
</pre>