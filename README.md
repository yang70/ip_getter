# IP Update

by [Matthew Yang](http://matthewgyang.com)

## Description

IP Update is a Ruby script that will determine the public IP address of a system behind a router (also works if you're not behind a router).  I wrote this to get around my ISP not providing a static IP address and still wanting to be able to SSH to my home server.

It works by using Capybara to navigate to [Bing](http://bing.com), runs a search on the string "what is my ip" and scrapes the results.  That data is then written to a file in my [Dropbox](https://www.dropbox.com) folder which is then automatically synced.  I can then access that file from wherever I am and see if my IP has changed.

This script is then run hourly as a [cron job](https://help.ubuntu.com/community/CronHowto).

## Installation

