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
echo -e "<h3>Login</h3>"


	read username
	read password

  user1=${username::-1}
  userOK=$(echo "$user1" | cut -c 10-)
  password1=${password::-1}
  passwordOK=$(echo "$password1" | cut -c 10-)

  echo "El valor1 es: $user1 </br>"
  echo "El valor2 es: $password1 </br>"


  echo "El valor es: $userOK </br>"
	echo "El valor es: $passwordOK </br>"

  sudo useradd -m $userOK
  printf "${passwordOK}\\n${passwordOK}\\n" | sudo passwd $userOK

  if [ $? -ne 0 ]; then
    echo "Error al insertar usuario"
    exit
  fi


echo -e "
</body>
</html>
"
