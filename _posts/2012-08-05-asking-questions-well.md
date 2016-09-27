---
id: 584
title: Asking Questions Well
date: 2012-08-05T10:21:04+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=584
permalink: /asking-questions-well.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877196698
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - Uncategorized
  - Web APIs
---
One of the most frequent issues developers (and support people) have is that questions aren&#8217;t asked completely, and both people end up enmeshed in an iterative clarification cycle, unable to resolve the issue until both people understand what&#8217;s going on. There&#8217;s a decent [FAQ on asking questions](http://stackoverflow.com/questions/how-to-ask) on StackOverflow, which does tell you to share details and context, but I&#8217;m going to go a little further and give you a template for asking questions which should help you get answers quickly.

What does a good problem statement look like?

> I did X.
  
> I expected Y to happen.
  
> To my dismay, Z happened instead.

All three pieces are necessary, because frequently the problem is your expectation, not the system you&#8217;re trying to use. To clarify, let&#8217;s look at an example.

> I jumped off a cliff.
  
> I expected to sprout wings and fly across the ravine.
  
> To my dismay, I plunged to my death instead.

Bummer. But the problem wasn&#8217;t really about gravity, it was that you expected something to magically happen to counteract it. Frequently users don&#8217;t understand how a system works, or what should be expected &#8211; this doesn&#8217;t make your question bad, by any stretch of the imagination. Part of supporting a product is making sure your users know what to expect, and the documentation may need updating. But the support person isn&#8217;t going to be able to help you if they don&#8217;t know why you think it&#8217;s broken. It may seem obvious to you what should happen, but trust me &#8211; more often than not including this piece will get you to your answer faster.

So, let&#8217;s go through this piece by piece&#8230;

## I did X

When you&#8217;re explaining what you did, you need to include all the context you can.

  * What were you doing, exactly?  Can you reproduce the issue consistently?
  * Was it a web issue?  If so, which browser were you using?  Did you try other ones?
  * What exact URL or application were you using?  How can someone exactly recreate what you were doing?
  * If you&#8217;re coding, what language are you using?  Are you using a library?  Include an example of the specific code in question, with pointers to the library and examples you&#8217;re following (if applicable)
  * If you&#8217;re using a web service, what exactly did your request look like?  What were the headers and URL?  If you don&#8217;t know how to get those pieces, you need to know &#8211; read [this article](https://developer.linkedin.com/documents/debugging-api-calls) for some pointers.

## I expected Y to happen

What did you hope to happen?  Lots of times with an error message or broken request, it&#8217;s obvious what you wanted to happen.  It&#8217;s still worth your while to include a quick statement.  But if you got a successful response that didn&#8217;t match what your expectation was, explain completely and clearly what you were expecting to get, and why.  Point to the documentation supporting your expectation (because it may well need an update or clarification).

## To my dismay, Z happened instead

I try to always keep the &#8220;To my dismay&#8230;&#8221; part in there.  It amuses me, it amuses the person answering my question, and it acknowledges the truth of asking a question in this situation &#8211; I&#8217;m frustrated and sad that I&#8217;m stuck because something isn&#8217;t working how I want.

But just like with the &#8220;I tried X&#8221; part, you need to be very specific about what happened.

  * Did you get an error in a console or as a result? What did it say, exactly?
  * What did you try to get around the issue?
  * If you&#8217;re using a web service, what were the headers, status code, and/or body returned by the server
  * Note that if you are using a library that wraps a web service but asking for help from the API provider themselves, you likely need to dig down and see what the call itself looks like (as the API provider probably doesn&#8217;t support the third party libraries)

Following these guidelines will mean it takes a little longer for you to craft your question, but it will save you time, and most importantly, it will save people who might have the answer time. Posting incomplete questions wastes the time and energy of people who might otherwise help you (and they may not come back to see if you&#8217;ve added clarification). Showing them that you value their time and energy by completely explaining the issue will increase your chances of getting a complete answer &#8211; and if iteration cycles are needed they&#8217;ll be much more valuable.