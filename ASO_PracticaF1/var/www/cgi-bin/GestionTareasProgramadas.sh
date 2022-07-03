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

echo "<script type=\"text/javascript\">
      if(getCookie('loged')=='1'){
        document.body.innerHTML += '<h1>Gestion de tareas programadas</h1>'

  document.body.innerHTML += '<form action=\'./crearCron.sh\' method=\'post\' ENCTYPE=\'text/plain\' style=\'display:inline-block\'><input type=\'text\' name=\'comando\' placeholder=\"Comando\" required><input type=\'text\' name=\'minutos\' placeholder=\"Minutos\" required><input type=\'text\' name=\'horas\' placeholder=\"Horas\" required><input type=\'text\' name=\'dia\' placeholder=\"Dia\" required><input type=\'text\' name=\'mes\' placeholder=\"Mes\" required><input type=\'text\' name=\'semana\' placeholder=\"Semana\" required><input type=\'submit\' value=\'Submit\'></form></br><form action=\'./eliminarCron.sh\' method=\'post\' ENCTYPE=\'text/plain\' style=\'display:inline-block\'><input type=\'text\' name=\'cronIndex\' placeholder=\"N de Cron\" required><input type=\'submit\' value=\'Submit\'></form>';
  document.body.innerHTML += '<h3>Lista de crones</h3>'
}else{document.body.innerHTML = '<p>NO SE HA LOGEADO CORRECTAMENTE</p><p><button id=\"myButton9\" class=\"float-left submit-button\" >Login</button></p>';
document.getElementById(\"myButton9\").onclick = function () {
    location.href = \"http://172.20.10.6/\";
};}</script>"


logger ASO: Entrada gestion tareas programadas
echo -e ''
echo ""

# /usr/bin/echo
echo -e ''
sudo crontab -u root -l | awk '{printf "%s. ",NR;print; printf "<br>"}'
echo -e "
</body>
</html>
"
