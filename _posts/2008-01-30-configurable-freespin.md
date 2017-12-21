---
id: 25
title: Configurable FreeSpin
date: 2008-01-30T11:14:25+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=25
permalink: /configurable-freespin.html
aktt_notify_twitter:
  - yes
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
dsq_thread_id:
  - 2199775158
categories:
  - Uncategorized
---
A few months ago, Ketan Anjaria (aka KidBombay) made a cool [spin viewer](http://kidbombay.com/clients/freebase/freeSpin/) for things in freebase. One of my projects at [Applied Minds](http://www.appliedminds.com) is going to be springboarding off of that code, so I started off by changing the code to make the client configurable. We&#8217;re contributing our changes back to the code base, and Metaweb is going to release the FreeSpin code as Open Source soon at which point folks can play with the code themselves, but in the meantime anyone can create their own viewer for their favorite freebase types by grabbing the swf file and creating an xml file to drive the viewer.
  
I have an example of the [VentureSpin](http://www.perlgoddess.com/FreeSpin/FreeSpin.swf) client, which is controlled by an [XML file](http://www.perlgoddess.com/FreeSpin/freeSpin.xml) in the same directory. Similarly, there is a [FilmSpin](http://www.perlgoddess.com/FilmSpin/FreeSpin.swf) client, controlled by its own [XML file](http://www.perlgoddess.com/FilmSpin/freeSpin.xml).
  
<span class="mt-enclosure mt-enclosure-image"><img alt="This is a picture" alt="FreeSpin.jpg" src="http://www.perlgoddess.com/perlgoddess/FreeSpin.jpg" width="400" class="mt-image-left" style="float: left; margin: 0 20px 20px 0;" /></span>
  
To make this all work for you, all you need to do is grab one of the FreeSpin.swf files and put it on your own web server, and create a freeSpin.xml file (I know, the capitalization is a pain, I promise to fix that soon) in the same directory, and it should work like a charm.
  
If you do use it, let the folks at [Metaweb](http://blog.freebase.com/?p=91) know where your viewer is so they can see how people are browsing their data.