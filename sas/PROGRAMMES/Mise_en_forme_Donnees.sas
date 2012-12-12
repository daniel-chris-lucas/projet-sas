/* Gérer les dates */

DATA REFER.Encheres2;
SET REFER.Encheres;

if length(Date_Vente) = 6 then Date_Vente = cats(Date_Vente,"15"); /*  */
if marque="Aston-Martin" then marque="Aston_Martin";
if marque="De Tomaso" then marque="De_Tomaso";
				
RUN;

DATA REFER.Description_auto2;
SET REFER.Description_auto;

if length(Deb_construction) = 4 then Deb_construction = cats(Deb_construction,"06");
if length(Fin_construction) = 4 then Fin_construction = cats(Fin_construction,"06");
if nb_exemplaires =" " then nb_exemplaires =1;
if marque="Aston-Martin" then marque="Aston_Martin";
if marque="De Tomaso" then marque="De_Tomaso";

/*on considère qu'il y a au moins une voiture si elle est présente dans le fichier des modèles*/
				
RUN;


/* Changer les conversions des sous pour tout mettre en Euros */

Data REFER.Prix_vehicule2;
	set REFER.Prix_vehicule;

	FrancEuro = 0.152449017;
	Prix_Courant = Prix_Courant * FrancEuro;
	Devise = "E";
run;

Data REFER.Encheres2;
	set REFER.Encheres2;

	FrancEuro = 0.152449017;
	PoundEuro = 1.2509;
	DollarEuro = 0.7830;
	DeutschmarkEuro = 0.5112;
	CHFEuro = 0.8290;

	select( devise );
		when( 'FF' ) Adjuge = Adjuge * FrancEuro;
		when( 'Livre sterling' ) Adjuge = Adjuge * PoundEuro;
		when( 'DM' ) Adjuge = Adjuge * DeutschmarkEuro;
		when( 'Dollar US' ) Adjuge = Adjuge * DollarEuro;
		when( 'CHF' ) Adjuge = Adjuge * CHFEuro;
		otherwise;
	end;

run;

/* Prix actualisés */

/* %macro ipconso(annee, semestre); */

DATA work.ipconso_actu;
	SET REFER.Ipconsommation2;
	ATTRIB Year_dv 
		Label = "Annee de vente"
		LENGTH = 4
		FORMAT = 4.
		
			Sem_dv
		Label = "Semestre de vente"
		LENGTH = $2
		FORMAT = $2.

			Indice_prix_actuel
		Label = "Indice prix"
		
	;
	
RUN;


/*
data newtable;
Set REFER.Ipconsommation2;
where year_dv="$annee." and sem_dv="$semestre.";
keep indice_prix;
Run;
*/
/* %mend; */

/* %ipconso(2012, s1); */

DATA REFER.Encheres2;
	SET REFER.Encheres2;
	ATTRIB Year_dv 
		Label = "Annee de vente"
		LENGTH = 4
		FORMAT = 4.
		
			Sem_dv
		Label = "Semestre de vente"
		LENGTH = $2
		FORMAT = $2.

			Indice_prix_actuel
		Label = "Indice prix de.$annee."
		
	;
	Year_dv = SUBSTR(Date_Vente,1,4);
	IF ( 01 <= SUBSTR(Date_Vente,5,2) <= 06 ) THEN Sem_dv = "S1" ;
	IF ( 07 <= SUBSTR(Date_Vente,5,2) <= 12 ) THEN Sem_dv = "S2" ;
	Indice_prix_actuel = 581.3 ;
	
RUN;

PROC SORT DATA = REFER.Encheres2;
	by Year_dv Sem_dv;
RUN;


**%macro M_annee(annee=);

DATA REFER.Ipconsommation2 (RENAME = ( annee = Year_dv semestre = Sem_dv ) );
	SET REFER.Ipconsommation;
RUN;


DATA REFER.Encheres_actu;
	MERGE REFER.encheres2 (IN = dans_encheres)
		  REFER.Ipconsommation2 (IN = dans_Ipconsommation);

	BY Year_dv Sem_dv;

	IF dans_encheres THEN OUTPUT;

RUN;
	
DATA REFER.Encheres_actu_test;
	SET REFER.Encheres_actu;
	ATTRIB Indice_prix_actuel
		Label = "Indice prix de.$annee."
	;
	/* IF Year_dv = "2012" and Semestre = "S1" THEN Indice_prix_actuel = Indice_prix; */

RUN;

DATA REFER.Encheres_actu;
	SET REFER.Encheres_actu;
	ATTRIB NewAdjuge
		Label = "Adjuge actuel"
		Length = 8
		Format = NUMX10.2
	;
	
	NewAdjuge = ( Adjuge * Indice_prix_actuel ) / Indice_prix ;

RUN;


/* data _null_;
   set REFER.Ipconsommation2;
   by Year_dv Sem_dv;
   if last.Year_dv then Indice_prix_actuel = last.Year_dv ;;
   
run;
*/



	
/*
If 1979 = Ipconsommation.Annee then Adjudge_actu = Adjuge * ( 1* Ipconsommation.Indice_prix ( where (Ipconsommation.annee = 1979) ) / Ipconsommation.Indice_prix ( where ( Ipconsommation.annee = YEAR(TODAY() ) ) ) );
*/


/*
merge des deux tables! dans la table Enchère, sur chaque ligne mettre la valeur de l'année correspondante de Ipconso
et dans une deuxième colonne mettre celle de l'année en cours et faire le calcul
voir si ça peu marcher!!
*/

**%M_annee(annee=Year_dv);
**%M_annee(annee=1979);
**%M_annee(annee=1997);



/**/


