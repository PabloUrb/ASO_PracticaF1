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
echo -e '<h1>Funcionalidades Musicales</h1>'
var=`find /home/pi/playlist | tail -n +2  | awk '{printf "%s. ",NR;print; printf "<form action=\"./musicControls.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"submit\" name=\"Replay-%s\" value=\"Replay\"></form></br>",NR }'`
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

  function checkLista() {
    var box = document.getElementById('lista');
    box.style.display = 'none';
  }

    if(getCookie('loged')=='1'){
document.body.innerHTML += '<form action=\"./musicControls.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"submit\" name=\"start\" value=\"start\"><input type=\"submit\" name=\"stop\" value=\"stop\"><input type=\"submit\" name=\"play_pause\" value=\"Play/Pause\"></form></br><form action=\"./musicControls.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"submit\" name=\"Avancar\" value=\"Avancar\"><input type=\"submit\" name=\"Retrocedir\" value=\"Retrocedir\"><input type=\"submit\" name=\"Llista\" value=\"Llista de reproduccio\"><input type=\"submit\" name=\"Shuffle\" value=\"Shuffle\"></form></br>'
document.getElementById(\"element\").style.display = \"none\";
}else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
document.getElementById(\"myButton9\").onclick = function () {
  location.href = \"http://172.20.10.6/\";
};}</script>"
echo "<a id=\"lista\">$var</a>"
echo -e "
</body>
</html>
"
