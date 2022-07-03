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
logger ASO: Entrada gestion de usuarios
echo -e "<h1>Gestion de Usuarios</h1>
<p>Anadir Usuario</p>
<script type=\"text/javascript\">
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
document.body.innerHTML += '<form action=\"./CreacionUsuarios.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"text\" name=\"username\" required><input type=\"password\" name=\"password\" required><input type=\"submit\" value=\"Submit\"></form></br><p>Eliminar Usuario<p><form action=\"./EliminarUsuarios.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"text\" name=\"username\" required><input type=\"submit\"value=\"Submit\"></form>'}
else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
document.getElementById(\"myButton9\").onclick = function () {
    location.href = \"http://172.20.10.6/\";
};}</script>"
echo -e "
</body>
</html>
"
