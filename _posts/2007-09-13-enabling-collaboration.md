---
id: 14
title: Enabling Collaboration
date: 2007-09-13T08:14:53+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=14
permalink: /enabling-collaboration.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 2432682917
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
---
I installed Socialtext on a system at AMI (and hey, who knew, it&#8217;s actually \*less\* work to install on debian etch than on ubuntu dapper) so that various groups could use it for project coordination and collaboration. So far my workspace is just me writing a boat-load of pages, but I have hope that it will turn out to be an excellent way to communicate progress and record our thoughts.
  
Once the system was set up, I decided to make an IRC server so that I can actually hang out with the people I work with, even though they&#8217;re in a whole nother part of the state. Since I had a debian box, and since I am very lazy, I looked to see what I could get with apt and ended up with ircd-hybrid. Took some fussing and fighting but I got it all running and working, and then I decided to add a bot.
  
Socialtext uses PerpLog for our logging, but since I wasn&#8217;t really planning to put in a purple wiki and I wanted something more actively loved (sorry, cdent) I checked the apt-cache for IRC bots. My first choice was &#8220;blootbot&#8221;<http://blootbot.sourceforge.net/> because it&#8217;s written in Perl and seems to have all the bells and whistles I might need &#8211; plus Perl means I can add functionality easily. Unfortunately, I didn&#8217;t manage to find the documentation (cleverly hidden on the sourceforge site) until too late, and even then the docs are pretty darned skimpy.
  
I ended up using [supybot](http://supybot.com/documentation), which is written in Python and has a phenomenal set of documentation on installing it, configuring it, writing plugins, playing with it, just generally anything. After installing it I decided to take a slight detour in my day to write a simple plugin for looking up directory information within our company:
  
kirsten: !cell Kirsten
  
soupy: kirsten: Kirsten Jones: Cell 831-123-4567
  
We have an LDAP server which doesn&#8217;t have all of the info I want, and a directory page which does, so I entered the magical world of screen scraping. Python has a library called BeautifulSoup which parses an HTML document and builds a tree of objects. Once that&#8217;s done, you just have to figure out how to navigate to the piece you want and spit it out. Took me a little while to get it working correctly, but it does, and now I have both some plugin experience (for making more) and a plugin to save me from the horrible fate of going to a web page to find someone&#8217;s cell phone.
  
I certainly could have done the same thing with blootbot, but I didn&#8217;t have all day to peer through the code to determine how it worked. The lesson here is that documentation is extremely important &#8211; all throughout the supybot docs the point is reiterated that the developers of the bot want input and help to make it the best bot ever&#8230;
  
Plus, I needed to brush up my Python skills.