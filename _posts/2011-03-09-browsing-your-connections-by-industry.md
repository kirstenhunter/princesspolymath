---
id: 404
title: Browsing your LinkedIn Connections by Industry
date: 2011-03-09T15:18:02+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=404
permalink: /browsing-your-connections-by-industry.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877197655
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - JSAPI
  - LinkedIn
  - Uncategorized
  - Web APIs
tags:
  - api
  - javascript
  - linkedin
---
I presented at the [Semantic Web Meetup](http://www.meetup.com/The-San-Francisco-Semantic-Web-Meetup/events/16940644/) in San Francisco about this topic, slides for that talk can be found [here](/assets/img/2011/06/semantic-Presentation.pdf).

A friend of mine, who runs a [rather cool website](http://www.dailyendeavor.com), asked me to help him understand how to create an industry-based query to see which of your connections are in a particular industry.  As this was a slightly trickier-than-usual problem, I put together an example for him to use, and I&#8217;ll go over how it works here.

But first, the obligatory working demo:

And the [code](http://www.princesspolymath.com/dailyendeav/industry.html). Note there are a couple of support files you&#8217;ll need to snag as well.

In order to keep this post manageable, I&#8217;ll mention that most of the pieces for this are included in my [StreamIn&#8217;](http://www.princesspolymath.com/princess_polymath/?p=347) tutorial. So if you&#8217;re interested in understanding how the basic framework works, take a look there. We&#8217;re basically going to break out on &#8220;Add Share Stream&#8221;.

### Industries

One of the reasons that this example is somewhat tricky is that the API doesn&#8217;t currently have a way to give you a list of industries, and how they&#8217;re related, but we do have a [web document](http://developer.linkedin.com/docs/DOC-1011) (which is fairly static) with that information. So I grabbed the HTML from that page, fiddled with it in my editor, and created a JSON document with a hash of industries (and the groups they map to) and groups (and the industries they contain). You can see that file [here](http://www.princesspolymath.com/dailyendeav/industries.js). Loading that file as a javascript script gives the page access to hashes of this information.

### Autocomplete

Hey, since we&#8217;ve made this handy hash, it&#8217;s a cinch to provide a jQuery autocomplete for the industries.

<pre>var data = Object.keys(industry_names);
	$("input#Industry").autocomplete({
	   source: data,
	   select: function() { getConnections() }
	});</pre>

Titles is not really a bounded set of this type, so I&#8217;ll just let the user input that freestyle.

### Getting the connections

The logic I wanted to use was&#8230; find all my 1st or 2nd degree connections in the industry who match the title. If there are fewer than 25 of those, do another search for all of the industries in the industry group. You can see how that stacks in the code, so I&#8217;ll just talk through the actual call for the first search.

<pre>$("#connections").html("");
	var industrynum = industry_names[$("#Industry").val()]["code"]
	var title = $("#Title").val();
	path = "/people-search:(people:(id,first-name,last-name,public-profile-url,
                  three-current-positions:(title,company:(name,industry)),distance,picture-url))?
                  sort=distance&facet=industry," + industrynum + "&title=" + title + "&current-
                  title=true&facet=network,F,S&count=25"</pre>

So, clear the div we&#8217;re gong to use. Grab the code from the industry hash based on what&#8217;s in the Industry user input field. Pull the title from the Title input field.

In this case we&#8217;re using the [People Search resource](http://developer.linkedin.com/docs/DOC-1191) with some [field selectors](http://developer.linkedin.com/docs/DOC-1014) to request specific [profile fields](http://developer.linkedin.com/docs/DOC-1061) for the users who are returned. That&#8217;s this part:

<pre>people-search:(people:(
                     id,first-name,last-name,public-profile-url,
                     three-current-positions:(title,company:(name,industry)),
                     distance,picture-url))</pre>

Why three-current-positions? Because I can&#8217;t just ask for one current position, and this list will be smaller and faster than all the positions.

We also need some very specific filters on our search, so we&#8217;re using facets (also covered on the [People Search](http://developer.linkedin.com/docs/DOC-1191) page) to get us only the members in our network who have the right title and industry. Let&#8217;s go over those things individually:

  * sort=distance : distance from me, i.e. degree (first or second)
  * facet=industry,xx : I want only users who are working in this industry (like Entertainment or Internet)
  * title=yyy : This is a fuzzy string match. Doesn&#8217;t have to match exactly.
  * current_title=true : Don&#8217;t tell me about their past positions. I want people doing this right now
  * facet=network,F,S : First and Second degree connections only.
  * count=25 : I don&#8217;t have all day and I&#8217;m only going to show 25 total results in any case.

All right, now that that&#8217;s settled, let&#8217;s make the call. The Raw API call we&#8217;re making reaches directly through to the back end REST API.

<pre>IN.API.Raw(path)
	  .result(function(result) {
	    var count = result.people.values.length;
	    var html = $("#connections").html();
	  	for (var index in result.people.values) {
	  		var person = result.people.values[index]
	  		html += "&lt;div class=\"connectionitem\"&gt;";
	  		if (person["pictureUrl"]) {
		  		html += "&lt;img src= \"" + person["pictureUrl"] +
                                              "\"  width=40 align=right/&gt;";
			}
			var distance = (person["distance"] === 1 ? '1st' : '2nd')
	  		html += "&lt;a href=\"" + person["publicProfileUrl"] + "\"&gt;&lt;h3&gt;" +
                                      person["firstName"] + " " + person["lastName"] +
                                      " (" + distance + ")&lt;/h3&gt;&lt;/a&gt;";
	  		html += person["threeCurrentPositions"]["values"][0]["title"] +
                                    ", " + person["threeCurrentPositions"]["values"][0]["company"]["name"] +
                                   " (" + person["threeCurrentPositions"]["values"][0]["company"]["industry"] +
                                   ") &lt;/div&gt;";
	  	}
	  	$("#connections").html(html)
	  });</pre>

Just as in the other tutorials, the JSAPI method (in this case IN.API.Raw()) is called with chained methods indicating how it should be executed. In this case, we just want to perform a GET on the resource, and process the results, so .results is the only thing we&#8217;re setting.

Just like in the StreamIn&#8217; tutorial, the results are iterated over person by person and a collection of connectionitems is gathered together, made pretty, and plopped in the &#8220;connections&#8221; div.