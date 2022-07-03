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
read parametre

parametre1=${parametre::-1}
parametreOK=$(echo "$parametre1" | awk -F "=" '{print $1}')

echo "el valor: $parametreOK </br>"
#screen -r -S musica
if [ $parametreOK =  "start" ]; then
  sudo su -c "screen -d -S musica -m sudo mpg123 -t --list /home/pi/playlist/*" -s /bin/sh pi
  sudo su -c "screen -list | sed s/$/\<br\>/ " -s /bin/sh pi
fi

if [ $parametreOK =  "stop" ]; then
  sudo su -c "screen -S musica -X quit" -s /bin/sh pi
  sudo su -c "screen -list | sed s/$/\<br\>/ " -s /bin/sh pi
fi

if [ $parametreOK =  "play_pause" ]; then
  sudo su -c "screen -S musica -p 0 -X stuff 's'" -s /bin/sh pi
fi

if [ $parametreOK =  "Avancar" ]; then
  sudo su -c "screen -S musica -p 0 -X stuff 'f'" -s /bin/sh pi
fi

if [ $parametreOK =  "Retrocedir" ]; then
  sudo su -c "screen -S musica -p 0 -X stuff 'd'" -s /bin/sh pi
fi

if [ $parametreOK =  "Shuffle" ]; then
  sudo su -c "screen -S musica -X quit" -s /bin/sh pi
  sudo su -c "screen -d -S musica -m sudo mpg123 -t --random --list /home/pi/playlist/*" -s /bin/sh pi
fi

if [[ $parametreOK == *"Replay"* ]]; then
  echo "$parametreOK"
  IFS='-' read -ra musicId <<< "$parametreOK"
  path=`find /home/pi/playlist | tail -n +2 | sed "${musicId[1]}q;d"`
  echo ${musicId[1]}
  echo "$path"
  sudo su -c "screen -S musica -X quit" -s /bin/sh pi
  sudo su -c "screen -d -S musica -m sudo mpg123 -t --loop -1 $path" -s /bin/sh pi

fi


echo -e "
</body>
</html>
"
