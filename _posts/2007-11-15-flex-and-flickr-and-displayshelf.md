---
id: 24
title: Flex and Flickr and DisplayShelf
date: 2007-11-15T11:07:44+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=24
permalink: /flex-and-flickr-and-displayshelf.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1877196300
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - api
  - flex
  - flickr
---
I&#8217;ve been working with the fabulous DisplayShelf code from simplyscheming.com to try to make various types of browsers in Flex. Yesterday, I \*just about\* had it working to browse images from flickr, but I ran into the old &#8216;checkpolicyfile&#8217; problem. Even though Flickr has been nice enough to put crossdomain.xml files on all their static servers, the DisplayShelf code needs to manipulate the image as a bitmap to make the groovy reflection underneath the picture.
  
I found places where people fixed this problem by changing LoadContext, and other places where people added trustContent to the Image, but I couldn&#8217;t figure out how to make this work correctly in the context of DisplayShelf.
  
Fortunately, there in the code was a reference to someone I&#8217;d worked with a zillion years ago (ok, 13), and I pinged him to ask for help. He gave me the magic answer, which looks like this (you&#8217;ll need to &#8216;view source&#8217; to see it, I&#8217;m not sure how to get HTML-ish things to show up in MT).

<pre>Original DisplayShelf component in mxml:
&lt;local:displayshelf id="shelf" borderthickness="2" bordercolor="#000000" dataprovider="{dataSet}" enablehistory="false" width="7" angle="10" popout=".35" change="currentInfo();">
New DisplayShelf component:
&lt;local:displayshelf id="shelf" height="300" borderthickness="2" bordercolor="#000000" dataprovider="{DataModel.getInstance().photoInfo}" enablehistory="false" width="5" angle="10" popout=".35" change="currentInfo();">
&lt;local:itemrenderer>
&lt;mx:component>
&lt;mx:image trustcontent="true">
&lt;/mx:image>&lt;/mx:component>
&lt;/local:itemrenderer>
&lt;/local:displayshelf>
&lt;/local:displayshelf></pre>

Seemed a little obscure, but it works and now my browser is happy.
  
Thanks to [NJ](http://www.rictus.com/) for saving my sanity 🙂