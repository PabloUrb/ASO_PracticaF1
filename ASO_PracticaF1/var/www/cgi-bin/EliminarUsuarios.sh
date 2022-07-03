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
echo -e "<h1>Eliminar usuarios</h1>"
read username
user1=${username::-1}
userOK=$(echo "$user1" | awk -F "=" '{print $2}')

echo "El usuario es: $userOK </br>"

sudo deluser --remove-home $userOK | sudo sed s/$/\<br\>/
echo -e "
</body>
</html>
"
