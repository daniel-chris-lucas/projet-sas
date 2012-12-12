DATA work.class;
 	SET sashelp.class;
RUN;

/*Créer une table en ne gardant que les variable Name, Sex et Age à partir de la table class de sashelp*/
DATA work.class1 (KEEP= name sex age);
 	SET sashelp.class;
RUN;

/*autre façon - ici on ne lit que trois variables au lieu de 5 pour créer la table (préférable! ^^)*/
DATA work.class2;
 	SET sashelp.class (KEEP= name sex age);
RUN;

/*autre manière équivalente d'écrire*/
DATA work.class3;
 	SET sashelp.class;
	KEEP name sex age;
RUN;


/*Créer la table Fille en ne sélectionnant que les filles*/
DATA work.Fille;
	SET sashelp.class;
	WHERE sex='F';
RUN;

/*RQ: il vaut mieux faire ses sélections sur les tables lues plutôt que les tables créées!!*/

/*Créer une table Fille2 en ne sélectionnant que les filles de moins de 13 ans*/
DATA work.Fille2;
	SET sashelp.class;
	WHERE sex='F' AND age<13;
RUN;

/*Créer une table avec les filles entre 10 et 13 ans et les garçons de plus de 12 ans*/
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
préférable de mettre des parenthèses même si ici ça fonctionne sans*/

/*Créer une table avec les filles entre 10 et 13 ans et les garçons de plus de 12 ans
ET on ne sélectionne que les var Name et Sex (de façon optimisée!! ;p)*/
DATA work.Filles_Garcons_select (DROP= age);
	SET sashelp.class (	WHERE= ( (sex='F' AND age between 10 and 13) OR (sex='M' AND age>12) ) 
						KEEP= name sex age );
RUN;


/*filtrer sur les étudiants avec 'al' dans le prénom*/
DATA work.prenom_al;
	SET sashelp.class (WHERE= (UPCASE(name) LIKE '%AL%'));
RUN;

/*avec where on peut utiliser le LIKE, mais pas avec le if...*/

/*fonction index*/
DATA work.filtre_prenom_index;
	SET sashelp.class (WHERE= ( index( UPCASE(name), 'AL')>0 ) );
RUN;

/*Créer la variable libel_sex en associant F=> Fille, M=> Garçon*/
DATA work.crea_var;
	SET sashelp.class;
	ATTRIB libel_sex
		LABEL = 'libellé sexe'
		FORMAT = $6.
		LENGTH = $6;
	IF sex='F' then libel_sex='Fille';
	ELSE IF sex='M' then libel_sex='Garçon';
	ELSE libel_sex='NR';
RUN;

/*On pourrait ne renseigner que length libel_sex $6;
mais il vaut mieux un attrib pour bien créer sa nouvelle variable dans les règles de l'art ^^*/
/*
si on met $4. pour le format et length à $6:
	il affichera que les 4 premiers caractères, mais ce qui est stocké derrière sera bien fille et garçon de length 6!!
Si on met la length $4 et le format $6.
	il affiche aussi les 4 premier caractère, mais le résultat n'est pas le même!!
	là il stocke aussi que les 4 premiers caractères!! attention!!
*/

/* Créer la variable IMC (Indice de Masse Corporelle) = Poids(kg) / Taille²(cm) */
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
	pour les trucs numériques le minimum de la length est de trois! et un octets != de un chiffre !!
	5.2 : le premier : dans l'exemple prend 5 chiffre, dont la virgule!
		et le deuxième, ici 2 indique le nombre de chiffres après la virgule
*/
/*RQ: pour un format numérique: on ne met pas de $ !!!*/

/*libellé et compter combien il y a de mince, ect*/
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
		LABEL = 'libellé de l Indice de Masse Corporelle'
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
