
PROC SORT DATA = Refer.Encheres_actu_test ;
by marque;
RUN;


GOPTIONS device = activex xpixels=800 ypixels=600;
/*  */

ODS LISTING CLOSE;		/*il n'affichera pas la sortie dans le listing!*/
ODS HTML				/*on ouvre donc un autre endroit de sortie dont il faudra pr�ciser o� elle est*/
path = "&RACINE.\images\"
file = "gchart_sample.jpeg"
style = seaside			/*permet d'appliquer le m�me style et jeu de couleur � tous ses graphiques, il y a plein de style pr�d�finis*/

/*
		parameters=("DisableDrillDown"="True"
					"ShowBackDrop"="True"
					"BackColor"="#CCAA22"
					"BackDropColor"="#FF2233"
					"MenuRemove"="Variables,Options.Drilldown,Graph.I
*/
;
/*
	PATTERN1 COLOR=    ;      on y reviendre plus tard
*/

Axis1
	STYLE = 1			/*style de la barre d'histogramme. ici trait plein*/
	WIDTH = 1			/*�paisseur*/
	MINOR = NONE		/*par d�faut une �chelle primaire, pas d'�chelle secondaire*/
						/*on pourrait d�finir la couleur, ici ce sera noir vu qu'on ne le fait pas*/
;

Axis2
	STYLE = 1			
	WIDTH = 1			

;

TITLE;			/*titre. on ne met rien dans TITLE et si il y a qqch on l'efface*/
TITLE1 "Histogramme simple";		/*chaque titre peut avoir sa police*/
/*tant qu'on � pas mis TITLE1; on garde le titre mis dedans, on l'effacera une fois le graphique fait pour ne pas interf�rer avec d'autre graphique*/
FOOTNOTE;		/*pied de page*/
FOOTNOTE1 "G�n�r� par le syst�me IUT Vannes le %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) � %TRIM(%QSYSFUNC(TIME(), NLTIMAP20.))";

TITLE1; FOOTNOTE1;
/*
PATTERNE1;
PATTERNE2;
PATTERNE3;
PATTERNE4;
PATTERNE5;
PATTERNE6;
*/


PROC GCHART DATA = Refer.Encheres_actu_test ;

	VBAR3D			/* style du graphique que l'on veut */
	modele			/*autant de barre d'hsitogramme que de modalit� dans NAME <=> axe des X !!*/
/
	SUMVAR = adjuge			/*valeur forc�ment num�rique*/
	SHAPE = BLOCK			/*d�termine le type de barre d'histogramme que l'on veut, on peut avoir des cylindre par exemple, des �toiles en 3D xD, des hexagones....*/
	FRAME					/*gestion du fond derri�re*/
	TYPE = SUM				/*quelle variable statistique on applique l�-dessus. ici une somme. on aurait pu faire une moyenne, un maximum....*/
	DESCENDING				/*on affiche les barres d'histogreamme en ordre croissant. on aura tjrs de la plus haute � la plus petite. Pas obligatoire comme option, on les aura alors dans l'ordre du trie.*/
	COUTLINE = LTGRAY		/*g�re la couleur ltgray = gris clair // on peut aussi le g�rer avec des code de couleur RGB pour avoir des couleur tr�s pr�cises � l'affichage sur les terminaux*/
	RAXIS = AXIS1			/**/
	MAXIS = AXIS2			/**/
;
	BY marque;			/*Il faut donc �videmment avoir tri� la table avant!!*/
RUN; QUIT;


GOPTIONS reset=all;
ods html close;
ods listing;
