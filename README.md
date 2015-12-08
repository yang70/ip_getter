<img src="https://s3.amazonaws.com/mystufftoshare/IPUPDATE+-+Logo+(1).png" width="300px" />

# IP Update - A Ruby Script
by [Matthew Yang](http://matthewgyang.com)

## Description

I've recently been playing around with [SSH](https://en.wikipedia.org/wiki/Secure_Shell)'ing to an Ubuntu system on my network at home, however I have run into issues when my IP address is changed unexpectedly by my ISP.

[IP Update](https://github.com/yang70/ip_getter) is a Ruby script that will determine the public IP address of a system and saves it to a user specified file.  It works by using Ruby and Capybara/Poltergeist/PhantomJS to navigate to [http://ipaddress.com](http://ipaddress.com) and then scrapes the results. It uses this method since the system (and most home systems, I would assume) are behind a router, so just checking the local system for it's IP address would not return the outward-facing IP.

The data is then written as a [JSON](http://www.json.org/) file to a location specified by the user along with the current time.  I chose JSON in case I wanted to do something else with the data at a later time, however it could easily be saved as plain text or some other format of your choosing.  

I then designated a file within my [Dropbox](https://www.dropbox.com) folder so it is automatically updated to the cloud and accessible from wherever I am.

I then set up a [cron job](https://help.ubuntu.com/community/CronHowto) to run the script on a designated time frame.

## Installation

1. This script has the following dependancies that need to be loaded on the system:
	* [Ruby](https://www.ruby-lang.org/en/)
	* [Capybara](https://github.com/jnicklas/capybara)
	* [Poltergeist](https://github.com/teampoltergeist/poltergeist)
	* [PhantomJS](http://phantomjs.org/)

2. Copy the `get_ip` file from my GitHub repo ([yang70/ip_getter](https://github.com/yang70/ip_getter)) to a location in your `PATH`. I usually use `/usr/local/bin`.
3. Using your favorite text editor, open the `get_ip` file and edit the `<PATH TO SAVE LOCATION>` to the location you want to save the JSON file.  __NOTE:__ Make sure it's within your Dropbox folder if you would like to use that method of making the information available remotely.
4. Make it executable with the following command: `$ chmod +x /usr/local/bin/get_ip`
4. The script can then be run from the command line with `$ get_ip`
5. If you want to run the script at a regular interval, edit the current user's `crontab` with `$ crontab -e` or edit the `root` with `$ sudo crontab -e`
6. Here is an example of my crontab file which runs once every 2 hours:

```shell
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/bin:/usr/sbin:
0 */2 * * * /usr/local/bin/get_ip
```
__NOTE:__ You'll probably need to update the permissions on the `ip.json`

You can read more about setting up cron jobs on Ubuntu [here](https://help.ubuntu.com/community/CronHowto) or OSX [here](https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html).

That's it!  Open up a [GitHub issue](https://github.com/yang70/ip_getter/issues/new) or email [matt@matthewgyang.com](mailto:matt@matthewgyang.com) with any questions/comments/improvements!


## Future improvements

One modification I could make pretty easily is to allow the user to set the save location/file through an argument when the script is called, for example: `$ get_ip '~/Dropbox/my_ip/ip.json'`
