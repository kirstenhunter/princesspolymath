---
id: 18
title: Perl Docs vs. Other Docs
date: 2007-10-05T07:01:31+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=18
permalink: /perl-docs-vs-other-docs.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 2609179477
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
---
I&#8217;ve been fussing with Flex this week (as I threatened earlier) and even with my fabulous experience of the tutorials, I have to admit that I&#8217;ve been seriously spoiled by working with Perl for so long. It&#8217;s such a mature language that someone else has \*always\* done something similar to what I&#8217;m trying to do, so I can find something to crib off of and get most of the work done. Even outside of CPAN, folks have code samples and examples and conversations on mailing lists explaining why things work (or don&#8217;t).
  
Flex is not so much with the easy documentation. I consider myself an expert on finding the answer to puzzling questions, and this week I&#8217;ve been faced with many, many puzzling questions which are not easily answered in the book(s) I have nor on any site I can find. Sure, someone has generally answered the basic question but I never seem to need help with those.
  
For example, yesterday I tried to figure out how to coerce an XMLList into an Array. Seems like it should be simple. I have a list of XML things. Please tell me what their labels are. Thank you. Perl wouldn&#8217;t have any trouble giving me an array from something array-ish. But no. I spent a couple of hours trying to shove the square peg into the round hole, and at lunch went by Borders to peek at one of the books there and discover that the only way to make an Array out of XMLList entries is&#8230; to iterate over the list and shove them in one by one. Ick.
  
Turns out I didn&#8217;t really want to put an array in there anyhow, since I want to be able to change the list on the fly and do magical things with it &#8211; so passing in the collection itself was the right thing. But hey, the yak needed shaving, so I spent the time to do it right.
  
And this morning I wanted to do something fairly simple. I wanted to make a button glow when you push it, and unglow when you push it again. This is not hard. I want to maintain the state of the button in a variable which I&#8217;ll use elsewhere. Surely someone has wanted to do this before&#8230; but I couldn&#8217;t find any examples.
  
I did, however, figure it out, so I&#8217;ll put it here in case anyone else is trying to glow and unglow buttons in Flex.

<pre>&lt;mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">
&lt;mx:Script>

public var Glowing:Boolean = false;
public function glowMe():void {
if (Glowing) {
buttonGlow.reverse();
Glowing = false;
} else {
buttonGlow.play();
Glowing = true;
}
}

&lt;/mx:Script>
&lt;mx:Glow id="buttonGlow" color="0x99FF66" alphaFrom="1.0" alphaTo="0.0" duration="100" target="myButton"/>
&lt;mx:Panel x="10" y="10" width="200" height="300" layout="absolute">
&lt;mx:Button x="40" y="60" label="View" id="myButton" mouseUpEffect="{buttonGlow}" click="{glowMe()}; myLabel.visible=true;"/>
&lt;/mx:Panel>
&lt;/mx:Application>
</pre>