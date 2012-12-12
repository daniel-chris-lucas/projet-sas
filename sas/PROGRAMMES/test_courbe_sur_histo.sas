
PROC SORT DATA = refer.encheres_actu;
by year_dv;
RUN;


*GOPTIONS device = activex xpixels=640 ypixels=480;


ODS LISTING CLOSE;
ODS HTML
path = "&RACINE.html\"
file = "curve.htm"
style =  curve /*seaside , curve , science , astronomy , watercolor , sketch*/
;



SYMBOL1
	INTERPOL=JOIN
	POINTLABEL

	HEIGHT=10pt
	FONT =MARKER /*police de symboles*/
	VALUE=V
	CV=BLUE
	LINE=1
	WIDTH=2
	CI=CX33CCCC
;
Legend1
	DOWN=2
	CBORDER=CX000080
	CFRAME=CXFFFF99
	CSHADOW=GRAY /*couleur de l'onbre sur la légende*/
	LABEL=(FONT='Comic Sans MS /b' HEIGHT=12pt JUSTIFY=LEFT COLOR=BLUE)
	;
Axis1
	STYLE=1
	WIDTH=1
	LABEL=(FONT='Arial /i' COLOR=CX000080)
	VALUE=(FONT='Arial Black' COLOR=CX000080)
;
Axis2
	STYLE=1
	WIDTH=1
	LABEL=(FONT='Arial /u' COLOR=CX000080)
	VALUE=(FONT='Arial Black' COLOR=CX000080)
;
Axis3
	COLOR=CX993300
	STYLE=1
	WIDTH=1
	/*Major=(COLOR=
	Minor=(COLOR=
	LABEL=(FONT='Arial /u' COLOR=CX000080)
	VALUE=(FONT='Arial Black' COLOR=CX000080)*/
;

TITLE;
TITLE1 "courbe - histogramme - Echères" ;
FOOTNOTE;
FOOTNOTE1 "Généré par le système IUT Vannes le %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) à %TRIM(%QSYSFUNC(TIME(), NLTIMAP20.))" ;


PROC GBARLINE DATA = refer.encheres_actu ;

BAR month_dv
/
	SUMVAR=adjuge
	SUBGROUP=modele
	CLIPREF /*positionne les lignes de références derrière les barres*/
	/* NOFRAME */ /*supprime toutes les couleur de fond derrière le graphique*/
	CFRAME=MediumSeaGreen
	DISCRETE
	TYPE=MEAN
	MISSING
	INSIDE=SUM
	COUTLINE=LTGRAY
	RAXIS = AXIS1
	MAXIS = AXIS2
	LREF = 41
	CREF=GRAY
	AUTOREF
	LEGEND=LEGEND1
;
	PLOT
/
	SUMVAR=adjuge
	TYPE=SUM
	AXIS=AXIS3
	LEGEND=LEGEND1
	LREF=34
	/* CREF=GREEN */
	/* AUTOREF */
	REF=5
;
	by year_dv;

RUN; QUIT;

TITLE ;
TITLE1 ;
TITLE2 ; 
FOOTNOTE ;
FOOTNOTE1 ;


GOPTIONS reset=all ;
ods html close ;
ods listing ;
