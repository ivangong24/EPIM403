/************************************************************
Program name: "E:\final2.sas"
Programmer's name: Yufan Gong
Creation Date: 3/5/2020
Purpose: To complete final exam
************************************************************/
Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\Final\sasdata";

/* I use the PROC IMPORT wizard*/

PROC IMPORT OUT= YUFAN.survey_m403
            DATAFILE= "E:\Final\survey m403.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*
NOTE: YUFAN.SURVEY_M403 data set was successfully created.
NOTE: The data set YUFAN.SURVEY_M403 has 25 observations and 34 variables.
NOTE: PROCEDURE IMPORT used (Total process time):
      real time           1.68 seconds
      cpu time            0.84 seconds
*/


option fmtsearch = (yufan);

Proc Format library = yufan;
Value question  1    = "yes"
                2    = "no";
Value q3_       1    = "No experience whatsoever"
                2    = "A little experience"
			    3    = "Some experience"
			    4    = "A good bit of experience"
			    5    = "A lot of experience";
Value q5_       1    = "Yes, I took: "
                2    = "Yes, but I don't remember"
			    3    = "No"
			    4    = "I don't remember";
Value q7_       0-3  = "not often"
                4-6  = "medium"
			    7-10 = "often";
Value q18a      1    = "Yes"
                2    = "No"
			    3    = "I've already done one at DPH";
Run;

Data yufan.task2;
Set yufan.survey_m403;

Label id   = "ID number"
      Q3   = "How much SAS experience do you have?"
      Q5   = "Have you ever taken SAS class from the SAS Institute?"
	  Q6a  = "Do you have a dataset to work with?"
	  Q6b  = "Do you currently working with a dataset?"
	  Q7a  = "In school"
	  Q7b  = "On the job"
	  Q9a  = "Friend(s)"
	  Q9b  = "Graduate advisor(s)"
	  Q9c  = "Employer(s)"
	  Q9d  = "Parent(s)"
	  Q9e  = "Flyer(s)"
	  Q9f  = "Course requirement"
	  Q9g  = "Other (Please specify: )"
	  Q12a = "A local health department"
	  Q12b = "The Centers for Disease Control and Prevention"
	  Q12c = "A pharmaceutical company"
	  Q12d = "Community-based organization"
	  Q12e = "College/University"
	  Q12f = "Other (Please specify: )"
	  Q18a = "Are you interested in doing an internship at the Los Angeles County Department of Public Health (DPH)"
	  Q19a = "It's required"
	  Q19b = "I need it to get a(n) job/internship"
	  Q19c = "I am taking it for fun"
	  Q19d = "My advisor told me to take this course"
	  Q19e = "Other: "
;

Format Q3          q3_.
       Q5          q5_.
	   Q6a--Q6b    question.
	   Q7a--Q7b    q7_.
	   Q9a--Q9f    question.
	   Q12a--Q12f  question.
	   Q18a        q18a.
	   Q19a--Q19e  question.
;
Run;

ODS RTF File= "E:\Final\sasdata\Task 2 Frequency Distribution.doc";

Proc Contents data=yufan.task2 position;
Run;

Proc Freq data=yufan.task2;
Title "Line listing of task2";
Run;

ODS RTF CLOSE;

ODS CSV File="E:\Final\sasdata\Task 2.csv";

Proc Print data=yufan.task2;
run;

ODS CSV ClOSE;
