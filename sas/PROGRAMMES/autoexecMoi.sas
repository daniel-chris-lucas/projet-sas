%let racine = C:\Documents and Settings\Cours\LP CSD\SAS\PROJET\;
libname APPLI "&racine.DATA\APPLICATION";
libname MAC "&racine.DATA\MACRO";
options mstored sasmstore = mac;
libname REFER "&racine.DATA\REFERENCE";
