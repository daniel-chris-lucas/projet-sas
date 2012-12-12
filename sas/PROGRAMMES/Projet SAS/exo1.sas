DATA work.class;
 	SET sashelp.class;
RUN;

/*Cr�er une table en ne gardant que les variable Name, Sex et Age � partir de la table class de sashelp*/
DATA work.class1 (KEEP= name sex age);
 	SET sashelp.class;
RUN;

/*autre fa�on - ici on ne lit que trois variables au lieu de 5 pour cr�er la table (pr�f�rable! ^^)*/
DATA work.class2;
 	SET sashelp.class (KEEP= name sex age);
RUN;

/*autre mani�re �quivalente d'�crire*/
DATA work.class3;
 	SET sashelp.class;
	KEEP name sex age;
RUN;


/*Cr�er la table Fille en ne s�lectionnant que les filles*/
DATA work.Fille;
	SET sashelp.class;
	WHERE sex='F';
RUN;

/*RQ: il vaut mieux faire ses s�lections sur les tables lues plut�t que les tables cr��es!!*/

/*Cr�er une table Fille2 en ne s�lectionnant que les filles de moins de 13 ans*/
DATA work.Fille2;
	SET sashelp.class;
	WHERE sex='F' AND age<13;
RUN;

/*Cr�er une table avec les filles entre 10 et 13 ans et les gar�ons de plus de 12 ans*/
DATA work.Filles_Garcons;
	SET sashelp.class;
	WHERE (sex='F' AND 10<=age<=13) OR (sex='M' AND age>12);
RUN;

/*ou avec un between*/
DATA work.Filles_Garcons;
	SET sashelp.class;
	WHERE (sex='F' AND age between 10 and 13) OR (sex='M' AND age>12);
RUN;

/*RQ: le AND est prioritaire par rapport au OR! faire attention!!
pr�f�rable de mettre des parenth�ses m�me si ici �a fonctionne sans*/

/*Cr�er une table avec les filles entre 10 et 13 ans et les gar�ons de plus de 12 ans
ET on ne s�lectionne que les var Name et Sex (de fa�on optimis�e!! ;p)*/
DATA work.Filles_Garcons_select (DROP= age);
	SET sashelp.class (	WHERE= ( (sex='F' AND age between 10 and 13) OR (sex='M' AND age>12) ) 
						KEEP= name sex age );
RUN;


/*filtrer sur les �tudiants avec 'al' dans le pr�nom*/
DATA work.prenom_al;
	SET sashelp.class (WHERE= (UPCASE(name) LIKE '%AL%'));
RUN;

/*avec where on peut utiliser le LIKE, mais pas avec le if...*/

/*fonction index*/
DATA work.filtre_prenom_index;
	SET sashelp.class (WHERE= ( index( UPCASE(name), 'AL')>0 ) );
RUN;

/*Cr�er la variable libel_sex en associant F=> Fille, M=> Gar�on*/
DATA work.crea_var;
	SET sashelp.class;
	ATTRIB libel_sex
		LABEL = 'libell� sexe'
		FORMAT = $6.
		LENGTH = $6;
	IF sex='F' then libel_sex='Fille';
	ELSE IF sex='M' then libel_sex='Gar�on';
	ELSE libel_sex='NR';
RUN;

/*On pourrait ne renseigner que length libel_sex $6;
mais il vaut mieux un attrib pour bien cr�er sa nouvelle variable dans les r�gles de l'art ^^*/
/*
si on met $4. pour le format et length � $6:
	il affichera que les 4 premiers caract�res, mais ce qui est stock� derri�re sera bien fille et gar�on de length 6!!
Si on met la length $4 et le format $6.
	il affiche aussi les 4 premier caract�re, mais le r�sultat n'est pas le m�me!!
	l� il stocke aussi que les 4 premiers caract�res!! attention!!
*/

/* Cr�er la variable IMC (Indice de Masse Corporelle) = Poids(kg) / Taille�(cm) */
/* 
	1 pouce = 2.54cm
	1 livre = 0.453kg
*/
DATA work.IMC;
	SET sashelp.class;
	ATTRIB IMC
		LABEL = 'Indice de Masse Corporelle'
		FORMAT = 5.2
		LENGTH = 8;
	IMC = (Weight*0.453) / ( (Height*0.0254)**2 );
RUN;
/*
tableau p 19 : indication sur les longueurs
	pour les trucs num�riques le minimum de la length est de trois! et un octets != de un chiffre !!
	5.2 : le premier : dans l'exemple prend 5 chiffre, dont la virgule!
		et le deuxi�me, ici 2 indique le nombre de chiffres apr�s la virgule
*/
/*RQ: pour un format num�rique: on ne met pas de $ !!!*/

/*libell� et compter combien il y a de mince, ect*/
PROC FORMAT;
	value lib_imc
	LOW - 13 = 'Mince'
	13 <- 16 = 'Normal'
	16 <- HIGH = 'Surpoids';
RUN;

DATA work.lib_IMC;
	SET sashelp.class;
	ATTRIB IMC
		LABEL = 'Indice de Masse Corporelle'
		FORMAT = 5.2
		LENGTH = 8;
	IMC = (Weight*0.453) / ( (Height*0.0254)**2 );
	
	format imc lib_imc.;
RUN;


DATA work.lib_IMC;
	SET sashelp.class;
	ATTRIB IMC
		LABEL = 'Indice de Masse Corporelle'
		FORMAT = 5.2
		LENGTH = 8;
	IMC = (Weight*0.453) / ( (Height*0.0254)**2 );

	ATTRIB lib_IMC
		LABEL = 'libell� de l Indice de Masse Corporelle'
		FORMAT = $8.
		LENGTH = $8;
	
	IF IMC < 13 then lib_imc = 'Mince';
	ELSE IF 13 <= IMC < 16 then lib_imc = 'Normal';
	ELSE IF IMC >= 16 then lib_imc = 'Surpoids';
	ELSE lib_IMC = 'NR';
RUN;

PROC FREQ DATA = work.lib_IMC;
table lib_IMC;
RUN;
