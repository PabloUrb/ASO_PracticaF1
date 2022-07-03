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
logger ASO: Entrada gestion tareas programadas
echo -e '<h1>Gestion de tareas programadas</h1>'
echo "<form action='./crearCron.sh' method='post' ENCTYPE='text/plain' style='display:inline-block'>
<input type='text' name='comando' placeholder=\"Comando\" required>
<input type='text' name='minutos' placeholder=\"Minutos\" required>
<input type='text' name='horas' placeholder=\"Horas\" required>
<input type='text' name='dia' placeholder=\"Dia\" required>
<input type='text' name='mes' placeholder=\"Mes\" required>
<input type='text' name='semana' placeholder=\"Semana\" required>
<input type='submit' value='Submit'>
</form>
</br>
<form action='./eliminarCron.sh' method='post' ENCTYPE='text/plain' style='display:inline-block'>
<input type='text' name='cronIndex' placeholder=\"N de Cron\" required>
<input type='submit' value='Submit'>
</form>"

# /usr/bin/echo
echo -e '<h3>Lista de crones</h3>'
sudo crontab -u root -l | awk '{printf "%s. ",NR;print; printf "<br>"}'
echo -e "
</body>
</html>
"
