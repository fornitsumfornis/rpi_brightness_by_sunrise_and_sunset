#/bin/sh
echo "Using 'www.timeanddate.com/sun/', find the city closest to and where you live."  
read -p "Type name of the city:" city
citydashed="$(echo $city | sed -e 's/ /-/g')"
sed -i "s/yourcity/$citydashed/g" sunrise-sunset.sh
read -p "Input what you want your daytime brightness to be on a scale of 0 to 255:" day
sed -i "s/wake/$day/g" sunrise-sunset.sh
read -p "Input what you want your nighttime brightness to be on a scale of 0 to 255:" night
sed -i "s/dim/$night/g" sunrise-sunset.sh
echo "01 2   * * * root /bin/bash /usr/local/sbin/sunrise-sunset.sh"> picron.txt 
sudo cat picron.txt>>/etc/crontab 
sudo cp sunrise-sunset.sh /usr/local/sbin
rm picron.txt

#Un-setting Restrictions so that you will be allowed to change the backlight of your pi  
sudo chown root.pi /sys/class/backlight/rpi_backlight/brightness
sudo chmod 0644 /sys/class/backlight/rpi_backlgiht/brightness


