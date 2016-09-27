---
id: 509
title: LinkedIn Today SMS Notification System using LinkedIn, Twilio, Django and Heroku
date: 2011-12-22T17:23:16+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=509
permalink: /linkedin-today-sms-notification-system-using-linkedin-twilio-django-and-heroku.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1876773357
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - Uncategorized
  - Web APIs
tags:
  - django
  - heroku
  - linkedin
  - python
  - twilio
---
[<img width=550 src="http://www.princesspolymath.com/princess\_polymath/wp-content/uploads/2011/12/today\_screenshot.png" class="grouped_elements" rel="tc-fancybox-group509">](http://falling-summer-4605.herokuapp.com/)
  
At LinkedIn we enjoy a monthly [Hackday](http://blog.linkedin.com/2011/06/09/10-ways-to-make-hackdays-work/ "Hackday"), and I usually use the opportunity to figure out new ways to combine our platform with other systems &#8211; I love combining different APIs to create new functionality.

This month I decided to use my hackday time to create an [SMS notification system for our LinkedIn today system](http://falling-summer-4605.herokuapp.com/). Since I&#8217;m not always on the website, I frequently miss the viral articles being discussed until they&#8217;ve passed into my history, and I&#8217;d like to be able to jump in on the conversation while it&#8217;s hot.  Using the LinkedIn Today API (currently only available internally), the system periodically checks each members feed &#8216;s see if there are any articles which are currently generating a huge amount of activity .  Once these &#8220;hot&#8221; articles are found, they are sent via SMS (using Twilio) to the user&#8217;s cell phone and recorded in the DB.  The member can reply to the SMS with &#8220;save&#8221; to add the article to their saved articles at LinkedIn, &#8220;share&#8221; the article with their LinkedIn network, change the notification level or cancel notifications entirely.
  
<img width=175 src="http://www.princesspolymath.com/princess\_polymath/wp-content/uploads/2011/12/IMG\_0239.jpg" alt="Welcome message" /> <img width=175 src="http://www.princesspolymath.com/princess\_polymath/wp-content/uploads/2011/12/IMG\_0238.jpg" alt="Welcome message" /> <img width=175 src="http://www.princesspolymath.com/princess\_polymath/wp-content/uploads/2011/12/IMG\_0237.jpg" alt="Welcome message" />
  
In order to build this system, I realized that I had to get several different systems to work together, and working through this process I realized that I had to solve several common problems.  This series of posts will be a tutorial on how to do the following:

  * [Integrate Log in with LinkedIn into Django and deploy to Heroku](http://www.princesspolymath.com/princess_polymath/?p=511)
  * [Use the Heroku scheduler and python to send SMS messages using Twilio](http://www.princesspolymath.com/princess_polymath/?p=521)
  * [Handle SMS responses from Twilio in Django (on Heroku)](http://www.princesspolymath.com/princess_polymath/?p=531)

<div>
  These are building blocks that can be used for many similar projects, so I include them here to be an inspiration for future developers trying to get something working.  I enjoyed the resulting demo application enough that I ended up creating a web front-end to the system (so people could configure it) &#8211; you can get to the application at <a href="http://falling-summer-4605.herokuapp.com/">http://falling-summer-4605.herokuapp.com/</a>
</div>