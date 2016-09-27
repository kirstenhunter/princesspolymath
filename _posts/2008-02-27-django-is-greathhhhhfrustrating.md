---
id: 27
title: Django is great^h^h^h^h^hfrustrating
date: 2008-02-27T18:23:08+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=27
permalink: /django-is-greathhhhhfrustrating.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1941502545
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Geek Stuff
tags:
  - django
  - python
---
Don&#8217;t get me wrong. I do like [django](http://www.djangoproject.com). I&#8217;ve been working back and forth in [Pylons](http://www.pylonshq.com) and Django, trying to learn each of them well enough so that I can figure out which one will give the right answer when I know better what the powers that be want.
  
So, if you, like me, have a debian etch box upon which you want to install django, have it work with the tutorials in the book and on the site (thus needing python2.5), using mod_python so that you can work on a remote server, with postgres, do the following:

  * Use the Django from subversion. It lives in http://code.djangoproject.com/svn/django/trunk (don&#8217;t forget to uninstall python-django if you&#8217;ve already installed that.
  * It requires python2.5. The packaged version is fine. `apt-get install python2.5`
  * Get mod_perl as a package, because it will make all the connections correctly (but it will be linked to python2.4), and then
  * Install apache2-prefork-dev so that you have the right apxs2 to build mod_python against python2.5
  * Download mod\_python from http://ftp.wayne.edu/apache/httpd/modpython/mod\_python-3.3.1.tgz
  * Configure it (with &#8211;apxs=/usr/bin/apxs2)
  * Install it
  * Get psycopg from http://www.initd.org/pub/software/psycopg/PSYCOPG-2-0/psycopg2-2.0.5.1.tar.gz. Don&#8217;t get fancy and try the new one. It doesn&#8217;t work.
  * python setup.py install that sucker
  * And then restart everything and all should be lovely in the world

So that&#8217;s&#8230;

<pre>svn co http://code.djangoproject.com/svn/django/trunk django
ln -s `pwd`/django /usr/lib/python2.5/site-packages/
ln -s `pwd`/django/django/bin/django-admin.py /usr/local/bin
apt-get install python2.5 libapache2-mod-python apache2-prefork-dev
wget http://ftp.wayne.edu/apache/httpd/modpython/mod_python-3.3.1.tgz
tar xzf mod_python-3.3.1.tgz
cd mod_python-3.3.1
./configure --apxs=/usr/bin/apxs2
sudo make install
cd ..
wget http://www.initd.org/pub/software/psycopg/PSYCOPG-2-0/psycopg2-2.0.5.1.tar.gz
tar xzf psycopg2-2.0.5.1.tar.gz
cd psycopg2.2.0.5.1
sudo python setup.py install
sudo /etc/init.d/apache2 restart
</pre>

I spent a good deal of today trying to find these answers. So, you&#8217;re welcome 🙂