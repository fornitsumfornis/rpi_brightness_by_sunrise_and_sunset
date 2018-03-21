#!/bin/bash
#Pulling information from website www.timeanddate.com, just place the website 
#for your location where "<website>" is

lynx --dump <website> > daylight.txt
cat daylight.txt | sed -n -e 's/^.*Sunrise Today: //p'> sunrise.txt
cat daylight.txt | sed -n -e 's/^.*Sunset Today: //p' > sunset.txt

#sunrise
echo -n "0" >rise.txt
cat sunrise.txt | cut -c1,3,4 -n >>rise.txt
cat rise.txt | sed 's/.\{2\}/& /g'>day.txt
sed -i 's/\([a-zA-Z0-9][a-zA-Z0-9]*\) \([a-zA-Z0-9][a-zA-Z0-9]*\)/\2 \1/' day.txt
sudo chmod 777 day.txt
echo -n "$(cat day.txt)" >day.txt 

#Input the daytime brightness below
echo -n " * * * root echo <daytime brightness> > /sys/class/backlight/rpi_backlight/brightness" >>day.txt
#deleting all previous entries (lines 20 through 20), adjust to your crontab accordingly
sed -i '10,20d' /etc/crontab
sed ' ' day.txt >>/etc/crontab

#sunset

cat sunset.txt | cut -c1,3,4 -n > set.txt
declare -i num
declare -i night
num=( $(<set.txt) )
declare -i base=$((1200))
sum=$((num + base))
echo $sum>night.txt 
cat night.txt | sed 's/.\{2\}/& /g'>night2.txt
sed -i 's/\([a-zA-Z0-9][a-zA-Z0-9]*\) \([a-zA-Z0-9][a-zA-Z0-9]*\)/\2 \1/' night2.txt
sudo chmod 777 night2.txt
echo -n "$(cat night2.txt)" >night2.txt

#Input the Nighttime Brightness Below
echo -e " * * * root echo <nighttime brightness> > /sys/class/backlight/rpi_backlight/brightness\n\n" >>night2.txt
sed 'i\ ' night2.txt >> /etc/crontab

#deleting
sudo rm /usr/local/sbin/sunrise.txt /usr/local/sbin/sunset.txt /usr/local/sbin/rise.txt /usr/local/sbin/day.txt /usr/local/sbin/set.txt /usr/local/sbin/night.txt /usr/local/sbin/night2.txt /usr/local/sbin/daylight.txt 
