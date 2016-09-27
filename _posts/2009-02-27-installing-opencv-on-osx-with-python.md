---
id: 144
title: Installing OpenCV on OS/X with Python
date: 2009-02-27T18:42:55+00:00
author: synedra

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=144
permalink: /installing-opencv-on-osx-with-python.html
aktt_notify_twitter:
  - yes
dsq_thread_id:
  - 1877196347
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - opencv
  - python
---
I need to get [OpenCV](http://opencv.willowgarage.com/wiki/Welcome) working on my system for a couple of image processing tasks I have for work, and as with many complex software systems, it was somewhat difficult to get it working on my system, a macbook pro running Leopard (OS/X 10.5). 

<div>
</div>

<div>
  Their <a href="http://opencv.willowgarage.com/wiki/InstallGuide">installation instructions</a> were fairly good.  I first tried to use regular old make, but I had a few issues with libraries that regular old make couldn&#8217;t find.  So I installed cmake to use for this purpose.  I highly recommend it.
</div>

<div>
</div>

<div>
  With cmake, I was successful with the suggested instructions:
</div>

<div>
  <pre>% mkdir build
% cd build
% cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PYTHON_SUPPORT=ON ../
</pre>
</div>

<div>
</div>

<div>
  After that, &#8216;make&#8217; and &#8216;make install&#8217;.  
</div>

<div>
</div>

<div>
  I ran into a few issues during this process.
</div>

<div>
</div>

<div>
  <ul>
    <li>
      No swig on my system.  The installation page lists it as an optional install, but it&#8217;s needed for python, and python is what I want (they say this, but I thought it would do something other than just ignore my desire for python).  So install swig, and use the CMake GUI tool to make sure that your SWIG_DIR is set correctly.
    </li>
    <li>
      Couldn&#8217;t find my Python.h file.  Since I had installed my python using darwinports, my Python.h isn&#8217;t really where it was looking.  I fixed this by editing the CMakeCache.txt to change PYTHON_INCLUDE_PATH:PATH=/sw/include/python2.5.  If your swig stuff is complaining about no Python.h (but you have one), find your Python.h and change this line in CMakeCache.txt.  There&#8217;s probably a more elegant solution, but this worked.
    </li>
    <li>
      For some reason CMake was pointing to the wrong SDK on my system (.  It wanted to use the 1.4u version, but I&#8217;ve got 1.5, so I changed /Developer/SDKs/MacOSX10.4u.sdk to /Developer/SDKs/MacOSX10.5.sdk using the CMake GUI.
    </li>
    <li>
      Couldn&#8217;t find my resulting opencv library.  I copied it to the /Library/Python path.
    </li>
    <li>
      I wanted to make sure it installed all of the examples, so I selected them using hte CMake GUI utility.
    </li>
  </ul>
  
  <p>
    Note that I did try the darwinports version, and lost a couple of hours trying to figure out how to get the python piece of that to work on my system.  I don&#8217;t suggest that path.
  </p>
</div>

<div>
</div>

<div>
  I am pleased to report that now the python examples (at least) work on my system.  Including the houghlines.py which I needed to do the actual task ahead of me.  So, hurray.
</div>

<div>
</div>

<div>
  I decided that to implement a houghcircles example I should really get the C code examples working, and thanks to the helpful instructions <a href="http://wiki.nuigroup.com/Installing_OpenCV_on_Mac_OS_X">here</a> I was able to do it easily. Follow those instructions and then you&#8217;ll be able to compile and run all of the C example files (and make your own, and run them too!)
</div>

<div>
</div>

<div>
  So I wrote a houghcircles example using some of the example code from the opencv book, and it works, kinda.  Pretty well I think, for just futzing around for an evening:
</div>

<div>
</div>

<div>
  <span class="Apple-style-span" style="color: rgb(0, 0, 0); font-size: 14px; white-space: pre-wrap;"><br /></span>
</div>

<span class="mt-enclosure mt-enclosure-image" style="display: inline;"><img alt="screenshot.jpg" src="http://www.princesspolymath.com/princess_polymath/screenshot.jpg" width="320" height="222" class="mt-image-none" style="" /></span> 

<div>
</div>

<div>
  Someone wrote to me about this blog post and said they were having some trouble with using the iSight for video input.  I discovered I was having the same problem.  The answer, gleaned from various places on the internets, was to unset DYLD_LIBRARY_PATH in my environment.  Confuses the heck out of openCV.  Which is kind of a problem because ROS requires it, at least to build.  So if you get weird library missing/wrong errors, unset that bad boy and see if it helps.
</div>