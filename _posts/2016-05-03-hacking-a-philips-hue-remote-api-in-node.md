---
id: 845
title: Hacking a Philips Hue Remote API in Node
date: 2016-05-03T13:07:28+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=845
permalink: /hacking-a-philips-hue-remote-api-in-node.html
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"847";s:11:"_thumb_type";s:5:"thumb";}'
post_slider_check_key:
  - 0
dsq_thread_id:
  - 4797540560
categories:
  - API Codex
  - Geek Stuff
  - Irresistible APIs
  - Web APIs
---
I&#8217;m giving one of my favorite talks at [Stir Trek](http://stirtrek.com) this year &#8211; [Quantifying your Fitness](https://skillsmatter.com/skillscasts/6767-wrangling-the-internet-of-things-using-node-js).  Unfortunately, the IFTTT->Philips Hue connector has ceased to work and neither IFTTT nor Philips Hue has deigned to answer my plea for help.  So, while Quantifying your Fitness used to use Twitter as glue, I needed to create a remote API client that would run on [Modulus](http://modulus.io) in Node.js.

There are lots of people who have created clients in various languages, including Paul Shi, who wrote a [fabulous blog post](http://blog.paulshi.me/technical/2013/11/27/Philips-Hue-Remote-API-Explained.html), but I wanted to do this directly in Node, so that other people looking for guidance would understand exactly what they needed to create and send.

So here&#8217;s the tutorial for what I did:

### Get a Token

In order to interact with the unsupported/hidden remote API, you have to pretend to be a known partner.  I chose to masquerade as an iPhone for this particular exercise.

  1. Login to [meethue.com](http://meethue.com)
  2. Send a request to  <https://www.meethue.com/api/nupnp>. (or in [My bridge](https://www.meethue.com/en-US/user/preferencessmartbridge) page on the meethue website and by clicking on “Show me more”)
  3. Get your access token by sending a request in your browser to 


     ```
     http://www.meethue.com/en-US/api/gettoken?devicename=iPhone+5&appid=hueapp&deviceid=**BRIDGEID**
     ```

     and then right click on "Back to the app" to find the token inside of the response (phhueapp://sdk/login/**ACCESSTOKEN**)

  4. I promise this is the grossest part of the process, but you do need to do this manually to get the API to respond correctly.

From here, you can do a tl;dr if you want and just checkout my [code on github](https://github.com/synedra/fitfood-demo-pluralsight).  Otherwise, let&#8217;s sally forth.

### Make a Call

  1. Now we have an access token and a bridge ID, so we can make a very easy call.  I&#8217;m using [httpie](http://httpie.org) for examples here, I strongly recommend it for any interaction with a REST API on the command line.
  2. First, let's get the status for the bridge.  Make the following call:

     ``` 
     http --form POST https://www.meethue.com/api/getbridge token==\*\*ACCESSTOKEN\*\*
     ``` 

 3. If all has gone well, you will get information about your lights and the system.

### Make a Harder Call

  1. Now let&#8217;s turn all the lights off.
  2. The format for this call is pretty convoluted, but you can figure out what the actions/state items are by reading the [Philips Hue local API documentation](http://www.developers.meethue.com/philips-hue-api).
  3. Here&#8217;s a sample.  Copy it very carefully
 
     ```
     http --form POST https://www.meethue.com/api/sendmessage token==**ACCESSTOKEN** 
     clipmessage='{"bridgeId":**BRIDGEID*, "clipCommand": 
     { "url": "/api/0/groups/0/action", "method": "PUT" , "body": {"on":false} }}'
     ```

  4. From here, you should be able to make calls against the API.  Again, the code on github is in node, and it&#8217;s part of my Quantified Fitness talk, but the juicy bits are all there for you to peruse and copy at will.

## Local API Usage

Along with making calls remotely from the internet, you can also (more easily) control your Philips Hue device using the local network, if you want to set up a server to work with the bulbs.  Here are some pointers to getting started:

  1. First, you'll want to find the IP address for your bridge.  It's a little unintuitive, but you can get this from the website.  Click "My Hue" on the meethue.com website, then "Settings."  Choose "My bridge" from the links at the top, then "More bridge details" in the middle of the page.  This misses the goal of making it easy to find information, but now you should have your IP address.  Hurray!

  2. Now, you have a couple of choices.  The first option is to use the web server on the bridge (it's more than just a bridge!)  Browse to:


     ```
     http://{IP_ADDRESS_FROM_MEETHUE}/debug/clip.html
     ```

     From here you can start making API calls.  In order to get started, you'll need to get the anonymous user identifier so you can use it in your calls.  Put `/api` in the field and the following text in the body box:


     ```
     {"devicetype":"my_hue_app#iphone philips"}
     ```

     Then click `POST`.  

     Hmm, "Link button not pressed."  So press the link button and try again and you'll end up with that username.  I'll put a sample username here for subsequent calls.  Your response will look something like this:


     ```
     [
	{
		"success": {
			"username": "0000000000000000000000000000000"
		}
	}
     ]  
     ```

      Now you've got a username, which is needed for your local API calls.  When using the remote API, the first zero in the path indicates that it's the current user, but for the local API you need to express it explicitly.

  3. Next up, a simple command using the API Debug Tool.  You can access specific lights with `/api/{username}/lights/{lightnumber}` or you can group your lights.  By default, there's a group 0 which includes all of your lights, so you can do whatever you like all at the same time.  Note that if you are changing the state of a single light the endpoint is 

     ```
     /api/{username}/lights/{lightnumber}/state
     ```

     Where the method to change a group of lights is as follows:

     ```
     /api/{username}/groups/{groupnumber}/action
     ```

     So let's change the status of all lights to off (or on, if you prefer).  To do that, put the following in the URL field:

     ```
     /api/{username}/groups/0/action
     ```

     Use the following for the body:

     ```
       {"on":false}
     ```

     Then push "PUT" and see what happens.  

     Now you've got the API Debugger working, and you can see all the magic you can create in the [API Documentation](http://www.developers.meethue.com/philips-hue-api)

  4. This tutorial wouldn't be complete if I didn't give an example of making a call directly on the local network.  In order to do the same command in httpie, using the local network, give the following command:


     ```
     http PUT http://{ip_from_meethue}/api/{username}/groups/0/action on=false
     ```

     This command does precisely what the remote call did above.  The difference is that the system making this call *must* be on the same local network as the bridge, so it can't work from a cloud provider or a hosted system.  For some people this is a fine setup, but for me I always want to make sure that things work no matter what my local computer is doing.

     I hope this tour has been helpful in learning how to work with the philips hue lights.  It's really quite fun, and you can do many more complex actions, setting specific colors, blinking, rotating through colors.  These commands work with the lamp bulbs as well as the "Go" bulbs and the lightstrips (which are quite excellent).
