---
id: 396
title: Adding HTML5 Local Storage to Your Web App
date: 2011-02-25T11:59:48+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=396
permalink: /adding-html5-local-storage-to-your-web-app.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877196562
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - browser storage
  - html5
---
One of the things we&#8217;re working on in the Developer Relations group at LinkedIn is creating tools to help our developers work through issues and questions quickly and easily. The OAuth authentication piece is frequently tricky, so we put together an [OAuth Test Console](http://developer.linkedinlabs.com/oauth-test/), based on a similar tool from [JR Conlin](http://www.jrconlin.com/).

It&#8217;s a handy tool, and certainly makes OAuth debugging much easier, but as a frequent user of the console myself, I found myself quickly getting tired of copying and pasting my consumer key, secret, oauth token, token secret into the fields every time I wanted to use the console. As a developer/user of the console, though, I certainly didn&#8217;t want to have that informations saved in a cookie which would go across the wire every time I used the tool, sharing my secret unencrypted keys.

HTML5 local storage to the rescue!  This, my friends, is just the kind of thing you can do with the new HTML5 local (browser) storage functionality.  Store the information in the user&#8217;s browser, and check for/use it when you find it there.  The functions are easy to use and implement, so I&#8217;ll go over the pieces I used to add this to our console.

### Step 1: Don&#8217;t tease the IE6 users

All of the major browsers support this functionality in their newest release.  However, not everyone has a fancy, shiny new browser to work with, and telling them you have functionality they can&#8217;t have is just mean.  The first thing you should do is make sure that the buttons only show up if they&#8217;re going to actually do something.

So, I added a <div> with the store/clear buttons, but set the display to none by default:

<pre>&lt;style&gt;
   #storetokens { display: none; }
&lt;/style&gt;</pre>

<pre>&lt;div id="storetokens"&gt;
    &lt;button id="store" onclick="storeTokens(); return false;"&gt;Store Token Info&lt;/button&gt;
    &lt;button id="store" onclick="clearTokens(); return false;"&gt;Clear Token Info&lt;/button&gt;
&lt;/div&gt;</pre>

Now that we&#8217;ve got that in place, let&#8217;s check to see if the browser knows how to store things:

<pre>&lt;script&gt;
   if (supportsHTML5Storage()) {$("#storetokens").show();}
&lt;/script&gt;</pre>

Now we have buttons for storing and clearing the tokens from the browser storage, but only users who can use it will see it.

### Step 2:  Store the Tokens

We&#8217;re calling a storeTokens() function when the button is clicked &#8211; let&#8217;s see what that should look like.

Once we ask the user to confirm the action, we just set the values in localStorage based on the values of the fields in the form.  Note that I&#8217;m using JQuery here to make it easier to grab the selectors, but this works just as well with raw Javascript.

<pre>function storeTokens() {
    var storeConfirm = confirm("Do you want to store your tokens and secrets in your browser's local storage?")
    if (!storeConfirm) { return; }

    localStorage["apiKey"] = $("#apiKey").val();
    localStorage["apiSecret"] = $("#apiSecret").val();
    localStorage["memberToken"] = $("#memberToken").val();
    localStorage["memberSecret"] = $("#memberSecret").val();
}</pre>

### Step 3:  Clear the Tokens

Anytime you give the user the chance to store some sensitive information, you want to give them the ability to get it back out.  There are various reasons for this, but just trust me &#8211; it&#8217;s only polite.

So we have a clearTokens() function which is very similar to the storeTokens() function

<pre>function clearTokens() {
    var clearConfirm = confirm("Do you want to clear your tokens and secrets from your browser's local storage?")
    if (!clearConfirm) { return; }

   localStorage.removeItem("apiKey")
   localStorage.removeItem("apiSecret")
   localStorage.removeItem("memberToken")
   localStorage.removeItem("memberSecret")
}</pre>

### Step 4: Retrieve the Stored Data

Great.  Now the user can store and clear the token information.  There&#8217;s something missing, though.  Until the form actually takes advantage of the stored data, we&#8217;re engaging in a purely academic exercise.  So, when the browser loads, we should populate the fields.

<pre>function populateFields() {
    if (localStorage.getItem("apiKey")) {
        $("#apiKey").val(localStorage.getItem("apiKey"))
  	$("#apiSecret").val(localStorage.getItem("apiSecret"));
	$("#memberToken").val(localStorage.getItem("memberToken"));
        $("#memberSecret").val(localStorage.getItem("memberSecret"));
    }
}</pre>

### That&#8217;s It

That&#8217;s pretty much all there is to getting HTML5 storage working in modern browsers.  Storing secret information that a user never needs to send across the wire is a great reason to use this functionality.  For users who can use it, we&#8217;ve given them a way to save themselves some extra work when they want to use the tool. As you can see, the functionality is really quite easy to implement.  You can see the code in action (and take it to use for your own) &#8211; [OAuth Test Console](http://developer.linkedinlabs.com/oauth-test/).