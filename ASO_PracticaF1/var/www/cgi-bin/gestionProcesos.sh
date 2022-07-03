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
}</script>"
#
echo "</br>"
logger ASO: Entrada en gestion de procesos
echo -e ""
i=0
ps aux |  while read line; do
  echo "</br>"
  echo "$line"
  pib=$(echo "$line" | awk '{print $2}')

  if [[ $i -gt 0 ]]
  then
echo "<form action=\"./pauseProcesos.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"number\" id=\"seconds\" name=\"seconds\" required><input type=\"submit\" name=\"$pib\" value=\"pause\"></form><form action=\"./elimProcesos.sh\" method=\"post\" ENCTYPE=\"text/plain\" style=\"display:inline-block\"><input type=\"submit\" name=\"$pib\" value=\"kill\"></form>"

  fi
    i=$((i+1));
    echo
  done
  echo "<script type=\"text/javascript\">
        if(getCookie('loged')=='1'){
    document.body.innerHTML += '';
  }else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
  document.getElementById(\"myButton9\").onclick = function () {
      location.href = \"http://172.20.10.6/\";
  };}</script>"
#matar al proceso que cuelga
#sudo kill -9 <process id>

echo -e "
</body>
</html>
"
