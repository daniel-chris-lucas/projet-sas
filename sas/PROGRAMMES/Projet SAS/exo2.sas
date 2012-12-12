LIBNAME donnees "H:\Mes documents\Projet SAS\donnees";

data dates;
set donnees.police(keep=NOPOL DATNAI);
date_sans_fmt = DATNAI;
run;

/*Calculer l'âge des clients*/
DATA work.age;
	SET donnees.police (keep=NOPOL DATNAI);
	ATTRIB age
		LABEL = 'Age'
		FORMAT = 3.
		LENGTH = 3;
	age = int((TODAY() - DATNAI)/365.25);

RUN;

PROC freq DATA = work.age;
	table age;
RUN;

/*CORRECTION*/
data calcul_age;
set donnees.police (keep = nopol datnai);

attrib age length=8 label="Age du client";
attrib age_precis length=8 label="Age précis du client";

age = year(today())-year(datnai);

age_precis = int((today() - datnai)/365.25);

age_annee= intck("YEAR",datnai,today());
age_mois= intck("MONTH",datnai,today());
age_jours= intck("DAY",datnai,today());

run;


/* Sélectionner les clients nés le 03/05/1946 */
DATA work.client_3Mai1946;
	SET work.age;
	WHERE DATNAI = "03MAY1946"d;
RUN;


/*
Calculer l'age en fonction de la table Exo_date
Attention: format date en caractère ici!!
*/
DATA work.age_Exo;
	SET donnees.Exo_date;
	ATTRIB age
		LABEL = 'Age du client'
		FORMAT = 3.
		LENGTH = 3;
	age = int( ( YEAR(TODAY()) - SUBSTR(madate,7,4) ) );
RUN;

/* SUBSTR: on prend 4 caractères à partir du 7ème */

/* ou avec la date entière ^^ */
DATA work.age_Exo;
	SET donnees.Exo_date;
	ATTRIB age
		LABEL = 'Age du client'
		FORMAT = 3.
		LENGTH = 3;
	age = int( ( TODAY() - MDY( SUBSTR(madate,4,2), SUBSTR(madate,1,2), SUBSTR(madate,7,4) ) )/365 );
RUN;

/* correction */
data manip_date_car;
set donnees.exo_date;
attrib age length=8;

format vrai_date vrai_date2 ddmmyy10.;

vrai_date= mdy(substr(madate,4,2),substr(madate,1,2),substr(madate,7,4));

vrai_date2= input(madate,ddmmyy10.);

age = year(today())- substr(madate,7,4);
run;


/* A partir de sinistre, créer une table avec la liste des clients et la somme des montants des sinistres */
PROC MEANS DATA = donnees.sinistre
	SUM;
	VAR MTSI;
	CLASS NOPOL;
	
RUN;

/* SQL */
proc sql;
create table montants_sin as
select nopol, sum(MTSI) as somme_montants
from donnees.sinistre
group by nopol;
quit;

/* avec output! */
proc means data=donnees.sinistre noprint;
var MTSI;
class nopol;
output out=montants_sin2(drop=_type_ _freq_) sum=somme_montants;
run;

/* noprint: pour ne plus avoir la sortie console */


/*
A partir de Police, créer une table avec la liste des clients du 78 (code postal)
RQ: donc garder le code postal
*/

DATA work.clients78;
	SET donnees.police (KEEP = nopol ADRCP);
	WHERE ADRCP LIKE '78%';
RUN;

/*autre écriture*/
DATA work.clients78;
	SET donnees.police (KEEP = nopol ADRCP where=( ADRCP LIKE '78%'));
RUN;


DATA work.clients78;
	SET donnees.police (KEEP = nopol ADRCP where=( substr(ADRCP,1,2) ='78'));
RUN;

/* Pour chaque client du 78, récupérer les montants sinistres */
PROC SORT DATA = donnees.police;
	by nopol;
RUN;
PROC SORT DATA = donnees.sinistre;
	by nopol;
RUN;

DATA work.clients78_montant_sinistre;
	
	MERGE donnees.police ( KEEP = nopol ADRCP where=( substr(ADRCP,1,2) ='78') IN = dans_police )
		  work.montants_sin2 ( IN = dans_sinistre ); /*prendre les sommes des sinistres! mieux sinon on aura plusieurs lignes pour un clients s'il a eu plusieurs sinistres*/
	by nopol;
	IF dans_police=1 THEN output;
RUN;

/* Exemple de jointures */
data jointure;
merge clients78(in=a) montants_sin2(in=b);
by nopol;
*if a=1 then output; /*Jointure à gauche*/
*if b=1 then output; /*Jointure à droite*/
*if a and b;/*Inner Join*/
*if a or b;/*full Join*/

if a and not b; /*les clients du 78 qui n'ont pas eu de sinistre*/
run;


/* MACROS */

%let mvsex = 'M';
*%put &mvsex;


%macro mpsex(mvsex);
data sortie;
set sashelp.class;
if sex=&mvsex;
run;


proc freq data=sashelp.class(where=(sex=&mvsex));
table age;
run;


proc means data=sashelp.class(where=(sex=&mvsex));
var age;
run;
%mend mpsex;

%mpsex('F');
%mpsex('M');
