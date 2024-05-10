/************************************************************
Program name: "E:\quiz 6.sas"
Programmer's name: Yufan Gong
Creation Date: 3/2/2020
Purpose: To complete quiz 6
************************************************************/
Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\";

PROC IMPORT OUT= YUFAN.Master 
            DATAFILE= "E:\Quiz6.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Master$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= YUFAN.Interviews 
            DATAFILE= "E:\Quiz6.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Interviews$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*********************************************************************
NOTE: YUFAN.MASTER data set was successfully created.
NOTE: The data set YUFAN.MASTER has 10 observations and 11 variables.
NOTE: YUFAN.INTERVIEWS data set was successfully created.
NOTE: The data set YUFAN.INTERVIEWS has 8 observations and 2 variables.
**********************************************************************/

option fmtsearch=(yufan);

Proc Format library=yufan;
Value Ageft          low-29  = '< 30 years old'
                     30-High = '30 years old and above';
Value Spaft          1 = 'Antelope Valley'
                     2 = 'San Fernando'
		             3 = 'San Gabriel'
		             4 = 'Metro'
		             5 = 'West'
		             6 = 'South'
		             7 = 'East'
		             8 = 'South Bay';
Value Likert_Scaleft 1 = 'Strongly agree'
                     2 = 'Agree'
					 3 = 'Neither agree or disagree'
					 4 = 'Disagree'
					 5 = 'Strongly disagree'
					 9 = 'Missing';

Proc Sort data=yufan.Master ;
By ID;
Run;

Proc Sort data=yufan.Interviews;
By Idno;
Run;

Data perm1;
Merge yufan.Master
      yufan.Interviews (rename=(Idno=ID) IN=a);
By ID;
If a;
Array drop[5]Q1-Q5;
Do I = 1 to 5;
If drop[I]=9 then drop[I]= .;
End;
Drop I;
Q1=6-Q1;
Q4=6-Q4;
Q5=6-Q5;

Label  ID        = 'ID Number'
       Last      = 'Last name'
	   Age       = 'Age Group'
	   Zipcode   = 'Zipcode'
	   Interview = 'Applicant was interviewed'
	   Cost      = 'Cost of Services'
	   Spa       = 'Service Planning Area'
	   Q1        = 'Do you dislike healthy foods?'
	   Q2        = 'Do you like ice cream?'
	   Q3        = 'Do you like spinach dip?'
	   Q4        = 'Do you dislike kale chips?'
	   Q5        = 'Do you dislike street tacos?'
	   ;

Format Age    Ageft.
       Cost   dollar10.2
	   Spa    Spaft.
	   Q1--Q5 Likert_Scaleft.
	   ;
Run;

Proc Contents data=perm1 position;
Run;

Proc Print data=perm1 label;
Title2 "Task d";
Sum Cost;
Run;
