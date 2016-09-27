---
id: 787
title: Glue-ing together APIs for GlueCon
date: 2015-05-21T08:44:28+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=787
permalink: /glue-ing-together-apis-for-gluecon.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3782797403
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"789";s:11:"_thumb_type";s:5:"thumb";}'
categories:
  - Uncategorized
---
Last year, at Defrag, I made my IoT rube goldberg machine made up of a sphero, hue lightbulb, raspberry pi and my drone.  I might have accidentally almost attacked the audience with the drone.  But it was a success and entertaining for all.

This year, instead of doing that, I&#8217;m doing a fitness Rube Goldberg machine.  I&#8217;m going with the carrot/stick approach to making sure that people keep up their activity.  During the day, it checks your fitbit/myfitnesspal and sends you an SMS if you&#8217;re falling behind.  Also, it updates the color of a Philips hue lightbulb as you advance through the day.  If I had an IoT lock I&#8217;d unlock the freezer to get some Ben and Jerry&#8217;s ice cream as soon as I was done with my activity and protein.

This was made possible by a couple of other peoples&#8217; excellent demos, which I basically glommed together into a new thing.  So here, for your coding pleasure, are the original repos and mine as well, so you can also nag yourself to do the right thing.  And buy one of those lock things.  Seriously, that seems so cool!

  * Jeremiah Cohick&#8217;s [fitbit-twilio-demo](https://github.com/jeremiahlee/fitbit-twilio-demo)
  * Romain Huet&#8217;s [twitter-platform-demos](https://github.com/romainhuet/twitter-platform-demos)
  * Kirsten Hunter (that&#8217;s me)&#8217;s [fitfood](https://github.com/synedra/fitfood) (patches strongly encouraged, appreciated, and rewarded 🙂

My slides are on [HaikuDeck](https://www.haikudeck.com/quantifying-your-fitness-uncategorized-presentation-VUf5BNH6E1#slide-4).