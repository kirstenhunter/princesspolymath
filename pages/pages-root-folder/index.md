---
#
# Use the widgets beneath and the content will be
# inserted automagically in the webpage. To make
# this work, you have to use › layout: frontpage
#
layout: frontpage

callforaction:
  url: https://princesspolymath.com/assets/ReturnOfTheCLI.pdf
  text: Get the CLI presentation
  style: alert

widget1:
  title: "Fitbit: The Best Tracker for Hackers and Makers"
  url: "/fitbit"
  image: fitbit.png
  text: 'Musings on why the <a href="https://www.amazon.com/dp/B01K9S247E/ref=sr_ph_1_a_it?ie=UTF8&qid=1475551315&sr=sr-1&keywords=fitbit+charge+2">Fitbit system</a> is the best fitness tracker for folks who want to build their own integrations.'
widget2:
  title: "Hacking the Philips Hue Remote API"
  image: 'hue.png'
  text: 'Using your <a href="https://www.amazon.com/Philips-456210-Ambiance-Starter-Generation/dp/B014H2P4KW/ref=sr_1_2?ie=UTF8&qid=1475551498&sr=8-2&keywords=hue+starter+kit">Philips Hue lights</a> to give feedback for your day is a great use of this technology.  Find out how you can train these lights to give you props for progress!'
  url: '/hacking-a-philips-hue-remote-api-in-node.html'
widget3:
  title: "Becoming a Polyglot"
  url: "/becoming-a-polyglot"
  image: polyglot.png
  text: 'Learn how to translate between different programming languages with this simple set of API engines in 5 different interpreted languages.  Become a programming polyglot.'
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
