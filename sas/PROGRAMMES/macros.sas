%macro faire_somme(variable,table_a_creer,variable2);
proc sql noprint;
select sum(&variable) into:total
from refer.Encheres_actu;
insert into &table_a_creer
values (&total,&variable2);
quit;
%put variable_tot=&total.;
%mend;
