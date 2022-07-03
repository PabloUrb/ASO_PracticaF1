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
echo -e '<h1>Gestion de tareas programadas</h1>'
read comando
read minutos
read horas
read dia
read mes
read semana

comandoOK=$(echo "${comando::-1}" | awk -F "=" '{print $2}')
minutosOK=$(echo "${minutos::-1}" | awk -F "=" '{print $2}')
horasOK=$(echo "${horas::-1}" | awk -F "=" '{print $2}')
diaOK=$(echo "${dia::-1}" | awk -F "=" '{print $2}')
mesOK=$(echo "${mes::-1}" | awk -F "=" '{print $2}')
semanaOK=$(echo "${semana::-1}" | awk -F "=" '{print $2}')

echo "El valor es: $comandoOK </br>"
echo "El valor es: $minutosOK </br>"
echo "El valor es: $horasOK </br>"
echo "El valor es: $diaOK </br>"
echo "El valor es: $mesOK </br>"
echo "El valor es: $semanaOK </br>"

#write out current crontab
#/home/pi/crontest
sudo crontab -u root -l > mycron
#echo new cron into cron file
sudo echo "$minutosOK $horasOK $diaOK $mesOK $semanaOK $comandoOK" >> ./mycron
sudo echo "$minutosOK $horasOK $diaOK $mesOK $semanaOK $comandoOK"
#install new cron file
sudo crontab -u root mycron

echo -e "
</body>
</html>
"
