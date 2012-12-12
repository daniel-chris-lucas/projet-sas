
PROC SORT DATA = refer.encheres_actu;
by year_dv;
RUN;


ods html file="6.html" path="&racine.html/" nogtitle style=sketch;
title "Evolution adjuge"; 
proc gplot data= refer.encheres_actu;
plot adjuge*year_dv;
symbol i=join;
run;
ods html close;
