#!/bin/bash
echo Content-Type: text/html
echo -e "<!DOCTYPE html PUBLIC -//W3C//DTD HTML 4.01 Strict//EN http://www.w3.org/TR/html4/strict.dtd>
<html>
<head>
<title> Pàgina Web d’ADS </title>
</head>
<body>
"
#en aquest instant emprarem els scripts bash
echo -e "<h3>Script d’exemple</h3>"
who -u > temporal
while read var
do
echo -e "$var <br/>"
done < "temporal"
echo -e "
</body>
</html>
"

