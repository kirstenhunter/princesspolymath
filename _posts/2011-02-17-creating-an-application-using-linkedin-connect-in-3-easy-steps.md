---
id: 347
title: Creating an Application using LinkedIn Platform in 3 Easy Steps!
date: 2011-02-17T10:15:03+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=347
permalink: /creating-an-application-using-linkedin-connect-in-3-easy-steps.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1876127123
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - JSAPI
  - LinkedIn
  - Web APIs
tags:
  - api
  - javascript
  - linkedin
---
The LinkedIn API has all sorts of juicy goodness to it, but the authentication and structure take some learning. LinkedIn has created a JS API called Connect to help you get around those things, so that you can focus on the logic and presentation of your application without spending too much time considering the back end.

I made an internal presentation covering this material at LinkedIn on 2/18, which is available in [PDF format](/assets/img/2011/02/JSAPI_Deck.pdf). This tutorial has also been [integrated](http://developer.linkedinlabs.com/tutorials/jsapi_simplestream/) into the general JSAPI tutorials on the developer portal. That version has a lot less narration and is just about getting the code written and working.

Everyone loves activity streams, so to illustrate the application development process I&#8217;m going to walk through the steps needed to create an interactive LinkedIn application. StreamIn&#8217; has a profile badge for the logged in member, a stream of the status updates from members in their network, and the ability to like/unlike particular items.
  


A note on this tutorial &#8211; there is detailed documentation for the JSAPI on the [LinkedIn Developer Portal](http://developer.linkedin.com/community/jsapi) &#8211; there are links in the text appropriate, but detailed options aren&#8217;t covered here to keep the tutorial reasonably sized. It&#8217;s a lot more fun to get started in a framework if you&#8217;ve built something from start to finish, and that&#8217;s what we&#8217;ll do here.

## Getting Started

To get started on our exercise, we need a shell for the application.  Here we have a basic layout, with places for the badge and stream to be inserted.

<pre>&lt;div id="header"&gt;&lt;h1&gt;StreamIN'&lt;/h1&gt;&lt;/div&gt;
  &lt;div id="wrapper"&gt;
    &lt;div id="profile"&gt;
	    &lt;div id="badge"&gt;
	    Profile info goes here!
	    &lt;/div&gt;
    &lt;/div&gt;
    &lt;div id="stream"&gt;
        Stream stuff goes here!
    &lt;/div&gt;
    &lt;br clear="both"&gt;
    &lt;div id="footer"&gt;
    &lt;div id="nav"&gt; [ &lt;&lt; ] &lt;a href="Step1.html"&gt;[ &gt;&gt; ]&lt;/a&gt;&lt;/div&gt;
&lt;/div&gt;</pre>

We&#8217;ll start with this and build the application in stages.
  


## Step 0: Check out the Console

The Connect framework does all of the authentication work for you, and loads the things you need in order to get things working in your application.  There are various ways to present login options for the member, and you can explore them using the new [JSAPI Console](http://developer.linkedinlabs.com/jsapi-console/).  At the very least you&#8217;ll want to explore the Login options ([Login Button](http://bit.ly/g4Z8MW), [Login Button with Events](http://bit.ly/fErIx3), [Login Button Label](http://bit.ly/dKYh9i)). The console is an incredibly useful tool!  Take a few moments now to look around and see what it has to offer.  You can even edit the Code section and click &#8220;Run&#8221; to see how the Results change.

## Step 1: Get the Profile

In order to show the user&#8217;s profile, we&#8217;ll need to do a few things.

  * Import the framework
  * Add a login button
  * Add an API call to get the profile data and display it

I know, that seems like a lot of sub-steps, but it&#8217;s really very easy.

### Import the Framework

The first thing we need to do when using Connect is get the framework in our page.  In the <head> of the document, we&#8217;ll add a small script to grab the framework.  To do this you need to get a LinkedIn API key &#8211; if you don&#8217;t have one, go ahead and get one and then come back &#8211; it doesn&#8217;t take long and it&#8217;s much more fun to play along than just read about what I did.

Here&#8217;s your code. Use your own api_key. &#8220;authorize:true&#8221; tells the framework to authorize the member if they&#8217;ve visited your application before, rather than logging in each time.

<pre>&lt;script type="text/javascript" src="http://platform.linkedin.com/in.js"&gt;
   api_key: API_KEY
   authorize: true
&lt;/script&gt;</pre>

### Add a Login Button

Let&#8217;s add the button at the bottom of the page.  Here&#8217;s the code.  No really, this is all there is!  The data-onAuth variable tells the framework to fire the loadData function when the member has been authorized.

<pre>&lt;script type="IN/Login" data-onAuth="loadData"&gt;&lt;/script&gt;</pre>

### Load the User&#8217;s Profile

Here&#8217;s the meat of the step &#8211; now the framework is in place, so it&#8217;s possible to make calls on behalf of the member. When the member has been authorized the loadData() function will be called. This function calls the Profile method. We need a couple of extra fields from that call, so we use .fields to tell the call what to request.  And the .result sets a callback to perform as soon as the call returns.  You can put an anonymous function there (as I have here) or give it the name of another function to process your returned data.

The callback in this case just pulls the user&#8217;s information from the result and builds a profile badge, inserting it in the badge <div>.

<pre>function loadData() {
// we pass field selectors as a single parameter (array of strings)
IN.API.Profile("me")
   .fields(["id", "firstName", "lastName", "pictureUrl","headline"])
   .result(function(result) {
      profile = result.values[0];
      profHTML = "&lt;p&gt;&lt;a href=\"" + profile.publicProfileUrl + "\"&gt;";
      profHTML +=  "&lt;img align=\"left\" src=\"" + profile.pictureUrl + "\"&gt;&lt;/a&gt;";
      profHTML +=  "&lt;a href=\"" + profile.publicProfileUrl + "\"&gt;";
      profHTML +=  "&lt;h2&gt;" + profile.firstName + " " + profile.lastName + "&lt;/a&gt; &lt;/h2&gt;";
      profHTML += "&lt;span&gt;" + profile.headline + "&lt;/span&gt;";
$("#badge").html(profHTML);
});
}</pre>

This is how that renders &#8211; and you can look at the [code for this step](http://www.princesspolymath.com/StreamIN/Step1.html).
  


## Step 2: Add Share Stream

The member is authorized and we can see their information. The next thing the application needs to do is grab all of the status updates in their network stream and insert the information into the application.

This can be done using the [NetworkUpdates](http://developer.linkedin.com/docs/DOC-1131) function. To restrict the type of update to &#8220;STAT&#8221; (Status) updates, .params is used. For simplicity we&#8217;re using another inline function, which iterates over the updates and builds individual stream items for each one, then injects the html into the stream <div>.

There also needs to be a call to getUpdateStream() in the loadData() function so it gets called after the profile is loaded.

<pre>function getUpdateStream() {  
	IN.API.NetworkUpdates()
	.params({type:"STAT"})
	.result(function(result) {
	    var streamHTML = "";
		for (var update in result.values) {
			var thisupdate = result.values[update]
		
			// Build each individual stream update item
			person = thisupdate.updateContent.person
			var thisHTML = "&lt;div class=streamitem&gt;";
			
			// Person's picture,  linked name, and status
			thisHTML += "&lt;img align=\"left\" class=img_border height=\"50\" src=\"" + person.pictureUrl + "\"&gt;&lt;/a&gt;"; 
			thisHTML += "&lt;a href=\"" + person.publicProfileUrl + "\"&gt;";
			thisHTML += "&lt;span class=updater&gt;" + person.firstName + " " + person.lastName + "&lt;/span&gt;&lt;/a&gt;";			
			thisHTML += "&lt;p class=update&gt;" + activateLinks(person.currentStatus) + "&lt;/p&gt;"
			thisHTML += "&lt;/div&gt;";
			streamHTML += thisHTML
		}
		$("#stream").html(streamHTML);
	});
}
</pre>

And now we have this. Code is [here](http://www.princesspolymath.com/StreamIN/Step2.html).
  


### Step 3: Adding Interaction

Reading from the API is all well and good, but it&#8217;s pretty hard to make a compelling application if the member can&#8217;t do anything with it. Status updates can always be &#8220;liked&#8221;, so let&#8217;s add some like/unlike action to StreamIn&#8217;.

This part is a little more complicated. getUpdateStream() needs to be extended to add Like/Unlike buttons, and those buttons have to perform the appropriate action when pressed.

The Connect calls for these buttons are a little trickier. Since there is no Like/Unlike convenience method in Connect, we&#8217;ll pass through a raw call to the backend API. For this call, the method needs to be &#8220;PUT&#8221;, and the body is simply &#8220;true&#8221; or &#8220;false&#8221;. There&#8217;s an &#8220;alert&#8221; here to tell the user something happened, and then the stream is reloaded and redisplayed.

Here&#8217;s getUpdateStream again, with the newly added code in bold. The first section simply adds a button to the stream item &#8211; if the user has not yet liked the item, a Like button is shown. Otherwise, there&#8217;s an Unlike button.
  
The other two functions are event handlers for clicks on these buttons.

<pre>function getUpdateStream() {  
	IN.API.NetworkUpdates()
	.params({type:"SHAR"})
	.result(function(result) {
	    var streamHTML = "";
		for (var update in result.values) {
			var thisupdate = result.values[update]
		
			// Build each individual stream update item
			person = thisupdate.updateContent.person
			var thisHTML = "&lt;div class=streamitem&gt;";
			
			// Person's picture,  linked name, and status
			thisHTML += "&lt;div class=updateperson&gt;" ;
			thisHTML += "&lt;img class=img_border align=\"left\" height=\"50\" src=\"" + person.pictureUrl + "\"&gt;&lt;/a&gt;"; 
			thisHTML += "&lt;a href=\"" + person.publicProfileUrl + "\"&gt;";
			thisHTML += "&lt;span class=updater&gt;" + person.firstName + " " + person.lastName + "&lt;/a&gt;&lt;/span&gt;";	
			thisHTML += "&lt;p class=update&gt;" + activateLinks(person.currentShare.comment) + "&lt;/p&gt;&lt;/div&gt;";
			<b>			
			// Present a like button
			if (! thisupdate.isLiked) {
				thisHTML += "&lt;div id=button&gt;&lt;button class=\"likebutton ui-corner-all\" id=\"" + 
                                thisupdate.updateKey + "\"&gt;&lt;img src=\"Thumbs_up.png\"&gt; Like&lt;/button&gt;&lt;/div&gt;"
			} else {
				thisHTML += "&lt;div id=button&gt;&lt;button class=\"unlikebutton ui-corner-all\" id=\"" +
                                thisupdate.updateKey + "\"&gt;&lt;img src=\"Thumbs_down.png\"&gt; Unlike&lt;/button&gt;&lt;/div&gt;"
			}	</b>
			thisHTML += "&lt;/div&gt;";
			
			// Slap this onto the HTML we're building
			streamHTML += thisHTML;
		}
		$("#stream").html(streamHTML);
	});
	<b>
	$( ".likebutton" ).live("click", function() {
		   likeURL = "/people/~/network/updates/key=" + $(this).attr("id") + "/is-liked"
		   IN.API.Raw(likeURL)
			.method("PUT")
			.body("true")
			.result(function(result) {
				alert ("Liked");
				getUpdateStream();
			})
	});	
	
	$( ".unlikebutton" ).live("click", function() {
		   likeURL = "/people/~/network/updates/key=" + $(this).attr("id") + "/is-liked"
		   IN.API.Raw(likeURL)
			.method("PUT")
			.body("false")
			.result(function(result) {
				alert ("Unliked");
				getUpdateStream();
			})
	});	</b>
}
</pre>

So that&#8217;s it. The code for Streamin&#8217; code is [here](http://www.princesspolymath.com/StreamIN/Step3.html). Now that you&#8217;ve gotten an app up and running, check out the docs and see what you can build!