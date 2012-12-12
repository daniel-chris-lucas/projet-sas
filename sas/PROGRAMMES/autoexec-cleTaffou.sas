%let racine = F:\LP CSD\PROJET\;
libname APPLI "&racine.DATA\APPLICATION";
libname MAC "&racine.DATA\MACRO";
options mstored sasmstore = mac;
libname REFER "&racine.DATA\REFERENCE";

