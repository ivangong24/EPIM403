/************************************************************
Program name: "E:\quiz 7.sas"
Programmer's name: Yufan Gong
Creation Date: 3/6/2020
Purpose: To complete quiz 7
************************************************************/
Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\";

option fmtsearch=(yufan);

Proc Format library=yufan;

Value scoreft low-70  = "Fail"
              70-high = "Pass";

Data yufan.quiz7;
set yufan.quiz7_030620;
length nucity $6.;
first      = Compress(Propcase(first),"0123456789");
last       = Compress(Propcase(last),"0123456789");
age2       = Input(age,2.);
gender     = Upcase(gender);
address    = Propcase(Compbl(address));
address    = Tranwrd(address,"Avenue","Ave.");
address    = Tranwrd(address,"Boulevard","Blvd.");
address    = Tranwrd(address,"Drive","Dr.");
address    = Tranwrd(address,"North","N.");
address    = Tranwrd(address,"East","E.");
address    = Tranwrd(address,"West","W.");
nucity     = CATX(", ",city,state);
nuzip      = Input(zipcode,5.);
meanscore  = Round(mean(of score1-score3),.1);
newfee     = fee*0.01;
zip        = zipname(zipcode);

Drop age city state zipcode fee;

Label first     = "First name"
      last      = "Last name"
	  age2      = "Age"
	  gender    = "Gender"
	  address   = "Address"
	  nucity    = "city"
	  score1    = "Test 1"
	  score2    = "Test 2"
	  score3    = "Test 3"
	  state     = "State"
	  nuzip     = "Zipcode"
	  meanscore = "Mean score"
      newfee    = "Fee for services"
	  zip       = "Zipcode state"
	  ;
Format nuzip     Z5. 
       newfee    dollar10.2
       meanscore scoreft.    
;
Run;

Proc Contents data=yufan.quiz7 position;
Run;

Proc Print data=yufan.quiz7 label;
Sum newfee;
Run;
