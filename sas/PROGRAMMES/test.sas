
PROC SORT DATA = Refer.Encheres_actu_test ;
by marque;
RUN;


GOPTIONS device = activex xpixels=800 ypixels=600;
/*  */

ODS LISTING CLOSE;		/*il n'affichera pas la sortie dans le listing!*/
ODS HTML				/*on ouvre donc un autre endroit de sortie dont il faudra préciser où elle est*/
path = "&RACINE.\images\"
file = "gchart_sample.jpeg"
style = seaside			/*permet d'appliquer le même style et jeu de couleur à tous ses graphiques, il y a plein de style prédéfinis*/

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
	WIDTH = 1			/*épaisseur*/
	MINOR = NONE		/*par défaut une échelle primaire, pas d'échelle secondaire*/
						/*on pourrait définir la couleur, ici ce sera noir vu qu'on ne le fait pas*/
;

Axis2
	STYLE = 1			
	WIDTH = 1			

;

TITLE;			/*titre. on ne met rien dans TITLE et si il y a qqch on l'efface*/
TITLE1 "Histogramme simple";		/*chaque titre peut avoir sa police*/
/*tant qu'on à pas mis TITLE1; on garde le titre mis dedans, on l'effacera une fois le graphique fait pour ne pas interférer avec d'autre graphique*/
FOOTNOTE;		/*pied de page*/
FOOTNOTE1 "Généré par le système IUT Vannes le %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) à %TRIM(%QSYSFUNC(TIME(), NLTIMAP20.))";

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
	modele			/*autant de barre d'hsitogramme que de modalité dans NAME <=> axe des X !!*/
/
	SUMVAR = adjuge			/*valeur forcément numérique*/
	SHAPE = BLOCK			/*détermine le type de barre d'histogramme que l'on veut, on peut avoir des cylindre par exemple, des étoiles en 3D xD, des hexagones....*/
	FRAME					/*gestion du fond derrière*/
	TYPE = SUM				/*quelle variable statistique on applique là-dessus. ici une somme. on aurait pu faire une moyenne, un maximum....*/
	DESCENDING				/*on affiche les barres d'histogreamme en ordre croissant. on aura tjrs de la plus haute à la plus petite. Pas obligatoire comme option, on les aura alors dans l'ordre du trie.*/
	COUTLINE = LTGRAY		/*gère la couleur ltgray = gris clair // on peut aussi le gérer avec des code de couleur RGB pour avoir des couleur très précises à l'affichage sur les terminaux*/
	RAXIS = AXIS1			/**/
	MAXIS = AXIS2			/**/
;
	BY marque;			/*Il faut donc évidemment avoir trié la table avant!!*/
RUN; QUIT;


GOPTIONS reset=all;
ods html close;
ods listing;
