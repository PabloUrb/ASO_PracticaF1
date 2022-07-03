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
echo -e '<h1>Gestion de tareas programadas</h1>'
read cronIndex

cronIndexOK=$(echo "${cronIndex::-1}" | awk -F "=" '{print $2}')

echo "El valor es: $cronIndexOK </br>"

sudo crontab -u root -l > /var/www/cgi-bin/mycron
if [ $? -ne 0 ]; then
    echo "Ha fallat crontab $?"
    exit
fi
sudo sed -i "${cronIndexOK}d" /var/www/cgi-bin/mycron
if [ $? -ne 0 ]; then
    echo "Ha fallat sed $?"
    exit
fi
echo 'sed "${cronIndexOK}d" mycron > mycron'

sudo crontab -u root /var/www/cgi-bin/mycron

echo -e "
</body>
</html>
"
