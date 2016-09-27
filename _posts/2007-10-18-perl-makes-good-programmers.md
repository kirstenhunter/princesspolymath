---
id: 20
title: Perl Makes Good Programmers
date: 2007-10-18T18:58:21+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=20
permalink: /perl-makes-good-programmers.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 2590129040
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
tags:
  - flex
  - modular
  - perl
---
I bet you think that I&#8217;m kidding, right? Perl allows programmers to build extremely bad habits, doesn&#8217;t force discipline, encourages shortcuts that simply aren&#8217;t possible in other languages. But I&#8217;m actually serious.
  
I had a conversation with my new boss a few weeks ago that went something like this:
  
Boss: Do you know what data driven design is?
  
Me: No.
  
Boss: <explains the concept> (google it if you don&#8217;t know 🙂
  
Me: Oh. That&#8217;s how I code.
  
Boss: Good
  
So it occurred to me to wonder why it was that I code that way, what with my lack of formal education and all. I went to the [Pittsburgh Perl Workshop](http://pghpw.org/) last weekend (my OpenID presentation went great, thanks for asking &#8211; I used sock puppets to describe the user/website/server interaction) and spent a great deal of time thinking about how perl people write code and why, and I realized that I code this way (with reusable, modular, configurable code) \*because\* I work in Perl.
  
The easiest way to get started doing something with Perl is to pull down some helper code from CPAN. All of that code (ok, not all of it, but most of it&#8230; well, ok, the parts I actually use) was written in a modular way, designed to be configured to work for multiple applications. The more time someone spends writing Perl code, the more likely they are to approach each new problem in a modular way (I need something to do A and B, and then C to tie them together) &#8211; this makes it easier to use CPAN to reduce your workload, but also means that when you write the code you&#8217;re likely to avoid hard coding anything in the program itself.
  
When I started working in Flex, I was a little frustrated that it was so difficult to find examples where developers had pulled the configuration information out into a separate file, but the truth is that&#8217;s not terribly surprising. First, there simply aren&#8217;t nearly as many examples of Flex code out there, so it&#8217;s harder to find any specific thing. Second, without the external community pushing developers to think beyond their current application, it&#8217;s easy to fall into the habit of taking the shortest path to &#8220;done.&#8221; Working with Perl (and some seriously critical programmers) for (ack!) thirteen years has given me an allergy to hard coding \*anything\* in my programs. Which makes it harder for me to spit out something quick and dirty, but makes the things I \*do\* make much more powerful.