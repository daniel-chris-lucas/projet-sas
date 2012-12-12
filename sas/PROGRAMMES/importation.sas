/* Importation des tables */

/* importation de la table du prix des véhicules */

DATA REFER.Prix_Vehicule;
	INFILE "&racine.FICHIERS\Prix Vehicule.txt"
		FIRSTOBS = 2 MISSOVER
		DSD;

	INPUT Marque : $20.
		  Modele : $10.
		  Type : $20.
		  Annee : 4.
		  Prix_Courant : NUMX.
		  Devise : $1.
	;
	ATTRIB
		Prix_Courant LABEL = "Prix Courant"
		Annee FORMAT = YEAR4.
		Prix_Courant FORMAT = NLNUM15.2
	;
RUN;

/* 
incohérence dans le programme, pour la voiture De Tomaso il y a deux valeurs manquantes :
l'année et le prix courant
Or dans le fichier on a un seul espace vide, ce qui fait qu'il ne prendra pas en compte le F, il fait un décalage
soit on peut rajouter le F en codant, soit on peut le laisser étant donné qu'on n'a pas le prix toute façon
*/

/* importation de la table des enchères */

DATA REFER.Encheres;
	INFILE "&racine.FICHIERS\Encheres.txt"
		FIRSTOBS = 2 MISSOVER
		DSD;

	INPUT Ville : $20.
		  Date_Vente : $8.
		  Marque : $30.
		  Modele : $30.
		  Type : $30.
		  annee : 4.
		  Num_serie : $30.
		  Conduite : $5.
		  Kilometrage : 6.2
		  prix_propose : 8.
		  Adjuge : 8.
		  Qualite : $20.
		  Commentaires : $30.
		  devise : $20.
	;
	ATTRIB
		/*Date_Vente FORMAT = ddmmyy10.*/
	;
RUN;

/* importation de la table des descritions des voitures */

DATA REFER.Description_Auto;
	INFILE "&racine.FICHIERS\description auto.csv"
		FIRSTOBS = 2 MISSOVER
		DSD
		delimiter=";";

	INPUT Marque : $20.
		  Modele : $10.
		  Type : $20.
		  Carrosserie : $10.
		  Deb_construction : $6.
		  Fin_construction : $6.
		  nb_exemplaires : 5.
		  Type_moteur : $3.
		  Turbo : $3.
		  cv_din : 3.
		  vitesse : 3.
		  nb_places : 1.
	;
	ATTRIB
		nb_exemplaires FORMAT = NLNUM5.
	;
RUN;

/* importation de la table du prix en base 100 en 1970 */

DATA REFER.IPConsommation;
	INFILE "&racine.FICHIERS\IPConsommation (base 100 1970).csv"
		FIRSTOBS = 2 MISSOVER
		DSD
		delimiter=";";

	INPUT Annee : 4.
		  Semestre : $2.
		  Indice_prix : NUMX.
	;
RUN;




