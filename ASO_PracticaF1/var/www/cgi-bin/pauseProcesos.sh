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
read seconds
read pid

pidOK=$(echo "$pid" | awk -F "=" '{print $1}')
secondsOK=$(echo "$seconds" | awk -F "=" '{print $2}' )
echo "El PID es: $pidOK </br>"
echo "El Seconds es: $secondsOK </br>"

sudo kill -STOP $pidOK
sleep ${secondsOK::-1}s
sudo kill -CONT $pidOK

echo "Y se ha pausado y reiniciado"
echo -e "
</body>
</html>
"
