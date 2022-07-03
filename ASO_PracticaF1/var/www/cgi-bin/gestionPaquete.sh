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

read firewallOption
read firewallOption2

read ipOrigen
read ipDestino
read protocolo
read puerto
read firewallOption3

firewallOption1=${firewallOption::-1}
firewallOptionOK=$(echo "$firewallOption1" | awk -F "=" '{print $2}')
firewallOption21=${firewallOption2::-1}
firewallOption2OK=$(echo "$firewallOption21" | awk -F "=" '{print $2}')
firewallOption31=${firewallOption3::-1}
firewallOption3OK=$(echo "$firewallOption31" | awk -F "=" '{print $2}')
ipOrigen1=${ipOrigen::-1}
ipOrigenOK=$(echo "$ipOrigen1" | awk -F "=" '{print $2}')
ipDestino1=${ipDestino::-1}
ipDestinoOK=$(echo "$ipDestino1" | awk -F "=" '{print $2}')
protocolo1=${protocolo::-1}
protocoloOK=$(echo "$protocolo1" | awk -F "=" '{print $2}')
puerto1=${puerto::-1}
puertoOK=$(echo "$puerto1" | awk -F "=" '{print $2}')

echo "El valor es: $firewallOptionOK </br>"
echo "El valor es: $firewallOption2OK </br>"
echo "El valor es: $firewallOption3OK </br>"
echo "El valor es: $ipOrigenOK </br>"
echo "El valor es: $ipDestinoOK </br>"
echo "El valor es: $protocoloOK </br>"
echo "El valor es: $puertoOK </br>"

comanda="sudo iptables -$firewallOptionOK $firewallOption2OK"

if [  -n "$ipOrigenOK" ]
then
  comanda+=" -s $ipOrigenOK"
fi

if [  -n "$ipDestinoOK" ]
then
  comanda+=" -d $ipDestinoOK"
fi

if [  -n "$protocoloOK" ]
then
  comanda+=" -p $protocoloOK"
  if [  -n "$puertoOK" ]
  then
    comanda+=" --dport $puertoOK"
  fi
fi
comanda+=" -j $firewallOption3OK"
echo "$comanda"
eval "$comanda"
echo -e "
</body>
</html>
"
