---
id: 9
title: SociableText
date: 2007-08-18T14:11:33+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=9
permalink: /sociabletext.html
aktt_notify_twitter:
  - yes
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
---
Spurred by the [blog posting](http://www.socialtext.com/movable-path) on our corporate site advertising that we were going to update the MT 3.2 Socialtext Cross-posting plugin to 4.0, I took some time to do the work yesterday and make it true.
  
The MT developer documentation is a little light for 4.0 at this point, so updating the plugin to use the new callbacks was a little like stumbling around in a dark room looking for a particular color of ball. I tried looking at a few other 4.0 plugins but finally ended up just spelunking through the code to figure out which bits I had to flip to get my plugin to work. It was a little trickier because I needed to hijack a bit of the entry template so I could add the ability to turn on/off crossposting, and I wanted it to look spiffy in the context of the rest of the entry page.
  
I managed to get the plugin to work correctly, and am using it to cross-post this post to the [Socialtext Open Workspace](http://www.socialtext.net/open). The plugin is accessable from the [Open Workspace](http://www.socialtext.net/open/index.cgi?sociable_type_movable_type_4_0_socialtext_cross_posting_plugin) as well.
  
One more thing off my list of things to do before I leave. I still need to get the commenting working on the TPF wiki-based bloggish website with OpenID so that we can have one backend running both TPF sites and simply posting the information there will cause the right thing to happen.