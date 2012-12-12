%macro test (name, age);

	%put Etudiant : &name , Age : &age ans;

%mend test;


%test(toto, 27);
%test(tata, 50);


data _NULL_;
	set sashelp.class;
	call execute ('%test ('!!name!!','!!age!!');');
RUN;
