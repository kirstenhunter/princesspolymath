---
id: 773
title: 'Ask the Princess: Episode 1'
date: 2015-01-27T20:43:43+00:00
author: admin

layout: page
sidebar: left
guid: http://www.princesspolymath.com/princess_polymath/?p=773
permalink: /ask-the-princess-episode-1.html
post_slider_check_key:
  - 0
dsq_thread_id:
  - 3461875243
tc-thumb-fld:
  - 'a:2:{s:9:"_thumb_id";s:3:"712";s:11:"_thumb_type";s:5:"thumb";}'
categories:
  - Uncategorized
---
<a href="/assets/img/LogoNewSite.png" class="grouped_elements" rel="tc-fancybox-group773"><img alt="This is a picture" class=" size-full wp-image-735 alignleft" src="/assets/img/LogoNewSite.png" alt="Logosmall" width="100" height="99" /></a>This is the first in a series of posts entitled &#8220;Ask the Princess.&#8221;  I am a princess and a polymath, and I&#8217;ve got lots of opinions and experience around various things.  Topics covered here will be mostly about building APIs, but can cover martial arts, parenting, politics, or anything else anyone chooses to ask me about.  Bring it on, I&#8217;ll answer with all the information and snark I can summon for your topic.    Without any further introduction, here&#8217;s the first column.  The questions and answers are both mine.  Send me an email or tweet with a question and I promise to address it in a future column.

### _Who are you, and why should I listen to your advice?_

I&#8217;m Princess Polymath, and I&#8217;ve had a lot of experience as a developer, an evangelist, a mom and, well, a human. I have insight and experience to share, and lots of snark to season it with.  If you&#8217;re a developer or consumer of web APIs my questions and answers should be particularly useful to you, but I&#8217;m aiming for columns that are funny and fun for any humans who care to take the time to read them.  My goal in life is to entertain, engage, and help people to get past frustrations &#8211; and this seemed like another good tool for my tool belt.  But since I&#8217;m asking my own questions, let&#8217;s start with something easy.

### _I&#8217;ve got a great API but haven&#8217;t had time to make any documentation.  I want to release it right now!  What do you think?_

APIs aren&#8217;t like other products.  If a developer comes to use your API and ends up with a poor experience, they&#8217;re unlikely to ever come back.  Remember that a lack of documentation, without any context for how it&#8217;s expected to work, can and will result in an extremely frustrated developer, and they&#8217;ll do whatever they can never to use your system again.

To quote a trite but appropriate cliche, you only get one chance to make a first impression, and in the world of APIs the bar is high for a great first experience.  Developers can get frustrated easily, and have little patience for someone who doesn&#8217;t value their time and energy.

Make the documentation.  Create some tutorials.  Write and show sample code, and be available to give good support to your developers.  Show them that their time is important and valuable to you and they&#8217;ll pay you back by becoming advocates for your system within their community.

### _I have a fantastic idea for an API.  I whipped it up last night, and it&#8217;s awesome!!!  Why isn&#8217;t my manager excited about it?  It&#8217;s totally not fair 🙁_

Sorry, I&#8217;m siding with your manager here.  You made an API&#8230; to solve what problem?  What is the purpose of the API?  Creating additional interfaces into your system without understanding what they should be used for is really not gonna make for an excellent product.  Your API has to be a first class product, and I&#8217;m sorry to say that skipping the steps of figuring out the business value and use cases, and how you&#8217;re going to measure success mean that what you&#8217;ve created is a toy, a hobby, and not a product the company will want to support.

If you&#8217;re certain that your API is super awesome, you can actually back into the right information by figuring out use cases for your API and creating prototypes for them.  Then determine what value this product can have for your company.  APIs don&#8217;t have to create money from thin air &#8211; many of them aren&#8217;t even going to increase monetization &#8211; but they can make your main products better, more appealing, more accessible to your customers.  You can improve the user experience, keep partners more engaged, and create more love and attention for your company&#8217;s system.

Just imagine you&#8217;re trapped in an elevator with your CEO and you&#8217;re trying to explain why you have an API &#8211; and that &#8220;Because&#8230; API!!!&#8221; isn&#8217;t going to fly.

### _You have a lot of things to say about irresistible APIs, but my API is only for use inside of my company &#8211; the developers are forced to use the system and so I don&#8217;t have to worry about their &#8220;Experience.&#8221;  So thanks for the thoughts, but I don&#8217;t need them._

Ok, sure, you can think that way.  But let me just tell you that in my experience, people who are forced to do something that&#8217;s unnecessarily difficult tend to become very recalcitrant &#8211; nobody wants to be told how they have to achieve a goal.  Sure, they&#8217;ll use your system, but a poorly designed API will cause them to try to figure out how to achieve their goals in whatever way they can, and they&#8217;ll likely end up pushing the edges of your system to try to achieve their goals, cursing your name the entire time.  Without excellent documentation they&#8217;ll waste time attempting to figure out what the system needs to function.  Without example code or tutorials they&#8217;ll use the system in ways you likely don&#8217;t expect.  All of these will create a much larger support burden for your team, and worse yet, these developers likely have the ability to escalate to your management chain and create trouble for you in the future.  Take my advice, make a system that&#8217;s straightforward, well documented, and simple to use, and save yourself the headache and heartache of having to support cranky developers who have no choice but to use your system.  Plus, maybe they&#8217;ll give you beer.

### _As a favor to my users, I&#8217;ve created convenience API resources like &#8220;latest&#8221; for the most recent item in a list, but they are whining that redirects aren&#8217;t usable with complicated authentication schemes.  What&#8217;s \*wrong\* with these people???_

What&#8217;s wrong with you?  My apologies, but there are two different ways to approach problem solving in the development world.  You can make things easy for yourself, but hard for your users&#8230; or you can do the opposite.  One major goal of web APIs, REST in particular, is to create a system that&#8217;s simple for developers to use for integration and automation.  Since you&#8217;re working to make the system accessible for developers using different languages, frameworks, or platforms, you need to keep this goal at the top of your priority list.  Don&#8217;t get lazy &#8211; even though it may take a little longer to do the right thing, not doing the right thing can create a support nightmare.

For instance, in this case, a call to /my/resource/latest can act in one of two ways (from the developer&#8217;s perspective).  In the simplest case, they make the (signed) call to the latest endpoint and get back the correct information, likely with information about the resource&#8217;s actual URL.  One call, getting the data back, just as the developer would expect.  You&#8217;ll find that I yammer pretty constantly about making sure you don&#8217;t surprise your developers &#8211; much as UX experts talk about how important it is not to surprise your users.  In this case, the developers are your users, and making them make two separate calls is certainly not what they expect.  It seems like it&#8217;s not a big deal, but consider the following:

  * It&#8217;s not a convenience method if the developer has to write code to make a second call.  They might as well get the list to find the last member and then pull the correct resource.  You haven&#8217;t created a &#8220;convenience&#8221; method if it requires the same amount of effort as existing resources, and you&#8217;ve created an incorrect expectation by apparently offering something easier &#8211; which isn&#8217;t really.
  * More importantly, this process (making a call, getting back a redirect and then signing/making a second request) is \*more\* work than the more standard approach I described above.  Most HTTP libraries can handle 302&#8217;s with grace, but many won&#8217;t know to re-sign the request with the authentication scheme when making the second request.  So now, the developer who was able to use a standard library for their language has to update it to add new functionality

So, no.  Making convenience functions or resources is a great idea &#8211; but consider carefully how people will use those resources and make sure that your implementation makes it easier for your users to access the system.  In this case, your server should do the work, not the client.  Find the resource represented by &#8220;latest&#8221; and just return that to the client.  Problem solved!  Yes, it&#8217;s more work for you, but a little extra work on your part will save a lot of time and heartache for your users.

### _Ask the Princess_

So here you have it, Ask the Princess.  You are welcome to ask me questions about \*anything\*.  Programming, fitness, data, martial arts, cooking, APIs, anything at all, and I will do my best to answer them in a way that gives you what you&#8217;re looking for.  Send questions to me at @synedra on twitter or post them here as comments and I&#8217;ll write another column when I have enough questions.  Or when I&#8217;ve put together enough of my own questions and feel like writing some more.

Thanks for your time, and get out there and make something amazing!
