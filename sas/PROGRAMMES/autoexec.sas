%let racine = L:\Local Server\sites\sandbox\projet-sas\sas\;
libname APPLI "&racine.DATA\APPLICATION";
libname MAC "&racine.DATA\MACRO";
options mstored sasmstore = mac;
libname REFER "&racine.DATA\REFERENCE";
