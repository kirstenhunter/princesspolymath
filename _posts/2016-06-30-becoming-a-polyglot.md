---
id: 846
title: Becoming a Polyglot
date: 2016-06-30	
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=846
permalink: /becoming-a-polyglot
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"847";s:11:"_thumb_type";s:5:"thumb";}'
post_slider_check_key:
  - 0
dsq_thread_id:
  - 4797540560
categories:
  - Geek Stuff
  - Web APIs
---
This article goes with the talk I gave at PolyConf 16 this year, on "Being a Polyglot."

As an API evangelist, I&#8217;m frequently put in a position where I need to provide sample code for my client developers, the folks who consume the API I&#8217;m charged with evangelizing.  Our sample code is mostly in python at this point, because it&#8217;s the easiest language to understand if you don&#8217;t know python (if that makes any sense). These samples are really simple, demonstrating how to use the signing library for the language and then make a few HTTP calls to the actual APIs.  However, I&#8217;ve run into several cases where customers are simply unwilling or unable to look at a "foreign" programming language to suss out what&#8217;s happening.  

I am a firm believer that any programmer can read another programming language and understand what the underlying logic is, especially for fairly simple examples.  The [polyglot repository](https://github.com/synedra/polyglot) shows the same functionality (a very simple API engine) in 5 different languages.  I&#8217;m hoping that providing this kind of apples to apples comparison will make it easier for developers to feel comfortable and confident looking at code in different languages.  This is great for your career, for lowering your frustration level, and for just generally increasing your ability to code creatively and efficiently.

If you are on a platform which doesn&#8217;t appreciate interpreted languages, you can use the Docker Image (fastest way to get started) by starting at the [Docker Website](https://www.docker.com).  The new native clients for docker in Mac and Windows are fantastic and I highly recommend them.  Just start up the docker engine and grab the repository with:

    docker run -i -t -p 8080:8080 synedra/polyglot

You can use the github repository linked above, or the docker version.  Instructions for each language are included in the repository itself, so give it a go.  

More instructions below:

## Polyglot Repository Walkthrough

This is a walkthrough of how you would get the python example up and running.

### Docker

To get the system working using docker:
* Install docker from https://docker.com/toolbox
* Grab the container with 

    docker run -i -t -p 8080:8080 synedra/polyglot

Run the following commands to populate the database and start the server:

    # /etc/init.d/mongodb start
    # mongoimport --collection quotes --file data/quoteid.json --type json --jsonArray
    # cd python
    # python flask-server.py

* Browse to [http://localhost:8080](http://localhost:8080) to see the welcome message
* Browse to [http://localhost:8080/api/quotes](http://localhost:8080/api/quotes) to see the json response
* Browse to [http://localhost:8080/demo](http://localhost:8080/demo) to see the application, and you can watch the traffic in chrome developer tools and see both the application response and JSON requests and responses

### Github
Pull the repository here:

    https://github.com/synedra/polyglot

You will need to have mongodb installed and running. Installation info for the major platforms is at [https://docs.mongodb.org/manual/installation/](https://docs.mongodb.org/manual/installation/)
To insert the information from the quoteid.json file to get your DB started, use the following command:

    mongoimport --collection quotes --file data/quoteid.json --type json --jsonArray 

To set up the python application, do the following:

    # cd python
    # python setup.py install
    # python flask-server.py


* Browse to [http://localhost:8080](http://localhost:8080) to see the welcome message
* Browse to [http://localhost:8080/api/quotes](http://localhost:8080/api/quotes) to see the json response
* Browse to [http://localhost:8080/demo](http://localhost:8080/demo) to see the application, and you can watch the traffic in chrome developer tools and see both the application response and JSON requests and responses

Try playing with the application, edit some things, add some functionality and send me a pull request (I like pull requests better than issues).
