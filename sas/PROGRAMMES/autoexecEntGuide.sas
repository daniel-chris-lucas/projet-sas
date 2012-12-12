%let racine = D:\SASuserdirs\ETUDIANTS\etudiant05;
libname APPLI CLEAR ;
libname REFER clear ;
libname APPLI "&racine.\APPLICATION";
libname REFER "&racine.\REFERENCE";
OPTION FMTSEARCH=(WORK.FORMATS WORK);
