---
id: 182
title: 'Accessing Amazon&#8217;s Product Advertising API with Python'
date: 2010-02-10T19:49:37+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=182
permalink: /accessing-amazons-product-advertising-api-with-python.html
aktt_notify_twitter:
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1877196324
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - amazon
  - authentication
  - aws
  - python
---
I&#8217;m working on a little hacky toy for our upcoming hack day at work, and one of the pieces requires that I get some info from the Amazon &#8220;REST&#8221; API. It&#8217;s not REST in the least, but that&#8217;s not what I&#8217;m here to talk about. I&#8217;m here to talk about creating a signed request which works with the &#8220;Amazon Signature 2&#8221; format needed for the API. There&#8217;s a Perl library to do everything with the API, which is great if that&#8217;s what you&#8217;re looking for, but it wasn&#8217;t. I just wanted to sign a simple static request to get information about books for which I had the ISBN. No Python library exists, but fortunately if you&#8217;re using Python 2.5+ you&#8217;ve got everything you need with very little code. I&#8217;m including it here to save you the effort of pulling together the pieces yourself.

<pre># Create a signed request to use Amazon's API
import base64
import hmac
import urllib, urlparse
import time&lt;/code>

from hashlib import sha256 as sha256

AWS_ACCESS_KEY_ID = 'XXX'
AWS_SECRET_ACCESS_KEY = 'YYY'
hmac = hmac.new(AWS_SECRET_ACCESS_KEY, digestmod=sha256)

def getSignedUrl(params):
    action = 'GET'
    server = "webservices.amazon.com"
    path = "/onca/xml"

    params['Version'] = '2009-11-02'
    params['AWSAccessKeyId'] = AWS_ACCESS_KEY_ID
    params['Service'] = 'AWSECommerceService'
    params['Timestamp'] = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())

    # Now sort by keys and make the param string
    key_values = [(urllib.quote(k), urllib.quote(v)) for k,v in params.items()]
    key_values.sort()

    # Combine key value pairs into a string.
    paramstring = '&'.join(['%s=%s' % (k, v) for k, v in key_values])
    urlstring = "http://" + server + path + "?" + \
        ('&'.join(['%s=%s' % (k, v) for k, v in key_values]))

    # Add the method and path (always the same, how RESTy!) and get it ready to sign
    hmac.update(action + "\n" + server + "\n" + path + "\n" + paramstring)

    # Sign it up and make the url string
    urlstring = urlstring + "&Signature="+\
        urllib.quote(base64.encodestring(hmac.digest()).strip())

    return urlstring

if __name__ == "__main__":
    params = {'ResponseGroup':'Small,BrowseNodes,Reviews,EditorialReview,AlternateVersions',
                     'AssociateTag':'xxx-20',
                     'Operation':'ItemLookup',
                     'SearchIndex':'Books', 
                     'IdType':'ISBN',
                     'ItemId':'9780385086950'}
    url = getSignedUrl(params)
    print url
</pre>