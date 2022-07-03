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
echo -e "<h1>apagar</h1>"
echo "Shutdown command sent <br>";
logger ASO: Apagado del servidor
sudo /sbin/shutdown -P now
echo -e "
</body>
</html>
"
