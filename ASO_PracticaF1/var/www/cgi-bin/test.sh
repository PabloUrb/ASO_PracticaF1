#!/bin/bash

echo Content-Type: text/html
echo
echo -e "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN"
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <meta http-equiv='X-UA-Compatible' content='ie=edge'>
  <title>Monitor de servicios seleccionados del sistema</title>
  <link rel='stylesheet' href='estilos.css'>
</head>
<body>
<h1>Gestio de logs: Listado de logs</h1>
"
logger ASO: Entrada revisar logs
logs=`sudo cat /var/log/messages | grep ASO:`

for OUTPUT in $(sudo cat /var/log/messages | grep ASO:)
do
  if [ "$OUTPUT" == "Jun" ] || [ "$OUTPUT" == "Jul" ]; then
    echo -e "<br>"
  fi
    echo -e "<script type=\"text/javascript\">
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
    document.body.innerHTML += '$OUTPUT'}
  else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
    document.getElementById(\"myButton9\").onclick = function () {
        location.href = \"http://172.20.10.6/\";};}</script>"

done
echo -e "
</body>
</html>"
