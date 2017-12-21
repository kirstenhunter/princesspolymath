---
id: 265
title: Enhancing your JQuery Website with the Facebook Graph
date: 2010-11-11T22:34:09+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=265
permalink: /enhancing-your-jquery-website-with-the-facebook-graph.html
aktt_notify_twitter:
  - yes
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 1890512997
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";b:0;s:11:"_thumb_type";s:10:"attachment";}'
categories:
  - Uncategorized
tags:
  - facebook
  - jquery
  - like
---
Hackday is here again at Netflix, so I&#8217;ve been working on a web version of the Intersect which uses JQuery. It occurred to me that adding social to the system would be some nice icing on the cake, so I set forth to use the Facebook Like Button to add things to the users&#8217; graphs, and then the Graph API to pull them back out.

The functionality I wanted to implement was:

  * Show a like button 
  * Show thumbnails for each of my friends who like the current movie
  * When the user&#8217;s thumbnail is clicked show all the movies liked by that friend in the app
  * When one of those movies is clicked, jump to that movie </ul> 
    Turns out this task was more challenging than I anticipated &#8211; partly because, as a hack, I hadn&#8217;t thought it out completely, and partly because some of the pieces were more difficult to implement than I&#8217;d expected.  You can see the resulting application [here](http://www.princesspolymath.com/webIntersect/index.php), although I will remind you that as a hack it&#8217;s not as stable as it might be, and it seems to be particularly sad in Firefox.
    
    This post will cover the process I went through from start to finish.
    
      1. Preparing the application for Facebook interaction
      2. Adding the like button
      3. Getting users who like the page
      4. Getting all the items for a particular user
    ### Preparing the application for Facebook interaction
    
    If your application uses JQuery or any other Javascript framework, it&#8217;s likely that the URL doesn&#8217;t change as you move around in the application.  However, if you want the Facebook interaction to address specific entities in your application (in my case, movies) you will need to adjust the application to accept different URLs for different items (likely using query parameters).
    
    For instance, the URL for my website was:
    
    `http://www.princesspolymath.com/webIntersect/index.html`
    
    But I wanted to be able to let people &#8220;like&#8221; particular movies, so I added an optional parameter &#8220;movie&#8221; to jump directly to a particular movie.
    
    ``Hackday is here again at Netflix, so I&#8217;ve been working on a web version of the Intersect which uses JQuery. It occurred to me that adding social to the system would be some nice icing on the cake, so I set forth to use the Facebook Like Button to add things to the users&#8217; graphs, and then the Graph API to pull them back out.

The functionality I wanted to implement was:

  * Show a like button 
  * Show thumbnails for each of my friends who like the current movie
  * When the user&#8217;s thumbnail is clicked show all the movies liked by that friend in the app
  * When one of those movies is clicked, jump to that movie </ul> 
    Turns out this task was more challenging than I anticipated &#8211; partly because, as a hack, I hadn&#8217;t thought it out completely, and partly because some of the pieces were more difficult to implement than I&#8217;d expected.  You can see the resulting application [here](http://www.princesspolymath.com/webIntersect/index.php), although I will remind you that as a hack it&#8217;s not as stable as it might be, and it seems to be particularly sad in Firefox.
    
    This post will cover the process I went through from start to finish.
    
      1. Preparing the application for Facebook interaction
      2. Adding the like button
      3. Getting users who like the page
      4. Getting all the items for a particular user
    ### Preparing the application for Facebook interaction
    
    If your application uses JQuery or any other Javascript framework, it&#8217;s likely that the URL doesn&#8217;t change as you move around in the application.  However, if you want the Facebook interaction to address specific entities in your application (in my case, movies) you will need to adjust the application to accept different URLs for different items (likely using query parameters).
    
    For instance, the URL for my website was:
    
    `http://www.princesspolymath.com/webIntersect/index.html`
    
    But I wanted to be able to let people &#8220;like&#8221; particular movies, so I added an optional parameter &#8220;movie&#8221; to jump directly to a particular movie.
    
`` 
    
    Once I&#8217;d added that piece of interaction, I needed to tackle the Open Graph metatags, so these liked items would correctly show up in the user&#8217;s Facebook graph as movies with the right metadata.  I tried inserting them using Javascript, but the Facebook linter does not accept dynamic content, so the metatags needed to be in place as soon as the page was loaded in order to be retrieved by the linter. What I needed to add to the headers was partly static content (app\_id, site\_name), but partly based on the movie being shown (title, picture, url)
    
    So my JQuery based &#8220;html&#8221; page switched to a .php file so that it could get pre-processed to show the metadata before the page was loaded.
    
    `http://www.princesspolymath.com/webIntersect/index.php?movie=BVQHL`
    
    Which was a great idea, except that coming into the page from that link meant I didn&#8217;t have the metadata I needed in order to create the open graph metadata tags. The information I needed for the tags had been retrieved from a web service, so getting them back again before page load (without storing them on the server) was a challenge. I decided to store the information I needed \*inside\* of the URL.
    
    `http://www.princesspolymath.com/webIntersect/index.php?movie=BVQHL&name=Howl%27s+Moving+Castleℑ=http%3A%2F%2Fcdn-3.nflximg.com%2Fus%2Fboxshots%2Flarge%2F70028883.jpg`
    
    My app ignored the extra parameters, but the PHP parser was able to get what it needed to make the tags:
  
    `function curPageURL() {<br />
$pageURL = 'http';<br />
if ($_SERVER["HTTPS"] == "on") {<br />
$pageURL .= "s";<br />
}<br />
$pageURL .= "://";<br />
if ($_SERVER["SERVER_PORT"] != "80") {<br />
$pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];<br />
}<br />
else {<br />
$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];<br />
}<br />
return $pageURL;<br />
}<br />
function getName() {<br />
return ($_GET["name"]);<br />
}<br />
function getImage() {<br />
return ("http://api.freebase.com/api/trans/image_thumb" . $_GET["fbId"] );<br />
}<br />
?>`
    
    ### Adding the Like Button
    
    Once I had the right URL, which had the right parameters to feed the Open Graph metatags back to the linter for proper graph inclusion, and the movie information so I knew what movie it refered to, I set to adding the Like Button.
    
    My first thought was to use the dynamic one created by the Javascript SDK (since I needed it for other functionality) &#8211; giving my users the opportunity to comment and giving me the ability to listen for clicks&#8230; but Safari had some security complaints about the way it was fiddling with content so I decided to fall back to the iframe version.
    
    I set it up using the URL I built above and checked to make sure that it was adding the correct movies to the graph (by directly querying graph.api.com to see whether there were new movies being added to my likes).
    
    Note that in this case, since I was dynamically generating the content for the dialog, I needed to tell the FB SDK to parse the page again once the elements were finished rendering:
    
    <pre>window.setTimeout(function() {																					   
    FB.XFBML.parse();
}, 500)
</pre>
    
    ### Getting Friends who Like the Page
    
    Unfortunately, there&#8217;s no direct graph query for &#8220;Give me all of my friends who like this page&#8221; &#8211; I couldn&#8217;t even get a list of the users who like the page similar to how the like button with pictures did it.  However, using the Facebook Javascript SDK it was relatively easy to get all of my friends and their movies. Note that it would have been more accurate to search for the specific ID for this movie, but I didn&#8217;t have that available &#8211; all I had was the URL I&#8217;d built and the name of the movie, so I used the name.
    
    <pre>FB.api("/me/friends?fields=movies,name,picture", function(friends) {
for (var friend in friends.data) {
	currentFriend = friends.data[friend]

	if (!currentFriend["movies"]) {
		continue
	}
	for (var friendmovie in currentFriend.movies.data) {
		thisFriendMovie = currentFriend.movies.data[friendmovie]
		if (thisMovieTitle == thisFriendMovie.name) {
			thisfriend = { "id":currentFriend.id,
			            		"name":currentFriend.name,
						"picture":currentFriend.picture
			}
			liking_friends.push(thisfriend)												
		}
	}
}</pre>
    
    ![Picture here](/assets/img/2010/11/friendswholike.jpg)
    
    ### Getting Movies for a Particular Friend
    
    I tagged the images of the user&#8217;s friends with their Freebase ID, so when the thumbnail was clicked, I grabbed that user&#8217;s movies from the graph:
    
    <pre>FB.api("/" + id + "/movies?fields=website,picture", function(movies) {
	faves = ""
	for (var movieIndex in movies.data) {
		currentMovie = movies.data[movieIndex]
		if (!currentMovie.website || !
                          currentMovie.website.match(/princesspolymath.com/)) {
				continue;
		}
		params = currentMovie.website.split('=');
		tinyurl = params[1].split('&#038;')[0]
		image = unescape(params[3])

		faves += '<!-- Commenting to avoid wp weirdness
                                <img alt="This is a picture" class="favepic" src="' + image + 
                                '" width="60" id="' + tinyurl + '">--> '
	}
	$('#faves').html(faves)
}) 
</pre>
    
    ![Picture here](/assets/img/2010/11/onefriendsmovies.jpg)
  
    I used the &#8220;website&#8221; information from the graph to get the id for the movie (the &#8220;movie&#8221; parameter) and the correct image to show in the application. When the user clicks on one of the movies for the user, the id is used to bring up a dialog with that movie, allowing people to navigate within the application using the graph information retrieved from Facebook.
    
    Feel free to play around with the application and &#8220;like&#8221; some movies to see how it works.