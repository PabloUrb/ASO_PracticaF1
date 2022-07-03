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
read parametrePOST
read parametrePOST2
#llegira parametrePOST=<valor>
echo -e "Les dades enviades: $parametrePOST <br/>"
echo -e "Les dades enviades: $parametrePOST2 <br/>"
echo -e "fixem-nos que te tant el nom del parametre com el contingut. <br />
Caldra manipular la cadena per a obtenir el valor. <br />
Emprarem awk o sed:<br />"
v2=`echo $parametrePOST | awk -F= '{print $2}'`
v3=`echo $parametrePOST2 | awk -F= '{print $2}'`
echo -e "El valor es: $v2 </br>"
echo -e "El valor es: $v3"
echo -e "
</body>
</html>
"
