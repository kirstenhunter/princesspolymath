---
id: 521
title: Sending SMS Notifications using Twilio, Django and the Heroku Scheduler
date: 2011-12-21T13:07:28+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=521
permalink: /sending-sms-notifications-using-twilio-django-and-the-heroku-scheduler.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1876772935
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
  - Heroku
  - LinkedIn
  - Python
  - Web APIs
tags:
  - django
  - heroku
  - linkedin
  - python
  - twilio
---
For my [Twilio SMS Demo App](http://www.princesspolymath.com/princess_polymath/?p=509) this month, I wanted to send notifications to LinkedIn members based on hot items for them in LinkedIn Today.  This is a tutorial on creating a python script to access user information in the Django database, pull information from a Web Service (in this case the LinkedIn Today API) and send an SMS to the user.  A couple of caveats are in order here to make sure that people don&#8217;t accidentally run afoul of the [LinkedIn API Terms of Use](https://developer.linkedin.com/documents/linkedin-apis-terms-use) when implementing something of this sort.

  * The LinkedIn Today API is only available internally at this point, and should only be used as an example of what&#8217;s possible
  * I have stored the user&#8217;s phone number in the database &#8211; when storing LinkedIn information you always need to notify the user that you&#8217;re doing that, explicitly.

<div>
  All that having been said, you need the following to get this working:
</div>

<div>
  <ul>
    <li>
      A working Django system on Heroku.  If you set up my example LinkedIn Django application from <a href="http://www.princesspolymath.com/princess_polymath/?p=511">this post</a>, you&#8217;ll be able to extend that here.
    </li>
    <li>
      A<a href="http://www.twilio.com/"> Twilio account</a> &#8211; ideally with a purchased number, but you could get this system to work with the sandbox system.  You get $30 in Twilio credit to start out with, which is plenty to set up a demo of this sort.
    </li>
    <li>
      A Google API key (this is optional, but it&#8217;ll get you more shortened links)
    </li>
  </ul>
</div>

## Install the Twilio Library

<div>
  Assuming that you&#8217;re using the LinkedIn Django application from <a href="http://www.princesspolymath.com/princess_polymath/?p=511">my previous post</a> and are in the root level of that structure, you need to add the Twilio library to your installation:
</div>

<pre>% pip install twilio
% pip freeze &gt; requirements.txt</pre>

## Adding the Phone Number

Remember, if you&#8217;re going to store any information at all about a LinkedIn member, you need to explicitly tell them so.  That having been said, you can add the following to your LinkedIn application to get the phone number and store it.  I&#8217;m not going to provide the completed code to do this since you need to implement some user notification if you&#8217;re using this in a production system.

### linkedin/models.py

<pre>class UserProfile(models.Model):
    user = models.ForeignKey(User)
    oauth_token = models.CharField(max_length=200)
    oauth_secret = models.CharField(max_length=200)
    phone_number = models.CharField(max_length=10)</pre>

### linkedin/views.py

Modify the LinkedIn profile URL:

<pre>url = "http://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,phone-numbers)"</pre>

Add this logic before saving the user profile:

<pre>if "phoneNumbers" in profile:
        	for phone_number in profile['phoneNumbers']['values']:
        		userprofile.phone_number = re.sub(r"\D","",phone_number['phoneNumber'])
        		if phone_number['phoneType'] == 'mobile':
        			continue</pre>

If you&#8217;ve already created your DB you&#8217;ll need to wipe it out and recreate it with these new models in order for this to work.  You can most easily do this by just starting a new project for this version &#8211; while you can drop the database locally and recreate it with syncdb, for heroku you&#8217;ll need to create a new cedar project so a new database will be created.

## Creating the Job

Now we&#8217;ll walk through the code.  This file wants to live at your LinkedIn project level (so in the example, in the hellodjango directory).  It&#8217;s also available in the GitHub repository for [django-linkedin-simple](https://github.com/synedra/django-linkedin-simple).

First, do some basic setup:

<pre>from django.core.management import setup_environ
import settings
setup_environ(settings)</pre>

<pre>from twilio.rest import TwilioRestClient
import oauth2 as oauth
import time
import simplejson
import datetime
import httplib2
import psycopg2

account = "TWILIO_ACCT_NUMBER"
token = "TWILIO_TOKEN"
twilioclient = TwilioRestClient(account, token)

consumer = oauth.Consumer(
        key="LINKEDIN_CONSUMER_KEY",
        secret="LINKEDIN_CONSUMER_SECRET")
url = "http://api.linkedin.com/v1/people/~/topics:(description,id,topic-stories:(topic-articles:(relevance-data,article-content:(id,title,resolved-url))))"</pre>

<pre><span class="Apple-style-span" style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 13px; line-height: 19px; white-space: normal;">Grab the user profiles (this includes the user tokens and secrets)</span></pre>

<pre>users = User.objects.all()</pre>

Iterate over the users, grabbing their token, secret, django userid and phone number, then grab the LinkedIn Today feed for that user.

<pre>for djangouser in users:
	if djangouser.username == "admin":
		continue
	profile = UserProfile.objects.get(user=djangouser)
	token = oauth.Token(
        	key=profile.oauth_token,
        	secret=profile.oauth_secret)
	phone = profile.phone_number
	userid = profile.user_id
	user_articles = SentArticle.objects.filter(user=djangouser)

	# Now make the LinkedIn today call and get the articles in question
	client = oauth.Client(consumer, token)

	resp, content = client.request(url, headers={"x-li-format":'json'})
	results = simplejson.loads(content)</pre>

We only want to send alerts for articles which have a high &#8220;score&#8221;, indicating that they are currently hot topics for this user.  Look through the articles to find those &#8220;hot topics&#8221;:

<pre>for topic in results['values']:
           for story in topic['topicStories']['values']:
                for article in story['topicArticles']['values']:
                        score = article['relevanceData']['score']
                        if score &gt; 6:</pre>

Now, SMS messages are expensive for us (the application owner) and potentially for the user, so we only want to tell the user if they haven&#8217;t already heard about this article.

<pre>checkarticle = user_articles.filter(article_number__exact=article['articleContent']['id'])</pre>

If there aren&#8217;t any matching articles for this user, go ahead and send them a message, then log it in the database so we don&#8217;t tell them again later:

<pre>if len(checkarticle) == 0:
    # This is where we get the shortened URL from google because LinkedIn doesn't provide one
    http = httplib2.Http()
    body = {"longUrl": article['articleContent']['resolvedUrl']}
    resp,content = http.request("https://www.googleapis.com/urlshortener/v1/url?key=YOUR_GOOGLE_API_KEY","POST",body=simplejson.dumps(body),headers={"Content-Type":"application/json"})
    googleresponse = simplejson.loads(content)
    sentarticle = SentArticle(article_number=article['articleContent']['id'],user=djangouser,timestamp=datetime.datetime.today())
    sentarticle.save()
    bodytext = article['articleContent']['title'] + " " + googleresponse['id']
    bodytext += " ('save %s')" % sentarticle.id
    message = twilioclient.sms.messages.create(to="+1" + phone, from_="+YOUR_TWILIO_NUMBER", body=bodytext)</pre>

Great, we&#8217;ve got an application that&#8217;ll send messages for the users in the Django system when something hot is there to talk about.

## Pushing to Heroku

Now we need the job to work on Heroku, and get scheduled.  If you went through my previous post using the existing [GitHub example](https://github.com/synedra/django-linkedin-simple), the file is already up at Heroku, otherwise you&#8217;ll need to push the file to your Heroku instance:

<pre>% git add hellodjango/sendArticles.py
% git push heroku master</pre>

Whether it was already there or you just put it there, you should check to make sure that it runs correctly.  Make sure you&#8217;ve logged into the system using your LinkedIn ID and stored your phone number there.

<pre>% heroku run python hellodjango/sendArticles.py</pre>

Did it work?  Great!

## Schedule it in Heroku

The Heroku Scheduler is a free add-on, but remember that since it uses machine time it can start racking up the charges if you don&#8217;t keep an eye on it.  You can add it using the command line, or you can add it under &#8220;Resources&#8221; for [your application](https://api.heroku.com/myapps) on the Heroku site.  Once you&#8217;ve added it you can manage it using the [scheduler dashboard](https://heroku-scheduler.herokuapp.com/dashboard).

Pick whatever frequency you like, and put &#8220;python hellodjango/sendArticles.py&#8221; in the field, and you&#8217;re done.

Don&#8217;t forget to stop the scheduler when you&#8217;re no longer testing so you don&#8217;t get a surprise bill from Heroku later.

The next post will cover handling POST requests from Twilio in response to SMS replies from your users.