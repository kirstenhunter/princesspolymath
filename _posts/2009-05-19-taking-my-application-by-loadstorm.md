---
id: 146
title: Taking my application by LoadStorm
date: 2009-05-19T16:33:57+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=146
permalink: /taking-my-application-by-loadstorm.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1915019726
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
---
One of my work projects has gotten to the point where we really need to have some performance numbers under stress.  I played with [The Grinder](http://grinder.sourceforge.net/), poked at [JUnit](http://www.junit.org/), and looked around at some of the other tools out there.  I was limited by the fact that I only have one system, and it&#8217;s very hard to make a single system look like a hundred systems&#8230; and real load testing works best when you have multiple clients whacking on the system for you. 

<div>
</div>

<div>
  So, given my previous experience setting up parallel processing things on Amazon Web Services using hadoop, I thought perhaps I should just build a new system using AWS.  But that seemed like a lot of up front work considering that the actual questions we were trying to answer were &#8220;How many concurrent users can the system handle?&#8221; and &#8220;What happens when you go over that limit?&#8221;  Simple enough questions, and hard to justify tens of man hours putting together a new prototype just to answer them.
</div>

<div>
</div>

<div>
  So, despite my engineery heart insisting that anything Not Invented Here couldn&#8217;t possibly do the job, I poked around half-heartedly looking for an existing system to do what I needed.  And lo and behold, I found one!  <a href="http://www.loadstorm.com">LoadStorm</a> is a web-based SAAS which does load/stress/performance testing for your system.  It&#8217;s free for up to 100 users/minute (and up to 60 minutes), and you can give it multiple steps for each of your users to do (along with some random wait time to better emulate real people).
</div>

<div>
</div>

<div>
  LoadStorm has a reasonably friendly front-end for setting up your servers and tests, but where it really shines is in the analysis &#8211; manager-friendly charts and graphs to make the testing results palatable to the people who really need to understand them.  Their team is extremely attentive and helpful, and I would highly recommend them to anyone curious about the outer bounds of their system&#8217;s capabilities.
</div>

<div>
</div>

<div>
  I was able to use LoadStorm to quantify the improvement we gained by making a structural change to the system, in an easy-to-understand format.  Playing with it further has given me a much stronger understanding of the strengths and weaknesses of our system.
</div>

<div>
</div>

<div>
  Like I said, highly recommended.  Screenshots below.
</div>

<div>
</div>

<div>
</div>

<div>
  <span class="mt-enclosure mt-enclosure-image" style="display: inline;"><img alt="This is a picture" alt="users.jpg" src="/assets/img/2009/08/users.jpg" width="600" class="mt-image-none" style="" /></span>
</div>

<div>
</div>

<div>
  <span class="mt-enclosure mt-enclosure-image" style="display: inline;"><img alt="This is a picture" alt="errors.jpg" src="/assets/img/2009/08/errors.jpg" width="600" class="mt-image-none" style="" /></span>
</div>

<div>
</div>