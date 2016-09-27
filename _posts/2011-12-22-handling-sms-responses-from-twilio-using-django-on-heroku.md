---
id: 531
title: Handling SMS Responses from Twilio using Django on Heroku
date: 2011-12-22T17:16:19+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=531
permalink: /handling-sms-responses-from-twilio-using-django-on-heroku.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877197327
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - LinkedIn
  - Web APIs
tags:
  - django
  - heroku
  - linkedin
  - python
  - twilio
---
The final piece in the application I&#8217;m working on requires that I process SMS replies from Twilio.  To do this, I need a public-facing server that can handle a POST request from another server so it can do the right thing on my end.  This tutorial will walk through how to do that with a Django server on Heroku.  You can grab the twilio_sms application from within my [The final piece in the application I&#8217;m working on requires that I process SMS replies from Twilio.  To do this, I need a public-facing server that can handle a POST request from another server so it can do the right thing on my end.  This tutorial will walk through how to do that with a Django server on Heroku.  You can grab the twilio_sms application from within my](https://github.com/synedra/django-linkedin-simple) for this application, or you can build it based on the walkthrough here.

## URL Setup

Add a mapping for /reply/ to the urls.py in your top level Django project.

#### urls.py

<pre>url(r'^reply', 'twilio_sms.views.sms_reply'),</pre>

You&#8217;ll need to tell Twilio where to send SMS replies on the [dashboard](https://www.twilio.com/user/account).  For instance, my Heroku instance runs at http://falling-summer-4605.herokuapp.com so my SMS Response URL is set to http://falling-summer-4605.herokuapp.com/reply.

## Creating twilio_sms

In order for that URL mapping to do the right thing it needs to point to the right application.  If you aren&#8217;t using the code samples from GitHub, you can create a new application with:

<pre>django-admin.py startapp twilio_sms</pre>

Now we need to build the views.py file to handle the responses.

The setup is similar to the linkedin application we made previously.

<pre># Python
import oauth2 as oauth
import simplejson as json
import re
from xml.dom.minidom import getDOMImplementation,parse,parseString

# Django
from django.http import HttpResponse
from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User

# Project
from linkedin.models import UserProfile,SentArticle

# from settings.py
consumer = oauth.Consumer(settings.LINKEDIN_TOKEN, settings.LINKEDIN_SECRET)
client = oauth.Client(consumer)</pre>

We&#8217;ll create a convenience method to build SMS responses in the format expected by the Twilio server (so that the user gets a reasonable SMS response)

<pre>def createSmsResponse(responsestring):
	impl = getDOMImplementation()
	responsedoc = impl.createDocument(None,"Response",None)
	top_element = responsedoc.documentElement
	sms_element = responsedoc.createElement("Sms")
	top_element.appendChild(sms_element)
	text_node = responsedoc.createTextNode(responsestring)
	sms_element.appendChild(text_node)
	html = responsedoc.toxml(encoding="utf-8")
	return html</pre>

Because the POST will be coming from an external server without a session cookie, we need to use the @csrf_exempt decorator to tell Django to allow these POSTs without authentication.  For security, you might check the incoming IP to make sure it&#8217;s coming from Twilio, or make sure that the other information matches what you expect.  For this demo, we&#8217;ll allow it to proceed assuming it&#8217;s the right thing.

Grab the parameters, get the user&#8217;s phone number, and determine which of our users matches that phone number, then grab their credentials and create the LinkedIn client to make requests.

<pre>@csrf_exempt
def sms_reply(request):
    if request.method == 'POST':
        params = request.POST
        phone = re.sub('\+1','',params['From'])
        smsuser = User.objects.get(userprofile__phone_number=phone)
        responsetext = "This is my reply text"
        token = oauth.Token(smsuser.get_profile().oauth_token, smsuser.get_profile().oauth_secret)
        client = oauth.Client(consumer,token)</pre>

Figure out what the user wants us to do (save, search, cancel, help, level)

<pre>commandmatch = re.compile(r'(\w+)\b',re.I)
        matches = commandmatch.match(params['Body'])
        command = matches.group(0).lower()</pre>

&#8220;Cancel&#8221; tells the system the user doesn&#8217;t want notifications anymore.  For now, we&#8217;re going to keep their user and profile around, so that we don&#8217;t send them all the same articles again in the future. But sendArticles.py won&#8217;t send them anything if the level is set to zero.

<pre># Cancel notifications by setting score to zero
        # Command is 'cancel'
        if command == 'cancel':
        	profile = smsuser.get_profile()
        	profile.min_score = 0
        	profile.save()
        	return HttpResponse(createSmsResponse("Today SMS Service Cancelled"))</pre>

&#8220;Level <number>&#8221; tells the system the user wants to change their notification level.  Higher means fewer messages, as this is used as the &#8220;score&#8221; check against articles based on relevance.  See the [previous post on Twilio notifications](http://www.princesspolymath.com/princess_polymath/?p=521) to see how this is implemented.  Notice that in this and the following methods we&#8217;re doing generic error catching &#8211; there&#8217;s a few reasons why it might fail, but the important thing is to tell the user their action didn&#8217;t succeed and give them a hint as to why that might be.

<pre># Change level for notifications by setting score to requested level
        # Command is 'level \d'
        if command == 'level':
        	levelmatch = re.compile(r'level (\d)(.*)',re.I)
        	matches = levelmatch.search(params['Body'])

        	try:
	        	level = int(matches.group(1))
	        except:
	        	e = sys.exc_info()[1]
	        	print "ERROR: %s" % (str(e))
	        	return HttpResponse(createSmsResponse("Please use a valid level (1-9)."))

        	profile = smsuser.get_profile()
        	profile.min_score = level
        	profile.save()
        	return HttpResponse(createSmsResponse("Today SMS minimum score changed to %d" % int(level)))</pre>

&#8220;Save <article number>&#8221; saves an article to the user&#8217;s LinkedIn saved articles.  Remember that in the setup we grabbed the credentials for the user who sent the SMS based on their phone number, so this (and share) are done against the LinkedIn API on their behalf.  In this new (preview only) API JSON doesn&#8217;t seem to be working well, so I&#8217;m building and using XML.

<pre># Save an article
        # Command is 'save &lt;articlenum&gt;'
        if command == 'save':
        	savematch = re.compile(r'save (\d+)(.*)',re.I)
        	matches = savematch.search(params['Body'])
        	try:
	        	article = matches.group(1)
        		sentarticle = SentArticle.objects.get(user=smsuser, id=article)
	        except:
	        	e = sys.exc_info()[1]
	        	print "ERROR: %s" % (str(e))
	        	return HttpResponse(createSmsResponse("Please use a valid article number with save."))

        	responsetext = "Saved article: %s" % (sentarticle.article_title)
        	saveurl = "http://api.linkedin.com/v1/people/~/articles"

        	# Oddly JSON doesn't seem to work with the article save API
        	# Using XML instead
        	impl = getDOMImplementation()
        	xmlsavedoc = impl.createDocument(None,"article",None)
        	top_element = xmlsavedoc.documentElement
        	article_content_element = xmlsavedoc.createElement("article-content")
        	top_element.appendChild(article_content_element)
        	id_element = xmlsavedoc.createElement("id")
        	article_content_element.appendChild(id_element)
        	text_node = xmlsavedoc.createTextNode(sentarticle.article_number)
        	id_element.appendChild(text_node)
        	body = xmlsavedoc.toxml(encoding="utf-8")

        	resp, content = client.request(saveurl, "POST",body=body,headers={"Content-Type":"text/xml"})
        	if (resp.status == 200):
        		return HttpResponse(createSmsResponse(responsetext))
        	else:
        		return HttpResponse(createSmsResponse("Unable to save post: %s" % content))</pre>

&#8220;Share <article number> <comment>&#8221; shares an article to the user&#8217;s network with a comment.  The comment shouldn&#8217;t really be optional, but typing on T-9 keyboards is a pain, so I wanted to give a default share message.  I&#8217;m not sure I love it as an answer though&#8230;

<pre># Share an article
        # Command is 'share &lt;articlenum&gt; &lt;comment&gt;'
        # If no comment is included, a generic one is sent
        if command == 'share':
        	sharematch = re.compile(r'Share (\d+) (.*)')
        	matches = sharematch.search(params['Body'])
        	try:
        		article = matches.group(1)
	        	sentarticle = SentArticle.objects.get(user=smsuser, id=article)
        		comment = matches.group(2)
	        except:
	        	if sentarticle and not comment:
	        		comment = "Sharing an article from the LinkedIn SMS System"
	        	else:
	        		e = sys.exc_info()[1]
	        		print "ERROR: %s" % (str(e))
	        		return HttpResponse(createSmsResponse("Please use a valid article number with share and include a comment."))

        	responsetext = "Shared article: %s" % (sentarticle.article_title)
        	shareurl = "http://api.linkedin.com/v1/people/~/shares"
        	body = {"comment":comment,
        		"content":{
        			"article-id":sentarticle.article_number
       	 		},
        	"visibility":{"code":"anyone"}
        	}

        	resp, content = client.request(shareurl, "POST",body=json.dumps(body),headers={"Content-Type":"application/json"})
        	if (resp.status == 201):
        		return HttpResponse(createSmsResponse(responsetext))
        	else:
        		return HttpResponse(createSmsResponse("Unable to share post: %s" % content))</pre>

If we&#8217;ve fallen through to here, the user may have asked for &#8216;help&#8217; &#8211; but whatever they did we didn&#8217;t understand it so we should give them the help text in any case.

<pre># If command is help, or anything we didn't recognize, send help back
        helpstring = "Commands: 'cancel' to cancel Today SMS; 'level #number#' to change minimum score;"
        helpstring += "'save #article#' to save; 'share #article# #comment#' to share"
        return HttpResponse(createSmsResponse(help string))</pre>

&#8230; and, if the request wasn&#8217;t a POST, send a 405 response back to the system (it won&#8217;t be Twilio, it might have been someone else).  This URL is only for processing these SMS messages.

<pre># If it's not a post, return an error
    return HttpResponseNotAllowed('POST')</pre>