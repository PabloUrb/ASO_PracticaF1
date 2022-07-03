#!/bin/bash
echo Content-Type: text/html
echo
echo -e "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN"
         "http://www.w3.org/TR/html4/strict.dtd">
<html>
        <head>
               <title> Servidor Web d'ADS </title>
         </head>
<body>
"
echo -e "<h3>Script rebre POST</h3>"
clear

unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage
logger ASO: Entrada en monitorizacion
while getopts iv name
do
        case $name in
          i)iopt=1;;
          v)vopt=1;;
          *)echo "Invalid arg";;
        esac
done

if [[ ! -z $iopt ]]
then
{
wd=$(pwd)
basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
su -c "cp $scriptname /usr/bin/monitor" root && echo "Congratulations! Script Installed, now run monitor Command" || echo "Installation failed"
}
fi

if [[ ! -z $vopt ]]
then
{
echo -e "tecmint_monitor version 0.1\nDesigned by Tecmint.com\nReleased Under Apache 2.0 License"
}
fi

if [[ $# -eq 0 ]]
then
{


# Define Variable tecreset
tecreset=$(tput sgr0)

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e "</br>Internet: $tecreset Connected" || echo -e "</br>Internet: $tecreset Disconnected"

# Check OS Type
os=$(uname -o)
echo -e "</br>Operating System Type :" $tecreset $os

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e "</br>OS Name :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e "</br>OS Version :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

# Check Architecture
architecture=$(uname -m)
echo -e "</br>Architecture :" $tecreset $architecture

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e "</br>Kernel Release :" $tecreset $kernelrelease

# Check hostname
echo -e "</br>Hostname :" $tecreset $HOSTNAME

# Check Internal IP
internalip=$(hostname -I)
echo -e "</br>Internal IP :" $tecreset $internalip

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e "</br>External IP : $tecreset "$externalip

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e "</br>Name Servers :" $tecreset $nameservers

# Check Logged In Users
who>/tmp/who
echo -e "</br>Logged In users :" $tecreset && cat /tmp/who

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e "</br>Ram Usages :" $tecreset
cat /tmp/ramcache | grep -v "Swap"
echo -e "</br>Swap Usages :" $tecreset
cat /tmp/ramcache | grep -v "Mem"
echo -e "</br> CPU Percentage: "
top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}'
# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e "</br>Disk Usages :" $tecreset
cat /tmp/diskusage

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e "</br>Load Average :" $tecreset $loadaverage

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "</br>System Uptime Days/(HH:MM) :" $tecreset $tecuptime

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage
}
fi
shift $(($OPTIND -1))
echo "</br></br>last connections: </br> "
#last= last | head -n 10
echo "</br>"
last1= last | head -1
echo "</br>"
last2= last | head  -2 | sed '2!d'
echo "</br>"
last3= last | head -3 | sed '3!d'
echo "</br>"
last4= last | head -4 | sed '4!d'
echo "</br>"
last5= last | head -5 | sed '5!d'
echo "</br>"
last6= last | head -6 | sed '6!d'
echo "</br>"
last7= last | head -7 | sed '7!d'
echo "</br>"
last8= last | head -8 | sed '8!d'
echo "</br>"
last9= last | head -9 | sed '9!d'
echo "</br>"
last10= last | head -10 | sed '10!d'


echo "</br></br>Peticiones a Apache: </br> "
apache=`sudo cat /var/log/apache2/access.log | sudo sed s/$/\<br\>/ | tail -10`
echo "$apache"




echo -e "
</body>
</html>
"
