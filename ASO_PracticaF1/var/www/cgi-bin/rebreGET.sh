#!/bin/bash
echo Content-Type: text/html
echo
echo -e "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
<html>
        <head>
              <title> Servidor Web d’ADS </title>
        </head>
<body>
"
echo -e "<h3>Script rebre GET</h3>"
#cal consultar la query string on hi ha les dades del formulari
dades=`echo $QUERY_STRING`
echo -e "les dades enviades: $dades <br/>"
echo -e "fixem-nos que conte tant el nom del parametre com el contingut.
<br />Caldra manipular la cadena per a obtenir el valor. <br />
Emprarem awk o sed:<br />"
v1=`echo $dades | awk -F= '{print $1}'`
Var1=$(echo "$QUERY_STRING" | sed -n 's/^.*var1=\([^&]*\).*$/\1/p')
Var2=$(echo "$QUERY_STRING" | sed -n 's/^.*var2=\([^&]*\).*$/\1/p')
v2=`echo $dades | awk -F= '{print $2}'`
v3=`echo $dades | awk -F= '{print $3}'`
v4=`echo $dades | awk -F= '{print $4}'`
echo -e "El Var1 es: $Var1 </br>"
echo -e "El Var2 es: $Var2 </br>"
echo -e "
</body>
</html>
"
