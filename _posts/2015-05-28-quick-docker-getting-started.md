---
id: 795
title: Quick Docker Getting Started
date: 2015-05-28T16:25:27+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=795
permalink: /quick-docker-getting-started.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3802421079
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"796";s:11:"_thumb_type";s:5:"thumb";}'
categories:
  - Geek Stuff
  - Web APIs
---
Docker&#8217;s cool.  I mentioned this before, but hadn&#8217;t really made a great example for you to use for your own nefarious purposes&#8230; until now.

I&#8217;ve created a base github repository where you can fork it, create your own docker container, and you and your users cal pull it to wreak consistently architected havoc all over your curriculum, tutorial or workshop.

How does this work?

Well, first, here&#8217;s the [base github repository](https://github.com/synedra/docker-demo).  Since I love repeating myself so much I actually put all the instructions there too, so you can bail on this post and go over there and find your way to the shining diamond at the end of the puzzle&#8230; or follow along over here.  Makes no never mind to me, I just want you to have a container you own yourself so you can play with it willy nilly.

The first thing you&#8217;ll need to do is fork the repository.  This means you need a github login, but you should have one of those anyhow.  It&#8217;s a great way to build up your developer portfolio.  You can make things secret and private or leave them out there for all the world to see.  A note here &#8211; my code is frequently rushed and at the level of prototype/proof of concept, and rarely has anyone ever judged me (out loud) for having crappy code.  Shout it to the world.  Someone will learn from your code and the world will be a happier place.

Ok, now where were we before I went on my github digression?  Oh, right. Fork my repository.  Then you&#8217;ll have <yourusername>/docker-demo as a repository. It&#8217;s got a little pizza topping list REST API Server which has a front-end single page app where you can fiddle with the system.  Not terribly exciting, but it does have some requirements. You can pull this repository and run it on your system if you want&#8230; assuming you have node, and npm, and express&#8230;

But we&#8217;re going to do this an easier way, a way you can share your repository contents with anyone and make sure they have the base items they need available to them right up front.

So now, browse over to http://hub.docker.com.  Login with github (hey, aren&#8217;t you glad you have that login now?)  Click the &#8220;New Repository&#8221; button and select &#8220;Automated Build&#8221; &#8211; choose GitHub, and the repository you want to use.  The Automated Build setup means that every time you commit a change to your git repository a new build will be kicked off and any future pulls of docker will magically do the right thing.

At this point the docker hub will start building your container.  I&#8217;m not gonna lie &#8211; sometimes this takes just a few minutes and sometimes you age a bit before it&#8217;s done.  Usually it&#8217;s somewhere in between, but you can expect that when you need it most it&#8217;ll take several hours.  Just be patient. In the meantime you can get the right setup ready for docker on your system.

Go to the [Docker Installation page](https://docs.docker.com/installation/#installation) and find the right installation path for your system.  The rest of this tutorial assumes that you&#8217;re going to be using Windows or Mac, because the linux stuff is easier and I trust if you&#8217;re a linux user you&#8217;re just a little bit more tolerant to fiddly bits.

Install boot2docker from boot2docker.io.  Follow the installation prompts, then do:

<pre>MacBook-Pro:~ synedra$ boot2docker init
Virtual machine boot2docker-vm already exists
MacBook-Pro:~ synedra$ boot2docker start
Waiting for VM and Docker daemon to start
.....................oooo
Started.
Writing /Users/synedra/.boot2docker/certs/boot2docker-vm/ca.pem
Writing /Users/synedra/.boot2docker/certs/boot2docker-vm/cert.pem
Writing /Users/synedra/.boot2docker/certs/boot2docker-vm/key.pem
To connect the Docker client to the Docker daemon, please set:
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/synedra/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1</pre>

At this point you probably think you&#8217;re done.  You&#8217;re not.  Copy and paste those three export lines to set the right stuff in your environment.  Why they don&#8217;t just do this for you, I do not know, but you have to set them so please do.

We&#8217;re almost there.  Check docker hub to see if your container has progressed to &#8220;Finished&#8221;, in which case you can pull it.  Pulling it to run it is very simple &#8211; we&#8217;re going to build this ubuntu system and run a node server on it.  There are ways to simply have the docker container run and do its thing without interacting with it, but this is a learning environment so we want people to be able to see, touch, fiddle with and break the code in question.

<pre>MacBook-Pro:~ synedra$ docker pull synedra/docker-demo
Pulling repository synedra/docker-demo
9260ebbb31f0: Download complete
b68f8c8d2140: Download complete
1d57666667e5: Download complete
a216ec781532: Download complete
bd94ae587483: Download complete
c0ba4d33b334: Download complete
d6278a50beb0: Download complete
89495cd3e29b: Download complete
688fd0d83467: Download complete
e0013b00d1a1: Download complete
907e20b54361: Download complete
0bff597b5788: Download complete
c432b7a3c324: Download complete
c29af0b01296: Download complete
Status: Downloaded newer image for synedra/docker-demo:latest
MacBook-Pro:~ synedra$ docker run -i -t synedra/docker-demo /bin/bash
root@0bef28a21e83:/opt/webapp#
</pre>

There, you&#8217;ve got a container running that can run node. All you need to do at the prompt is type &#8220;node toppings.js&#8221; to start the server. You do have a slight challenge here in that you aren&#8217;t sure what the IP address is for your container &#8211; it maintains a separate IP within your system. In a separate window type boot2docker ip and it&#8217;ll give you that number. Node is running the server at port 3000 (if you look into toppings.js you can see this at the bottom) so simply point your browser to <ip\_address\_for_docker>:3000 and you&#8217;ll get the toppings application.
  
To understand the power of this, make some changes to your github repository and watch them bubble through to the docker container. Anytime anyone pulls the container they&#8217;ll get the most recent version of the github repository.

I&#8217;ll be giving a live workshop on this at OSBridge in Portland in a couple of weeks (Wednesday, June 24th) where we&#8217;ll go through this together, along with some extra fun times working with each others&#8217; containers. Don&#8217;t miss it!