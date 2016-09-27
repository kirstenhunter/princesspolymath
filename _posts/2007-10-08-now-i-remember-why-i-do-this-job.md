---
id: 19
title: 'Now I remember why I do this job&#8230;'
date: 2007-10-08T21:00:03+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=19
permalink: /now-i-remember-why-i-do-this-job.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1926797930
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
---
Today I had one of those days you get as a programmer, when everything coalesces in a perfect way to shine a happy light on the universe. I had a list of bugs and a single feature I wanted to add to my Flex program. The single feature (dynamic filtering based on values in a set of arrays) took me a long time, and I wrestled with it mightily for several hours. I wanted desperately to make a filter which was extensible, which was easy to add new fields to, and passing variables around in Flex is not something I&#8217;ve become comfortable with.
  
So there I was, pounding my head against the thing, frustrated and feeling incompetent, until 4PM when a light shined down upon me from the sky, the scales fell from my eyes, whatever cliche you want to use&#8230; and the feature was complete. And when the dust cleared, I realized that 3 of the bugs on my &#8216;to-do&#8217; list had gotten fixed in the process of creating this feature.
  
It&#8217;s an awesome day when you feel &#8220;done&#8221; with what you&#8217;re working on. I wasn&#8217;t even tempted to start on something else&#8230; I just basked in the glow of having gotten it done.
  
For anyone wandering here from flex land who wants to see the code, here it is:

<pre>private var filterObj:Object = {this:filterThis,that:filterThat};
// These arrays are populated elsewhere with a list of strings to filter on
private var textObj:Object = {this:"",that:""};
private function filterAll():void {
var filtered:Boolean = false;
var filterType:String;
for (filterType in filterObj) {
if (filterObj[filterType].length > 0)
filtered = true;
}
if (filtered) {
dataSet.filterFunction = filterGeneralSet;
dataSet.refresh();
} else {
dataSet.filterFunction = null;
dataSet.refresh();
}
private function filterGeneralSet(item:XML):Boolean {
var filterType:String;
var element:String;
var myArray:Array;
// This is an 'and' filter where everything has to match for the element to return true
for (filterType in filterObj) {
if (filterObj[filterType].length > 0) {
myArray = filterObj[filterType];
for each (element in filterObj[filterType]) {
var itemFilter:String = item.child(filterType)[0];
if (itemFilter != element) {
return false;
}
}
}
}
return true;
}
</pre>