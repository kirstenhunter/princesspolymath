---
id: 307
title: Using Faceted Search from the LinkedIn API
date: 2011-01-31T15:52:55+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=307
permalink: /using-faceted-search-from-the-linkedin-api.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1875937499
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - JSAPI
  - LinkedIn
  - Web APIs
  - YUI
---
As many of you know, I&#8217;m now happily employed as a Developer Advocate at LinkedIn. Part of my job there is to create interesting examples using our APIs, to help other developers find their footing and create new and interesting applications.  This will be the first in a long line of posts demonstrating how to use our API to create cool apps.

Note that this, as with many other applications, will be much less interesting with small networks. Grab more connections and it&#8217;ll have more cool data to play with.

## Faceted Search


  
My passion has always been for showing interesting intersections of data.  The LinkedIn website has a faceted search feature you can see when browsing [people you may know](http://www.linkedin.com/pymk-results?showMore=&trk=nmp_pymk_more). On the left hand side of that page, you&#8217;ll see companies and schools listed there.  Selecting one or more companies restricts the people to those folks who match one of those companies.  Selecting a school or schools does the same thing.  Selecting both creates an &#8220;and&#8221;.

Try these examples on the website to get a feel for how the facet searches work. Because these facets are tuned to your network, you&#8217;ll have different companies and schools, but you can still see how the intersections work.

  * People who worked at Netflix in the past
  * People who worked at Netflix in the past \*and\* attended Stanford University
  * People who worked at Intel in the past and work at Yahoo! now
  * People who worked at either Cisco Systems or Microsoft in the Past

This same functionality is available via the LinkedIn API. Information on faceted search can be found in the [People Search API](http://developer.linkedin.com/docs/DOC-1191#Facets) documentation.

## FacetBrowse

So how does this translate into a real application? The application above shows one possible implementation. But how does it work?  I&#8217;ll walk through the pieces of this application.  If you want to see the source application (which uses the LinkedIn JSAPI for interaction with LinkedIn, and YUI for presentation) you can look at the page directly at http://www.princesspolymath.com/facetbrowsesmall.html

On the left hand side of the application you see a list of buttons &#8211; by default you&#8217;re looking at the companies, but go ahead and switch to schools. This list is built as soon as the user has authenticated with LinkedIn, with a raw query to the API:

> <pre>function onLinkedInAuth() {
    IN.API.Raw("/people-search:" +
   "(people:(first-name,last-name,positions:" +
    "(company:(ticker,name)),educations,picture-url),facets:" +
    "(code,buckets:(name,code,count)))?" +
    "facets=current-company,school&sort=distance&count=25")
    .result(displayFacetResults)
}
&lt;/blockquote>
</pre>
> 
> This returns the top 10 schools in your network, the top 10 companies in your network, and 25 of your contacts. FacetBrowse builds the buttons for the left hand side of the widget and labels them so the app knows what&#8217;s been selected when someone clicks one of the buttons. It then trims out contacts who don&#8217;t match any of the top companies or schools, leaving you with something that looks like this:
> 
> ![](/defaultapp.jpg)
> 
> Any time one of the buttons is clicked, the function refreshConnections is called, which does the same facet search &#8211; this time specifying a company and/or school.
> 
> > <pre>function onLinkedInAuth() {
    IN.API.Raw("/people-search:" +
   "(people:(first-name,last-name,positions:" +
    "(company:(ticker,name)),educations,picture-url),facets:" +
    "(code,buckets:(name,code,count)))?" +
    "facets=current-company,school&sort=distance&count=25" + 
    "facet=past-company,{company-code}&#038;facet=school,{school-code})
    .result(displayFacetResults)
}</pre>
> 
> Note that because of the way the facet search works, you can&#8217;t create intersections within the request (this company \*and\* that company). Since I want to create these intersections, when I&#8217;m refreshing connections, I ask for one of the companies and one of the companies and then eliminate matches which don&#8217;t match all of the company/school choices.
> 
> For instance, when the user selects two different companies, such as they have here:
  
> ![](/microflix.jpg)
> 
> The application asks for the people-search and declares &#8220;current-company=<microsoft_code>&#8220;. When the results come back, each person is inspected to make sure that they have both Microsoft and Netflix within their positions. Matching results are displayed in the grid.
> 
> If a school is then selected (so now we have Stanford, Microsoft and Netflix):
  
> ![](/microflixford.jpg)
> 
> The query requests Stanford University as a school and Microsoft as a company, and then checks each returned person to make sure they also have Netflix in their profile.
> 
> This application is just a small example of what can be done with the LinkedIn faceted search. Tell me in the comments if you&#8217;ve found other uses for it, or have questions about how it works.