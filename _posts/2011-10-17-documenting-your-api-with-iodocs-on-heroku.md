---
id: 489
title: Documenting your API with IODocs on Heroku
date: 2011-10-17T17:20:21+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=489
permalink: /documenting-your-api-with-iodocs-on-heroku.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877197573
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";i:500;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - LinkedIn
  - Web APIs
tags:
  - heroku
  - iodocs
  - linkedin
  - node.js
  - oauth
---
Neil Mansilla over at [Mashery](http://www.mashery.com) has created an awesome new system called [IODocs](https://github.com/mashery/iodocs), which can be used to create a system for browsing through OAuth-secured APIs. Being a Developer Advocate at LinkedIn, I decided to try and get this up and running with LinkedIn&#8217;s API.  Since it was LinkedIn&#8217;s internal hackday on Friday, I decided to go the extra mile and try to build the configuration dynamically from our nascent discovery API system, and run it on one of Heroku&#8217;s node.js hosted systems.

Thanks in part to a heavy piece of furniture (which fell on me on Friday, relegating me to bed rest for the weekend) I got it working. You can visit the [LinkedIn API Documentation](http://electric-meadow-1119.herokuapp.com/linkedin) site and use your [LinkedIn API key and secret](https://www.linkedin.com/secure/developer) to browse through the many API resources LinkedIn has to offer.

<a href="/assets/img/2011/10/companies.png" class="grouped_elements" rel="tc-fancybox-group489"><img alt="This is a picture" class="alignnone size-medium wp-image-500" title="companies" src="/assets/img/2011/10/companies-300x176.png" alt="This is a picture" width="300" height="176" srcset="/assets/img/2011/10/companies-300x176.png 300w, /assets/img/2011/10/companies.png 1008w" sizes="(max-width: 300px) 100vw, 300px" /></a>

Getting the IODocs system running on Heroku required several steps, but once you have them it&#8217;s pretty straightforward. So I share them with you here so you can get IODocs running on your own Heroku instance, in the hopes that all of the OAuth APIs out there can leverage this functionality and improve developers&#8217; lives.

Consider this an inclusive set of instructions to the ones they have on the site.

  1. Get &#8220;Local Workstation Setup&#8221; done from <http://devcenter.heroku.com/articles/node-js>
  2. Do the initial IODocs setup 
    <pre>% git clone http://github.com/mashery/iodocs.git
% cd iodocs/
% npm install
% echo "web: node app.js" &gt; Procfile
% cp config.json.sample config.json
% vi config.json (remove address line)</pre>

  3. Add the following block under &#8220;var db;&#8221; to app.js: 
    <pre>if (process.env.REDISTOGO_URL) {
   var rtg   = require("url").parse(process.env.REDISTOGO_URL);
   db = require("redis").createClient(rtg.port, rtg.hostname);
   db.auth(rtg.auth.split(":")[1]);
} else {
   db = redis.createClient(config.redis.port, config.redis.host);
   db.auth(config.redis.password);
}

And then this in the Load API Configs section, after reading the config file:

var app = module.exports = express.createServer();

var hostname, port, password

if (process.env.REDISTOGO_URL) {
    var rtg   = require("url").parse(process.env.REDISTOGO_URL);
    hostname = rtg.hostname;
    port = rtg.port;
    password = rtg.auth.split(":")[1];
} else {
    hostname = config.redis.host;
    port = config.redis.port;
    password = config.redis.password;
}


</pre>

  4. Add a LinkedIn block to public/data/apiconfig.json: 
    <pre>"linkedin": {
   "name": "LinkedIn",
   "protocol": "http",
   "baseURL": "api.linkedin.com",
   "publicPath": "",
   "privatePath": "/v1",
   "auth": "oauth",
   "oauth": {
      "type": "three-legged",
      "requestURL": "https://api.linkedin.com/uas/oauth/requestToken",
      "signinURL": "https://api.linkedin.com/uas/oauth/authorize?oauth_token=",
      "accessURL": "https://api.linkedin.com/uas/oauth/accessToken",
      "version": "1.0",
      "crypt": "HMAC-SHA1"
   },
   "keyParam":""
 },</pre>

  5. Copy [linkedin.json](http://www.princesspolymath.com/linkedin.json) into your public/data folder
  6. Set up your git repository for heroku 
    <pre>% git init
% git add .
% git add -f config.json Procfile public/data/*
% git commit -m "init"</pre>

  7. Set up heroku 
    <pre>% heroku create --stack cedar;
% heroku addons:add redistogo [note: this may require that you add a credit card to your heroku account.  there is no charge, though]
% heroku addons:add logging 
% git push heroku master
% heroku ps:scale web=1</pre>
    
    <pre></pre>

Once you&#8217;ve gotten all this set up, you&#8217;re ready to rock.  Heroku will give you the right system name and port, and you can use &#8216;heroku logs&#8217; to check the logs for the node.js server.

You can set up your own APIs using the config file &#8211; the IODocs documentation is fantastic, with OCD-level detail on how to set up configurations for new APIs, and I&#8217;m certain you can make it work with whatever you&#8217;re trying to use.

&nbsp;