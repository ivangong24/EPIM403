/************************************************************
Program name: "E:\quiz5.sas"
Programmer's name: Yufan Gong
Creation Date: 2/22/2020
Purpose: To complete takehome quiz5
************************************************************/

Title "Yufan Gong (Tuesday Lab)";
Data dataset1;
Input @1 ID   2.
      @4 LAST $7.
	  ;
Datalines;
22 Johnson
23 Smith
24 Zhang
25 Shah
26 Lopez
;
Run;

Proc sort data=dataset1;
By ID;
Run;

Data dataset2;
Input @1  ID   2.
      @4  RACE $8.
	  @13 FEE  7.
	  ;
Datalines;
22 white 	240467 
23 white 	769848
24 asian 	6234372
25 hispanic 25383
26 black 	7214589
;
Run;

Proc sort data=dataset2;
By ID;
Run;

Data dataset3;
Input @1   ID     2.
      @4   DOB    MMDDYY8.
      @13  TEST1  YYMMDD8.
      @22  TEST2  DDMMYY8.
      @31  TEST3  MMDDYY8.
	  ;
Format DOB   MMDDYY10.
       TEST1 YYMMDD8.
	   TEST2 DDMMYY8.
	   TEST3 MMDDYY8.
	   ;
Datalines;
22 10061986 20090326 14052015 02022020
23 05281998 20070514 11082017 01142020
25 11192001 20040711 28052008 04152019
;
Run;

Proc sort data=dataset3;
By ID;
Run;

Data dataset4;
Input @1   ID     2.
      @4   LAST   $6.
	  @11  RACE   $5.
      @17  FEE    7.
      @25  DOB    MMDDYY8.
      @34  TEST1  YYMMDD8.
      @43  TEST2  DDMMYY8.
      @52  TEST3  MMDDYY8.
	  ;
Format DOB   MMDDYY10.
       TEST1 YYMMDD8.
	   TEST2 DDMMYY8.
	   TEST3 MMDDYY8.
	   ;
Datalines;
27 Wright black 689677  11161936 20110416 09072017 01152020
28 Liu    asian 5684797 03271976 20030525 15072016 01162020
;
Run;

Data combo;
Merge dataset1 dataset2 dataset3 (IN=FRODO);
By ID;
If FRODO;
Format DOB   MMDDYY10.
       TEST1 YYMMDD8.
	   TEST2 DDMMYY8.
	   TEST3 MMDDYY8.
	   ;
Run;

Proc Print data=combo;
Run;

Libname yufan "E:\";

OPTIONS pageno=1; 
OPTIONS FMTSEARCH=(yufan);

Proc Format LIBRARY=yufan;
Value $RACEft 'white'    = 'White'
              'black'    = 'Black'
			  'hispanic' = 'Hispanic'
			  'asian'    = 'Asian'
			  ;
Run;

Data yufan.final;
Set combo dataset4;
DATE1 = ROUND(YRDIF(DOB, TEST1, 'ACTUAL'));
DATE2 = ROUND(YRDIF(DOB, '25DEC2019'D, 'ACTUAL'), .1);
DATE3 = ROUND(YRDIF(DOB, TEST2, 'ACTUAL'), .01);
TIME  = INTCK('YEARS',TEST1, TEST3);
NEWFEE=FEE*0.01;
Drop FEE;

Label DATE1 = 'Age at Test Panel l'
      DATE2 = 'Age as of December 25, 2019' 
      DATE3 = 'Age at Test Panel 2'
	  TIME  = 'Number of years between the first and third tests'
	  ID    = 'Patient ID'
	  LAST  = 'Last name'
	  RACE  = 'Race/Ethnicity'
	  DOB   = 'Date of Birth'
	  TEST1 = 'Test Panel 1'
	  TEST2 = 'Test Panel 2'
	  TEST3 = 'Test Panel 3'
	  ;
Format RACE   $RACEft.
       NEWFEE dollar10.2
       DOB    WEEKDATE17.
	   TEST1  WEEKDATE17.
	   TEST2  WEEKDATE17.
	   TEST3  WEEKDATE17.
	   ;

Proc Print Data=yufan.final double label;
Title2 "Task i";
Sum NEWFEE;
Run;
