%let racine = C:\Users\Taffou\Documents\Cours_S�ve\LP_CSD\SAS\PROJET\;
libname APPLI "&racine.DATA\APPLICATION";
libname MAC "&racine.DATA\MACRO";
options mstored sasmstore = mac;
libname REFER "&racine.DATA\REFERENCE";
