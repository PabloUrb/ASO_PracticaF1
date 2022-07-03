#!/bin/bash

ip4=$(/sbin/ip -o -4 addr list wlan0 | awk '{print $4}')
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

  salt=`sudo cat /etc/shadow | grep $userOK | awk -F "$" '{print $3}'`
  pass=`mkpasswd -m sha-512 $passwordOK -s $salt | awk -F "$" '{print $4}'`
  contraServer=`sudo cat /etc/shadow | grep $userOK | awk -F "$" '{print $4}' | awk -F ":" '{print $1}'`

  echo "El salt es: $salt </br>"
	echo "El pass es: $pass </br>"
  echo "El contraServer es: $contraServer </br>"

  if [ "$pass" == "$contraServer" ];
  then
    logger ASO: Entrada del login
    echo "</br>FUNCIONA</br>"
    echo "<p><button onclick='prepareCookie()' class='float-left submit-button' >Panel de Control</button></p>"
  else
    echo "</br><p>No se ha podido entrar</p>
    <p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>"
  fi

echo -e "
<script>
function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
  var expires = 'expires='+d.toUTCString();
  document.cookie = cname + '=' + cvalue + ';' + expires + ';path=/';
  location.href = 'http://172.20.10.6/panelControl.html';
}
function prepareCookie(){
  setCookie('loged','1',1);
}
document.getElementById(\"myButton9\").onclick = function () {
    location.href = \"http://172.20.10.6/\";}
</script>
</body>
</html>
"
