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

read pid

pid1=${pid::-1}
pidOK=$(echo "$pid1" | awk -F "=" '{print $1}')
sudo kill -9 $pidOK
echo "Se ha matado el proceso: $pidOK </br>"
echo -e "
</body>
</html>
"
