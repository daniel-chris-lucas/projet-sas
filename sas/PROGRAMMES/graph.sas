/* création d'une table par marque de voiture DESCRIPTION*/

%macro M_table_marque_desc(marque=) ;
data WORK.&marque._desc ;
set REFER.Description_auto2 ;
where marque="&marque";
run;
%mend M_table_marque_desc ;

%M_table_marque_desc(marque=Aston_Martin);
%M_table_marque_desc(marque=De_Tomaso);
%M_table_marque_desc(marque=Dodge);
%M_table_marque_desc(marque=Ferrari);
%M_table_marque_desc(marque=Jaguar);
%M_table_marque_desc(marque=Lamborghini);
%M_table_marque_desc(marque=Maserati);
%M_table_marque_desc(marque=Mercedes);
%M_table_marque_desc(marque=Porsche);
%M_table_marque_desc(marque=Venturi);

/* création d'une table par marque de voiture ENCHERES*/

%macro M_table_marque_ench(marque=) ;
data WORK.&marque._ench ;
set REFER.Encheres_actu ;
where marque="&marque";
run;
%mend M_table_marque_ench ;

%M_table_marque_ench(marque=Aston_Martin);
%M_table_marque_ench(marque=De_Tomaso);
%M_table_marque_ench(marque=Dodge);
%M_table_marque_ench(marque=Ferrari);
%M_table_marque_ench(marque=Jaguar);
%M_table_marque_ench(marque=Lamborghini);
%M_table_marque_ench(marque=Maserati);
%M_table_marque_ench(marque=Mercedes);
%M_table_marque_ench(marque=Porsche);
%M_table_marque_ench(marque=Venturi);


/* Graphiques */

ODS LISTING CLOSE;	/*il n'affichera pas la sortie dans le listing!*/
ODS HTML			/*on ouvre donc un autre endroit de sortie dont il faudra préciser où elle est*/
path = "&RACINE.html/"
file = "nb_mod_per_marque_vbar.htm"
style=astronomy;

TITLE;
TITLE1 "Nombres de modèles par marques possédés" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

proc gchart data= REFER.Description_auto2;
axis1 label=("Nombre d'exemplaires");
axis2 label=("Marques");
vbar3d Marque / discrete
sumvar= nb_exemplaires 
type=sum
;
run;

ods html close;
ods listing;


/*sert à rien!! */

%Macro carrosserie_marque(fichier=);

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "&fichier._carrosserie.htm"
style=astronomy;

proc gchart data= WORK.&fichier._desc;
vbar Marque / discrete subgroup=Carrosserie sumvar=nb_exemplaires type=sum;
run;

ods html close;
ods listing;

%Mend carrosserie_marque;

%carrosserie_marque(fichier=Aston_Martin);
%carrosserie_marque(fichier=De_Tomaso);
%carrosserie_marque(fichier=Dodge);
%carrosserie_marque(fichier=Ferrari);
%carrosserie_marque(fichier=Jaguar);
%carrosserie_marque(fichier=Lamborghini);
%carrosserie_marque(fichier=Maserati);
%carrosserie_marque(fichier=Mercedes);
%carrosserie_marque(fichier=Porsche);
%carrosserie_marque(fichier=Venturi);

/* Nombres de modèles par marques possédées VBAR */
ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "nb_mod_per_marque_pie.htm"
style=astronomy;

TITLE;
TITLE1 "Nombres de modèles par marques possédés" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

proc gchart data= REFER.Description_auto2;
pie Marque / discrete noheader
sumvar=nb_exemplaires 
type=sum
detail_percent=best
percent=arrow

;run;

ods html close;
ods listing;


/* Nombres de modèles par marques possédées PIE */

PROC SORT DATA = REFER.Description_auto2;
	by Marque Modele;
RUN;

proc sql;
create table nbModele_marque as
select DISTINCT Marque, Modele, count(modele) as nbModeleM
from REFER.Description_auto2
group by Marque, Modele;
quit;

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "nb_mod_per_marque_pie.htm"
style=astronomy;

TITLE;
TITLE1 "Nombres de modèles par marques possédés" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

proc gchart data= nbModele_marque;
pie Marque/ discrete
sumvar= nbModeleM
type=sum
detail_percent=best
percent=arrow

;
run;

ods html close;
ods listing;


/* nombre de modèle par marque DESCRIPTION VBAR3D */
PROC SORT DATA = REFER.Description_auto2;
	by Marque Modele;
RUN;

proc sql;
create table nbModele_marque as
select DISTINCT Marque, Modele, count(modele) as nbModeleM
from REFER.Description_auto2
group by Marque, Modele;
quit;

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "nbModele_desc.htm"
style=astronomy;

TITLE;
TITLE1 "Nombres de modèles par marques" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

title; /*remettre le titre vide pour ne pas récupérer le précédent*/
title "Nombre de modèles possédés par marques";

proc gchart data= nbModele_marque;
vbar3d Marque / discrete
sumvar= nbModeleM
type=sum
;
run;

ods html close;
ods listing;

/* nombre de modèle par marque ENCHERES VBAR */

PROC SORT DATA = REFER.Encheres_actu;
	by Marque Modele;
RUN;

proc sql;
create table nbModele_marque_Encheres as
select DISTINCT Marque, Modele, count(modele) as nbModeleME
from REFER.Encheres_actu
group by Marque, Modele;
quit;

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "nbModele_ench.htm"
style=astronomy;

TITLE;
TITLE1 "Nombres de modèles par marques" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

title; /*remettre le titre vide pour ne pas récupérer le précédent*/
title "Nombre de modèles possédés par marques";

proc gchart data= nbModele_marque_Encheres;
vbar3d Marque / discrete
sumvar= nbModeleME
type=sum
/*detail_percent=best
percent=arrow*/
;
run;

ods html close;
ods listing;


/* Moyenne des ventes par année */

/* Utilisation d'une proc format pour générer un code couleur */

PROC FORMAT;
/* Affection d'un format pour changer les couleurs de fonds et les polices */

	value fore	low-100 = 'black'
				100<-high = 'white'
				;						/* low et hight <=> infini! la plus petite ou la plus grande valeur trouvée */
	value back	low-50 = 'gray'
				50<-<100 = 'yellow'
				100-high = 'green'
				;


RUN;


ods listing close;
ods html path="&RACINE.html/"
		 body='html10.htm';

TITLE;
TITLE1 "Moyenne des ventes par année" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

title; /*remettre le titre vide pour ne pas récupérer le précédent*/
title "Moyennes des ventes par année";

proc tabulate data=REFER.Encheres_actu /*format=comma6.  format du contenu du tableau */
			/* Affichage du fond de cellule en jaune pour les stats */
		style={background=yellow font_weight=bold} ;
	 /*where destination in ('CDG' 'LHR'); */

	title'<font face="Time" color="green" weight="bold" size=6>
			Tableau d information sur les destinations </font>' ;  /* applicable que dans une page html vu les balises! */

table (marque="Marques"),
		(Year_dv adjuge) 

		/* Affectation du code couleur au contenu des stats */
		*{style={Background=back.
				Foreground=fore.}}		/*on récupère nos deux premier format avec le nom du format suivis d'un point!!   QUESTION DE PARTIEL /!\*/
		,
		min max median mean				/* on pourrait encore appliquer un certain nombre de paramètre à chaque statistique */
		/

		 /* Nouveau affichage d'un titre dans le coin gauche de la tabulate */
	box ={label='Information sur les ventes par année'
		  style={Background=purple
		  		 Foreground=White
				 font_face=times
				 font_weight=bold
				 }
		  }
	;

		 /* Surcharge pour modifier l'affichage des variables de classe */
	class marque /
			style={Background=green
		  		 Foreground=very dark blue
				 font_face=times
				 font_weight=bold
				 }
	;
run;

ods html close;
ods listing;


/**/

proc sort data = REFER.Encheres_actu;
by year_dv;
RUN;

PROC SQL;
create table date_vente as
SELECT DISTINCT year_dv as annee
FROM REFER.Encheres_actu;
quit;



%faire_somme(adjuge,evolution_par_an,"annee");
/*%faire_somme(ETCTOT07,evolution_par_an,"2007");
%faire_somme(ETCTOT08,evolution_par_an,"2008");
%faire_somme(ETCTOT09,evolution_par_an,"2009");*/

ods html file="6.html" path="&racine.html/" nogtitle style=sketch;
title "Evolution du nombre d'établissements créés"; 
proc gplot data=evolution_par_an;
plot adjuge*year_dv;
symbol i=join;
run;
ods html close;


/*************************************************************************/

proc sql;
create table nbModele_marque_Encheres as
select DISTINCT Marque, modele, count(modele) as nbMarqueE
from REFER.Encheres_actu
group by Marque;
quit;

PROC SORT DATA= nbModele_marque_Encheres
	out=work.Encheres_actu_t;

by marque modele;

RUN;

DATA REFER.Encheres_actu;
	SET REFER.Encheres2;
	ATTRIB Year_dv 
		Label = "Annee de vente"
		LENGTH = 4
		FORMAT = 4.
		
			Month_dv
		Label = "Mois de vente"
		LENGTH = $2
		FORMAT = $2.

			Day_dv
		Label = "Jour de vente"
		LENGTH = $2
		FORMAT = $2.
		
	;
	Year_dv = SUBSTR(Date_Vente,1,4);
	Month_dv = SUBSTR(Date_Vente,5,2);
	Day_dv = SUBSTR(Date_Vente,7,2);	
RUN;


%macro M_exohref(varpie=,vsubgr=) ;

data work.nbModele_marque_Encheres_S1 (drop=i) ;
retain lien ;
set work.nbModele_marque_Encheres  ;
by &varpie ;
length lien $100 ;
	if first.&varpie then do ;
	    i + 1 ;
	    lien = 'href='!!quote(compress("fic"!!i!!".htm")) ;
	end;
run;

ods listing close ;
ods html body = "&racine.html/fic1.htm" newfile=bygroup style=astronomy;
goptions device = activex  ;
title1 "Quantités vendues par &varpie. et par &vsubgr. " ;

Legend1
	FRAME
	;
Axis1
	STYLE=1
	WIDTH=1
	MINOR=NONE
;
Axis2
	STYLE=1
	WIDTH=1
;

PROC GCHART DATA=work.nbModele_marque_Encheres_S1
;
	VBAR3D 
	 &varpie.
 /
	SUMVAR=nbMMarqueE
	SHAPE=CYLINDER
    TYPE=SUM
	discrete
	subgroup=&vsubgr.
	LEGEND=LEGEND1
	COUTLINE=BLACK
	RAXIS=AXIS1
	MAXIS=AXIS2
;
by &varpie. ;
RUN; QUIT;

TITLE; FOOTNOTE;

ods html body = "&racine.html/fic0.htm" style=astronomy;
goptions device = activex  ;
title1 "Marques" ;

proc gchart data=work.nbModele_marque_Encheres_S1 ;
pie3d &varpie.
  /
sumvar = nbMarqueE
html = lien
type=sum
PERCENT=INSIDE
OTHER=0
;
run;
quit;
TITLE; FOOTNOTE;
GOPTIONS reset=all ;
ods html close;
ods listing ;

%mend M_exohref  ;

%M_exohref(varpie=Marque,vsubgr=Modele)


/*************************************************************************/

proc sql;
create table nbModele_marque_Modeles as
select DISTINCT Marque, modele, count(modele) as nbMarqueE
from REFER.Description_auto2
group by Marque;
quit;

PROC SORT DATA= nbModele_marque_Encheres
	out=work.Description_auto2_t;

by marque modele;

RUN;


%macro M_exohref(varpie=,vsubgr=) ;

data work.nbModele_marque_Modeles_S1 (drop=i) ;
retain lien ;
set work.nbModele_marque_Modeles  ;
by &varpie ;
length lien $100 ;
	if first.&varpie then do ;
	    i + 1 ;
	    lien = 'href='!!quote(compress("fic"!!i!!".htm")) ;
	end;
run;

ods listing close ;
ods html body = "&racine.html/fic1.htm" newfile=bygroup style=astronomy;
goptions device = activex  ;
title1 "Quantités disponibles par &varpie. et par &vsubgr. " ;

Legend1
	FRAME
	;
Axis1
	STYLE=1
	WIDTH=1
	MINOR=NONE
;
Axis2
	STYLE=1
	WIDTH=1
;

PROC GCHART DATA=work.nbModele_marque_Modeles_S1
;
	VBAR3D 
	 &varpie.
 /
	SUMVAR=nbMarqueE
	SHAPE=CYLINDER
    TYPE=SUM
	discrete
	subgroup=&vsubgr.
	LEGEND=LEGEND1
	COUTLINE=BLACK
	RAXIS=AXIS1
	MAXIS=AXIS2
;
by &varpie. ;
RUN; QUIT;

TITLE; FOOTNOTE;

ods html body = "&racine.html\fic0.htm" style=astronomy;
goptions device = activex  ;
title1 "Marques" ;

proc gchart data=work.nbModele_marque_Modeles_S1 ;
pie3d &varpie.
  /
sumvar = nbMarqueE
html = lien
type=sum
PERCENT=INSIDE
OTHER=0
;
run;
quit;
TITLE; FOOTNOTE;
GOPTIONS reset=all ;
ods html close;
ods listing ;

%mend M_exohref  ;

%M_exohref(varpie=Marque,vsubgr=Modele)



/* Statistiques descriptives */

PROC SORT DATA = REFER.Encheres_actu;
by marque;
RUN;

ODS listing close;
ODS html path="&RACINE.html/" file="stats_desc.htm"
style=astronomy /*seaside , curve , science , astronomy , watercolor , sketch*/
;

TITLE;
TITLE1 "Statistiques descriptives" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

PROC MEANS DATA = REFER.Encheres_actu
	MAXDEC = 0
	MIN MAX MEAN STD;
VAR adjuge;
CLASS marque;
RUN;

ODS html close;
ODS listing;

/* fréquences des marques */

PROC SORT DATA = REFER.Encheres_actu;
	by marque modele;
RUN;

ODS listing close;
ODS html path="&RACINE.html/" file="tab_freq_marques.htm"
style=astronomy
;

TITLE;
TITLE1 "Fréquences des marques" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

PROC FREQ DATA = REFER.Encheres_actu;
	TABLE marque
/ nofreq nocum;
RUN;

ODS html close;
ODS listing;



/* fréquence par marque: graph */

PROC SORT DATA = REFER.Description_auto2;
	by Marque Modele;
RUN;

proc sql;
create table nbModele_marque as
select DISTINCT Marque, Modele, count(modele) as nbModeleM
from REFER.Description_auto2
group by Marque, Modele;
quit;

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "freq_marque_graph.htm"
style=astronomy;

TITLE;
TITLE1 "Fréquence par marque" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

proc gchart data= nbModele_marque;
vbar3d Marque / discrete
sumvar= nbModeleM
type=sum
;
run;

ods html close;
ods listing;


/*  */

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "mean_per_marque.htm"
style=astronomy;

TITLE;
TITLE1 "Moyennes de ventes par marque" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;

PROC TABULATE DATA =  REFER.Encheres_actu;
	CLASS marque;
	VAR adjuge;
	TABLE (marque), (adjuge) * (mean sum);
RUN;

ods html close;
ods listing;

/* caractéristiques par marque et par modéle de voiture */

TITLE;
TITLE1 "Répartition des ventes par famille de produits et par marque" ;
TITLE2 "année 2007" ;
FOOTNOTE;
FOOTNOTE1 "IUT Vannes" ;


%Macro table_marque(fichier=);

ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html/"
file = "&fichier._mean_per_year.htm"
style=astronomy;

PROC TABULATE DATA = WORK.&fichier._ench;

	VAR adjuge;
	CLASS modele / ORDER=DATA MISSING;		/*il affiche les données dans l'ordre dans lesquelles il les trouve et on accepte les données non renseignées*/
	CLASS year_dv / ORDER=DATA MISSING;
	TABLE
		/* ROW Statement */
		modele
		all = 'Total marques' ,
		/* COLUMN Statement */
		year_dv *(adjuge=' ' * sum=' ' )				/* sum=' ' permet de ne pas avoir sum écrit en dessous de toute les somme ou qqch comme ça*/
		all = 'Total Modeles' * (adjuge=' ' * sum=' ' )       ;
	;
RUN;

ods html close;
ods listing;

%Mend table_marque;

%table_marque(fichier=Aston_Martin);
%table_marque(fichier=De_Tomaso);
%table_marque(fichier=Dodge);
%table_marque(fichier=Ferrari);
%table_marque(fichier=Jaguar);
%table_marque(fichier=Lamborghini);
%table_marque(fichier=Maserati);
%table_marque(fichier=Mercedes);
%table_marque(fichier=Porsche);
%table_marque(fichier=Venturi);

