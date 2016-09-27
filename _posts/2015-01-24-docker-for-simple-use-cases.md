---
id: 768
title: Docker for Simple Use Cases
date: 2015-01-24T11:59:14+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=768
permalink: /docker-for-simple-use-cases.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3452057558
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"770";s:11:"_thumb_type";s:5:"thumb";}'
categories:
  - Geek Stuff
  - Python
  - Web APIs
tags:
  - containers
  - docker
---
As you probably know, I work as an API Evangelist at [Akamai](http://developer.akamai.com), and we&#8217;ve been working to decrease the learning curve for getting started with our APIs.  We&#8217;ve got an excellent online tutorial and our evangelists travel around giving workshops to our customers so they can get some hands-on experience using the system.

Unfortunately, the system setup during workshops has revealed to me that the system setup for the exercises can frequently take longer than the actual exercises.  Different operating systems, custom setup or configuration and specific development environments can make a relatively straightforward process challenging.

I found a similar challenge when working on my &#8220;Irresistible APIs&#8221; book.  The second chapter is a mini-workshop to set up a local API and view it using a basic web page.  However, just like with the Akamai workshop, system setup can be quite a challenge.

After looking around for ways to improve the experience, I landed on [Docker](http://www.docker.com). You may have encountered or heard of Docker in the context of complicated systems or development environments, where the primary goal is to maintain consistency between systems, and frequently the containers are connected (linked) together to create a fully operational system.  This is a great use case for this technology, but I realized it was also an excellent framework for my simpler use case &#8211; helping people get a simple system up and running without having to install a new language or specific libraries.  As an added bonus, the existing system&#8217;s development environment is not changed &#8211; when working with developers this is frequently a concern.

This system is fantastic for someone like me, who frequently lives in an interrupt-driven world &#8211; every time I change the github repository for the system, a new docker container is created, so any changes I make are immediately (or so) available for users to download.

The docker container I created for the book includes a web server using flask (a python web framework).  This server provides a REST API for toppings on a pizza &#8211; what can I say, I was tired of making to-do lists.  Additionally, there is a javascript page which exercises the API, letting you play with the pizza topping API directly.  Setting this up on a unix-based system is relatively simple &#8211; you can see the whole system in the [git repository](https://github.com/synedra/irresistible).  However, through creation of a [Dockerfile](https://github.com/synedra/irresistible/blob/master/Dockerfile) along with registering the container in the [Docker Hub](https://hub.docker.com) (it&#8217;s free to use as long as your containers are all public), I was able to make the system setup much easier.

To install this system, follow the [installation](https://docs.docker.com/installation/%20) guide for your operating system to get started with Docker.  Start it up, then grab my container with the following command:

> <pre>sudo docker run -i -t -p 80:5000 synedra/irresistible /bin/bash</pre>

The above command will put you in a root shell on the container (which is, essentially, a tiny linux box running on your system).  To run the web application, issue the following command:

> <pre>python app.py</pre>
> 
> <pre>* Running on http://0.0.0.0:5000/</pre>

Since you&#8217;ve mapped the 5000 port to port 80 (with the docker run command), you need to grab the docker IP address:

> <pre>boot2docker ip</pre>

At that point, you can point a browser to http://<docker\_ip\_address>:5000 and interact with the system. The console you have started will show the logs for your system as you interact with it.

Play with it, have fun, and contact me at @synedra on twitter if you have comments, questions, or remarks about this system.

If you are an Akamai customer interested in our APIs, contact our team at open-developer@akamai.com to get instructions for installing the Docker container for our getting started repository.