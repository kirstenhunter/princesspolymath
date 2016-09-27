---
id: 791
title: Promises, promises
date: 2015-05-26T14:27:54+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=791
permalink: /promises-promises.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3796000771
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";i:793;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Web APIs
---
This has got to be the fifty-bazillionth post about javascript promises with the same title out there, but I had a very particular problem I was trying to solve and had trouble finding the answer so once I got it working I wanted to share it with you.

The challenge came about because I was somewhat embarrassed by the implementation I had for my [fitbit-twilio-twitter-ifttt-phillipshue mashup](http://www.princesspolymath.com/princess_polymath/?p=787) &#8211; it had race conditions pretty frequently because of the asynchronous nature of the API calls, and I didn&#8217;t really want to chain everything together.  So it turned out that what I wanted was to use Promise.all() to tell the script to wait until both of the calls finished before pestering me to tell me to eat or exercise.  I hunted around, asked on [StackOverflow](http://stackoverflow.com/questions/30428045/using-promise-all-for-multiple-http-oauth-queries), and got pointed in the right direction, and it turns out that the actual answer was much more elegant than the original code for a single API call.

These calls aren&#8217;t promises by default, so you have to promisify them in order to get them to work, but the process is pretty easy.  Here, for your copying and pasting pleasure, is the code I ended up with.  It&#8217;s not embarrassing at all!

<pre>function fitbit_oauth_getP(path, accessToken, accessSecret) {
     return new Promise (function(resolve, reject) {
         fitbit_oauth.get(path, accessToken, accessSecret, function(err, data, res) {
             if (err) {
                reject(err);
             } else {
                resolve(data);
             }
          })
     })
  };

 Promise.all([fitbit_oauth_getP(foodpath, user.accessToken, user.accessSecret), 
 fitbit_oauth_getP(activitypath, user.accessToken, user.accessSecret)])
      .then(function(arrayOfResults) {
          console.log(arrayOfResults);
          // do more stuff
      })
 The whole code lives on <a href="https://github.com/synedra/fitfood">github</a>, as it should.  I'll add more functionality later, but for now, this should help you get started if you're trying to make a couple of web calls to APIs and process the results in one big clump at the end.</pre>