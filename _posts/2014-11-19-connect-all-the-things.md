---
id: 755
title: Connect All the Things!
date: 2014-11-19T03:30:55+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=755
permalink: /connect-all-the-things.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3240947133
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"757";s:11:"_thumb_type";s:5:"thumb";}'
categories:
  - Geek Stuff
---
<a href="/assets/img/2014/11/135634867_39bafbc3e3_m.jpg" class="grouped_elements" rel="tc-fancybox-group755"><img class="alignleft wp-image-757 size-full" src="/assets/img/2014/11/135634867_39bafbc3e3_m.jpg" alt="135634867_39bafbc3e3_m" width="240" height="180" /></a>At [Defrag](http://www.defragcon.com) this year, I gave a presentation entitled &#8220;Connect all the things&#8221; &#8211; a demo of connecting 4 IoT devices together in a rube goldbergy fashion.  The theory was this:

  * My computer ran a node.js server which controlled the sphero and the Philips Hue lightbulb
  * My raspberry pi had a light sensor and a wifi connection to the drone
  * The sphero ran around randomly, when it collided with something, it emitted a &#8220;collision&#8221; event, triggering the node.js server to turn on the light (using the hue API) &#8211; the raspberry pi noted the light came on and told the drone to fly

Well, that was the theory.  In practice the light sensor that I had was an analog sensor, and the raspberry pi has only digital input pins, so I had to use a breadboard with a [capacitor and resistor](http://www.raspberrypi-spy.co.uk/2012/08/reading-analogue-sensors-with-one-gpio-pin/) to figure out how bright the light was.  This worked great (even during the lunchtime test) but stopped working before the demo.  But I did get the raspberry pi to get the drone to take off, and that made people pretty happy.  Seriously, my only goal was to inspire people to play with this stuff, and based on the comments that&#8217;s exactly what happened, so I call the talk a success!

For those people who are dying to put things together in this way, I&#8217;ve created a github repo called &#8220;[connect-things](https://github.com/synedra/connect-things)&#8220;. The code is there for my mac and the drone, and the README has descriptions of how I set the systems up and what I did to make them go.  It&#8217;s pretty hacky but it wouldn&#8217;t be a rube goldberg device otherwise.

So get out there!  Mash up them hardwares!  Have fun!  If I can do it on a massive stage in front of a hundred people you can do it in your living room&#8230;