---
id: 657
title: Conversations
date: 2013-10-25T11:06:31+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=657
permalink: /conversations.html
dsq_thread_id:
  - 1900076067
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - Uncategorized
  - Web APIs
---
At the [API Strategy and Practice conference](http://www.apistrategyconference.com), I gave a workshop on API 101 ([slides](http://www.slideshare.net/synedra/api-101-understanding-apis)).  I was lucky to have my actual mother in the audience so I could make &#8220;Even your mom can understand&#8221; jokes, which was great (I got her permission first, and kudos to her for letting us gently tease her in front of 150 strangers).  But also it gave me the opportunity to give a talk that even my (very smart, artistic, non-technical) mother could understand.  As I was working on the more technical pieces I realized that we have a self-referential problem frequently when trying to describe API Transactions.  We talk about parameters, headers, meta-information, requests and responses as if these terms were meaningful to a real person. Not really, no.  So, I submit the following thoughts for your consideration.

So first &#8211; what is an API? What is it like?  The easiest comparison I could come up with was the old time switchboard operator.  Your phone didn&#8217;t have to know how to get ahold of Aunt Mae, it just needed to know how to talk to the operator, and he or she would do what was necessary to connect you two.  An API is a computer version of this abstraction.

Now, for the juicy bits.  Transactions are conversations between computers.  This conversation can be boiled down to something that should amuse people who know me at all. Follow along while I describe the pieces of the HTTP Transaction like ordering an iced tea from Starbucks.

  * Resource ID: &#8220;Iced tea&#8221;
  * HTTP Verbs 
      * POST: &#8220;I&#8217;d like to order an iced tea&#8221;
      * GET: &#8220;Can you read my order back to me?&#8221;
      * PUT: &#8220;Actually, make it larger&#8221;
      * DELETE: &#8220;Oh no, I left my wallet at home! Never mind&#8221;
  * Parameters: &#8220;Extra ice, unsweetened&#8221;
  * Headers: &#8220;For here or to go?&#8221;

Once you&#8217;ve walked through this conversation example you can get a little more technical &#8211; your browser uses headers to tell the server what language you speak.  Changes and substitutions are added to the name of the item.

I challenge my geeky friends to think of other ways to describe technical things without using technical terms that are meaningless to the general public.  What other examples can you think of?

&nbsp;