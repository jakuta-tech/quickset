## quickset.sh was created out of the need for a consolidated suite of tools dedicated to PenTesting. ##

There are a lot (and I mean a LOT) of scripts in the wild that offer various methodologies on the setup for a proper PenTest.  What sets quickset apart from the rest you might ask?  Total customization of a hack within the script itself.  No more having to edit a script prior to use for choosing what IP address and port to listen on, which file to save to, where to save, etc..  To speed the process along even further, all “defaultable” settings that were able to be implemented have been pre-selected for the user; of course, with a couple keystroke these settings are rapidly changed.  Here is a sampling of the many aspects that it offers:

  * Stable and flexible Soft Access Points to meet a variety of needs
  * Grab WPA Handshakes using a variety of methods both AP and Client style
  * A small batch of “fast” attack tools
  * Crack open WEP like an egg

Development of this script took place over the summer of 2011 during my deployment to Afghanistan.  I’d like to take a minute to thank the “community” from [Back|Track Forums](http://backtrack-linux.org/forums) for all the support and solidarity they have shown me; quickset would not be what it is without them.

Before you decide to use the script, I ask that you actually READ the comments within it, and try to understand how it does what it does; otherwise you’re just another $cr!pt K!dd!e in my book. If you have taken the time to honestly read through and troubleshoot any problems with the script on your own **_-or-_** if you would like to send Kudos, Comments, Ideas, etc.. you can reach me [here](mailto:will@configitnow.com). I am always and forever willing to change things up and add new features to quickset or remove things that make no sense.

Grab yourself a copy via ```
svn checkout http://quickset.googlecode.com/svn/trunk quickset```