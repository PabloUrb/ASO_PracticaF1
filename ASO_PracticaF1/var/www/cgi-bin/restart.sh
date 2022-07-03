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
echo -e "<h1>restart</h1>"
sudo su
sudo reboot

echo -e "Se reinicia el servidor"
logger ASO: Reinicio del servidor
sudo /sbin/shutdown -r now
echo -e "
</body>
</html>
"
