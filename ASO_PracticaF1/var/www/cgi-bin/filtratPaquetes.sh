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
echo -e "<h3>Filtrado de paquetes</h3>"
logger ASO: Entrada gestion paquetes
echo -e "<h4>Lista de paquetes</h4>"
echo "<script type=\"text/javascript\">
function getCookie(cname) {
  var name526 = cname + '=';
  var ca = document.cookie.split(';');
  var i=0;
  for(var E = 0; i < ca.length; E++) {
    var a1 = ca[E];
    while (a1.charAt(0) == ' ') {
      a1 = a1.substring(1);
    }
    if (a1.indexOf(name526) == 0) {
      return a1.substring(name526.length, a1.length);
    }
  }
  return \"\";
}
function checkCookie(cname) {
  if (getCookie(cname) !== undefined) {
    return true
  } else {
    return false
  }
  }

    if(getCookie('loged')=='1'){
document.body.innerHTML += '<form action=\"./gestionPaquete.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><select id=\"firewallOption\" name=\"firewallOption\"><option value=\"A\" selected>Append</option><option value=\"D\">Delete</option></select><select id=\"firewallOption2\" name=\"firewallOption2\"><option value=\"INPUT\" selected>Input</option><option value=\"OUTPUT\">Output</option><option value=\"FORWARD\">Forward</option></select><input type=\"text\" name=\"ipOrigen\" placeholder=\"Ip Origen\" required><input type=\"text\" placeholder=\"Ip Destino\" name=\"ipDestino\" required><input type=\"text\" name=\"protocolo\" placeholder=\"Protocolo\" required><input type=\"text\" name=\"puerto\" placeholder=\"Puerto\" required><select id=\"firewallOption3\" name=\"firewallOption3\"><option value=\"ACCEPT\" selected>Accept</option><option value=\"REJECT\">Reject</option><option value=\"DROP\">Drop</option></select><input type=\"submit\" value=\"Submit\"></form>'
      }
      else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
      document.getElementById(\"myButton9\").onclick = function () {
          location.href = \"http://172.20.10.6/\";
      };}</script>"

echo -e "<h4>Lista de filtros</h4>"
sudo iptables -S | sudo sed s/$/\<br\>/

echo "<script type=\"text/javascript\">if(getCookie('loged')=='1'){
document.body.innerHTML += \"\"}
else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
document.getElementById(\"myButton9\").onclick = function () {
    location.href = \"http://172.20.10.6/\";
};}</script>"

echo -e "
</body>
</html>
"
