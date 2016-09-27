---
id: 10
title: Freebasing at Metaweb
date: 2007-08-24T11:24:04+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=10
permalink: /freebasing-at-metaweb.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1991206831
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
tags:
  - freebase
  - games
  - metaweb
  - perl
  - perl foundation
---
I had the opportunity to spend a few hours talking with the Metaweb team yesterday, which was really fun. I&#8217;m excited to have the opportunity to contribute to this project &#8211; it&#8217;s new technology with exciting possibilities, building a community of diverse people (developers, content experts, lookie-loos). We discussed ways to deal with the various administrative issues they&#8217;re running into (having people administer the system without accidentally breaking it).
  
During the conversation, I contemplated the [Game Browser](http://www.perlgoddess.com/) application I&#8217;d created to learn about Metaweb and [Freebase](http://www.freebase.com) (now open for public read access! go take a look!). Don&#8217;t be bowled over by the irony, that you&#8217;re looking at the root of a site named &#8220;perlgoddess&#8221; and the application is written in Freebase. It&#8217;s not the sexiest implementation of an [mjt](http://www.mjtemplate.org) application but you could use it to springboard all kinds of data browsers.
  
The backend data for the board games is a little weak (because most of it was added manually by me), so I have some notions to fix that:

  * Use the wonderful [XML API](http://www.boardgamegeek.com/xmlapi/) offered by boardgamegeek to populate lots of useful information in freebase. I asked for permission and they haven&#8217;t gotten back to me so I think I&#8217;ll take the middle road of making the importer and importing into the sandbox and then point that out to them so they can ask me to remove it if necessary.
  * Poke around in freebase to find places where there are board games that haven&#8217;t been tagged correctly, there seem to be lots of them. I&#8217;ll probably write a tool that accepts a ruleset and then optionally adds properties onto types. </ul> 
    I was also tempted greatly by the notion of creating a couple of tools to make it easier to administer freebase itself, having heard about some of the challenges there:
    
      * User history, including things like &#8216;number of entries created&#8217;, &#8216;number of entries updated&#8217;, &#8216;posts to discussion boards&#8217;, &#8216;replies to discussion boards&#8217; and other such things. The Metaweb team would love to be able to identify and encourage subject matter experts and this would help find them.
      * Recent posts &#8211; they have a browser for recent discussion posts, but it would be cool to make one that remembers your preferences and filters by domain so you don&#8217;t have to see all of them. It&#8217;d be a fun MJT tool to create, so maybe I&#8217;ll get to that.
  
        [skud](http://www.boardgamegeek.com/xmlapi/) created a [Metaweb perl module](http://search.cpan.org/~skud/Metaweb-0.02/lib/Metaweb.pm), and [WWW::Metaweb](http://search.cpan.org/~hds/WWW-Metaweb-0.01/lib/WWW/Metaweb.pm) was created by Hayden Stansby. They take a slightly different approach to the interface, and I&#8217;m excited to have the opportunity to work with each of them. I&#8217;m hoping the friendly competition helps us as a community figure out the best API possible.
  
        All that having been said, I&#8217;m \*this close\* to having finished the new bloggy interface for the TPF website. I need to push through and get that done so we can finish up the infrastructure changes for that. Once I do that I can play with the shiny toys above.</p>