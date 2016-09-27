---
id: 511
title: Using LinkedIn Authentication with Django on Heroku
date: 2011-12-20T11:28:05+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=511
permalink: /using-linkedin-authentication-with-django-on-heroku.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1875931358
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
---
To build the LinkedIn Today SMS Notification System, I needed to find a framework where I could do the following:

  * Integrate LinkedIn OAuth with a more general user management system
  * Post the system to a public site
  * Handle POST requests from external clients

For this set of criteria, I chose to use Django and publish it using Heroku.  This post is similar to the Django [Getting Started Guide for Heroku](http://devcenter.heroku.com/articles/django), but it&#8217;s designed for this specific use case &#8211; Using LinkedIn OAuth as the login system and integrating it with the Django user management system.  The code for this example is available [here](https://github.com/synedra/django-linkedin-simple).

Here are the prerequisites for this tutorial:

  * Python, virtualenv, pip, and the Heroku toolbelt as described in [Getting Started with Python on Heroku/Cedar](http://devcenter.heroku.com/articles/python).
  * An installed version of [Postgres](http://www.postgresql.org/) to test locally
  * A Postgres user and a database to use for Django (in this case I&#8217;m using &#8216;linkedin&#8217;)
  * A LinkedIn [API Key](https://www.linkedin.com/secure/developer).  If you haven&#8217;t worked with the LinkedIn API before, you&#8217;re encouraged to go through the [Quick Start Guide](https://developer.linkedin.com/documents/quick-start-guide).

## Create Your Django Environment

<div>
  For the basic setup I&#8217;m following, very closely, the <a href="http://devcenter.heroku.com/articles/django">tutorial for Heroku</a>, so I&#8217;m leaving out some of the explanation &#8211; please refer to the original if you have questions about how things work.  The following steps will create a virtual environment (development sandbox), install needed modules there, and get your Django project and applications created.
</div>

<pre lang="term">% mkdir hellodjango && cd hellodjango
% virtualenv --no-site-packages vent
% source venv/bin/activate
% pip install Django psycopg2 oauth2 simplejson
% django-admin.py startproject hellodjango
% cd hellodjango
% python manage.py startapp linkedin</pre>

<p lang="term">
  Now that you&#8217;ve done all these pieces, you have a working django system.
</p>

<h2 lang="term">
  File Setup
</h2>

<p lang="term">
  In order to add the LinkedIn integration, you&#8217;ll need to edit the settings and URL files.  I&#8217;ve created a <a href="https://github.com/synedra/django-linkedin-simple">GitHub repository</a> with the code needed for this example, and you can use that as your model &#8211; but I&#8217;ll walk through the changes here so you understand how they work.
</p>

<h3 lang="term">
  hellodjango/settings.py
</h3>

Edit the DATABASES section to configure it to use postgres, and your database:

<pre>DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'linkedin',
        'USER': 'postgres',
        'PASSWORD': 'xxx',
        'HOST': '',
        'PORT': '5432',
    }
}</pre>

<div>
  You also need to add &#8216;linkedin&#8217; to your INSTALLED_APPS:
</div>

<div>
  <pre>INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'linkedin'
    # Uncomment the next line to enable the admin:
    # 'django.contrib.admin',
    # Uncomment the next line to enable admin documentation:
    # 'django.contrib.admindocs',
)</pre>
  
  <p>
    And finally, you need to tell the application you want to use LinkedIn for authentication and set up your credentials (this can go anywhere in the settings.py file)
  </p>
  
  <pre>AUTH_PROFILE_MODULE= 'linkedin.UserProfile'
LINKEDIN_TOKEN='xxx'
LINKEDIN_SECRET='xxx'
LOGIN_URL='/login/'</pre>
  
  <h3>
    hellodjango/urls.py
  </h3>
  
  <p>
    You also need to update the urls.py file to add the LinkedIn authentication pages.
  </p>
  
  <pre id="LC18">url(r'^login/?$', 'linkedin.views.oauth_login'),
url(r'^logout/?$', 'linkedin.views.oauth_logout'),
url(r'^login/authenticated/?$', 'linkedin.views.oauth_authenticated'),
url(r'^$','linkedin.views.home'),</pre>
  
  <h3 id="LC18">
    hellodjango/linkedin/models.py
  </h3>
  
  <p>
    Using LinkedIn Auth means we&#8217;ll need to store the user&#8217;s token and secret for later requests:
  </p>
  
  <pre id="LC1">from django.db import models
from django.contrib.auth.models import User
class UserProfile(models.Model):
    user = models.ForeignKey(User)
    oauth_token = models.CharField(max_length=200)
    oauth_secret = models.CharField(max_length=200)</pre>
  
  <h3 id="LC18">
    hellodjango/linkedin/views.py
  </h3>
  
  <p>
    I&#8217;m including the code here, although it&#8217;ll be easier to just get it from GitHub.  This code demonstrates the full OAuth login flow, creating a new Django user using the response, and subsequently making a request using the stored information (home).
  </p>
  
  <pre id="LC1"># Python
import oauth2 as oauth
import cgi
import simplejson as json
import datetime
import re</pre>
  
  <pre id="LC8"># Django
from django.http import HttpResponse
from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.conf import settings
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required</pre>
  
  <pre id="LC17"># Project
from linkedin.models import UserProfile</pre>
  
  <pre id="LC20"># from settings.py
consumer = oauth.Consumer(settings.LINKEDIN_TOKEN, settings.LINKEDIN_SECRET)
client = oauth.Client(consumer)
request_token_url = 'https://api.linkedin.com/uas/oauth/requestToken'
access_token_url = 'https://api.linkedin.com/uas/oauth/accessToken'
authenticate_url = 'https://www.linkedin.com/uas/oauth/authenticate'

# /login
def oauth_login(request):</pre>
  
  <pre id="LC20">    # Step 0. Get the current hostname and port for the callback
    if request.META['SERVER_PORT'] == 443:
     current_server = "https://" + request.META['HTTP_HOST']
    else:
     current_server = "http://" + request.META['HTTP_HOST']
     oauth_callback = current_server + "/login/authenticated"</pre>
  
  <pre id="LC35">    # Step 1. Get a request token from Provider.
    resp, content = client.request("%s?oauth_callback=%s" % (request_token_url,oauth_callback), "GET")
    if resp['status'] != '200':
        raise Exception("Invalid response from Provider.")
    # Step 2. Store the request token in a session for later use.
    request.session['request_token'] = dict(cgi.parse_qsl(content))
    # Step 3. Redirect the user to the authentication URL.
    url = "%s?oauth_token=%s" % (authenticate_url,
        request.session['request_token']['oauth_token'])
    print url
    return HttpResponseRedirect(url)</pre>
  
  <pre># / (requires login)
@login_required
def home(request):</pre>
  
  <pre>    html = "&lt;html&gt;&lt;body&gt;"
    token = oauth.Token(request.user.get_profile().oauth_token,request.user.get_profile().oauth_secret)
    client = oauth.Client(consumer,token)
    headers = {'x-li-format':'json'}
    url = "http://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline)"
    resp, content = client.request(url, "GET", headers=headers)
    profile = json.loads(content)
    html += profile['firstName'] + " " + profile['lastName'] + "&lt;br/&gt;" + profile['headline']
    return HttpResponse(html)</pre>
  
  <pre id="LC49"># /logout (requires login)
@login_required
def oauth_logout(request):</pre>
  
  <pre id="LC56">    # Log a user out using Django's logout function and redirect them
    # back to the homepage.
    logout(request)
    return HttpResponseRedirect('/')</pre>
  
  <pre id="LC63">#/login/authenticated/
def oauth_authenticated(request):
    # Step 1. Use the request token in the session to build a new client.
    token = oauth.Token(request.session['request_token']['oauth_token'],
        request.session['request_token']['oauth_token_secret'])
    if 'oauth_verifier' in request.GET:
        token.set_verifier(request.GET['oauth_verifier'])
    client = oauth.Client(consumer, token)
    # Step 2. Request the authorized access token from Provider.
    resp, content = client.request(access_token_url, "GET")
    if resp['status'] != '200':
        print content
        raise Exception("Invalid response from Provider.")
    access_token = dict(cgi.parse_qsl(content))
    headers = {'x-li-format':'json'}
    url = "http://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry)"
    token = oauth.Token(access_token['oauth_token'],
        access_token['oauth_token_secret'])
    client = oauth.Client(consumer,token)
    resp, content = client.request(url, "GET", headers=headers)
    profile = json.loads(content)<span class="Apple-style-span" style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 13px; line-height: 19px; white-space: normal;">    </span></pre>
  
  <pre id="LC86">    # Step 3. Lookup the user or create them if they don't exist.
    firstname = profile['firstName']
    lastname = profile['lastName']
    identifier = profile['id']
    try:
        user = User.objects.get(username=identifier)
    except User.DoesNotExist:
        user = User.objects.create_user(identifier,
            '%s@linkedin.com' % identifier,
            access_token['oauth_token_secret'])<span class="Apple-style-span" style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 13px; line-height: 19px; white-space: normal;">         </span>        user.first_name = firstname
        user.last_name = lastname
        user.save()
        # Save our permanent token and secret for later.
        userprofile = UserProfile()
        userprofile.user = user
        userprofile.oauth_token = access_token['oauth_token']
        userprofile.oauth_secret = access_token['oauth_token_secret']
        userprofile.save()
    # Authenticate the user and log them in using Django's pre-built
    # functions for these things.
    user = authenticate(username=identifier,
        password=access_token['oauth_token_secret'])</pre>
  
  <pre id="LC111">    login(request, user)
    return HttpResponseRedirect('/')</pre>
  
  <p id="LC111">
    For any future requests, you&#8217;ll grab the user&#8217;s token and secret from the profile to make the request just like what&#8217;s shown in the &#8220;home&#8221; example above.  I&#8217;ll go into this in more detail in the following posts, on creating scheduled requests and handling POST requests from external systems.
  </p>
  
  <h3 lang="term">
    Procfile
  </h3>
  
  <p>
    This is needed at the top level (same level as the hellodjango project directory) to tell Heroku how to run your application.
  </p>
  
  <pre>web: python hellodjango/manage.py runserver "0.0.0.0:$PORT"</pre>
  
  <h3 lang="term">
    .gitignore
  </h3>
  
  <p>
    Ignore the venv directory and compiled python files
  </p>
  
  <pre>venv
*.pyc</pre>
  
  <h2>
    Test Django Server Locally
  </h2>
  
  <p>
    Ok, now that you&#8217;ve gotten everything all set up (or grabbed it from github), you&#8217;re ready to run the server and make sure it works correctly.
  </p>
  
  <pre>% python manage.py syncdb
% python manage.py runserver</pre>
  
  <p>
    This should bring up a server on localhost which does the basic authentication dance and presents the user&#8217;s name and headline (so exciting!)
  </p>
  
  <h2>
    Deploy to Heroku
  </h2>
  
  <p>
    Finally, we can get to the Heroku deployment.  Again, this is taken almost verbatim from the <a href="http://devcenter.heroku.com/articles/django">Getting Started With Django</a> document on Heroku, so refer to that for more information on what&#8217;s happening.
  </p>
  
  <pre>% git init
% git add .
% git commit -m "My LinkedIn Django App"
% heroku create --stack cedar
% git push heroku master
% heroku run python hellodjango/manage.py syncdb 
% heroku open</pre>
  
  <p>
    This should give you the same experience on Heroku that you have on your local system &#8211; the user is sent to LinkedIn to log in, they&#8217;re added to the system and presented a fascinating page with their basic information.
  </p>
  
  <p>
    I&#8217;ve made this example as simple as possible to make it easy to integrate into your Django Application without unnecessary overhead.  Comments, clarifications or other questions welcome.
  </p>
</div>