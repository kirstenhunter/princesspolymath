---
#
# Use the widgets beneath and the content will be
# inserted automagically in the webpage. To make
# this work, you have to use › layout: frontpage
#
layout: frontpage
widget1:
  title: "Becoming a Polyglot"
  url: "/becoming-a-polyglot"
  image: polyglot.png
  text: 'Learn how to translate between different programming languages with this simple set of API engines in 5 different interpreted languages.  Become a programming language polyglot and play with some working code!'
widget2:
  title: "Telling your Story: Speaking for Non-Speakers"
  image: 'storytelling-1.jpg'
  text: '<em>Telling your Story</em> gives an overview of thinking about presentations in a new way - as stories you share with your audience to help them understand what you are conveying.  You have a story to tell, and people want to hear it!'
  url: '/telling-your-story-speaking-for-non-speakers.html'
widget3:
  title: "Irresistible APIs"
  url: '/irresistible/'
  image: 'http://irresistibleapis.com/CoverSmall.jpg'
  text: 'My new book on "Irresistible APIs" will be published in paper form by the end of August in 2016.  In the meantime, you can see the <a href="/irresistible/">post</a> and watch the video to decide if you want to buy the book.  Note that you can purchase it in electronic form now from Manning and get the paper version when it is ready!'
sidebar: left
#
# Use the call for action to show a button on the frontpage
#
# To make internal links, just use a permalink like this
# url: /getting-started/
#
# To style the button in different colors, use no value
# to use the main color or success, alert or secondary.
# To change colors see sass/_01_settings_colors.scss
#
callforaction:
  url: http://irresistibleapis.com/
  text: Check out Irresistible APIs!
  style: alert
permalink: /index.html
# This is a nasty hack to make the navigation highlight
# this page as active in the topbar navigation
#
homepage: true
---

<div id="videoModal" class="reveal-modal large" data-reveal="">
  <div class="flex-video widescreen vimeo" style="display: block;">
    <iframe width="1280" height="720" src="https://www.youtube.com/embed/3b5zCFSmVvU" frameborder="0" allowfullscreen></iframe>
  </div>
  <a class="close-reveal-modal">&#215;</a>
</div>
