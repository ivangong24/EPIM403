/************************************************************
Program name: "E:\final1.sas"
Programmer's name: Yufan Gong
Creation Date: 3/5/2020
Purpose: To complete final exam
************************************************************/
Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\Final\sasdata";


/*I use the PROC IMPORT wizard*/

PROC IMPORT OUT= YUFAN.Driving_quiz_1 
            DATAFILE= "E:\Final\Distracted driving 030520.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Driving_quiz_1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*
NOTE: YUFAN.DRIVING_QUIZ_1 data set was successfully created.
NOTE: The data set YUFAN.DRIVING_QUIZ_1 has 1700 observations and 17 variables.
NOTE: PROCEDURE IMPORT used (Total process time):
      real time           18.75 seconds
      cpu time            5.62 seconds
*/

PROC IMPORT OUT= YUFAN.Driving_quiz_2 
            DATAFILE= "E:\Final\Distracted driving 030520.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Driving_quiz_2$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*
NOTE: YUFAN.DRIVING_QUIZ_2 data set was successfully created.
NOTE: The data set YUFAN.DRIVING_QUIZ_2 has 401 observations and 17 variables.
NOTE: PROCEDURE IMPORT used (Total process time):
      real time           5.11 seconds
      cpu time            1.61 seconds
*/

option fmtsearch = (yufan);

Proc Format library = yufan;
Value question 1 = "yes"
               2 = "no"
			   7 = "Refused"
               8 = "don't know"
               9 = "missing";
Value score    low-74  = "Fail"
               75-high = "Pass";
Run;

Data yufan.a;
Set yufan.Driving_quiz_1 yufan.Driving_quiz_2;
Run;

Proc Sort data=yufan.a out=yufan.sample nodupkey dupout=yufan.duplicate;
By id;
Run;

/*
Proc Print data=yufan.duplicate;
Title "Deleted duplicate ID numbers";
Var id;
Run;

/*76 duplicate observations were deleted*/

Data yufan.task1;
Set yufan.sample;

newdate=INTCK('Days',datesurv, '20MAR2020'D);

If city = "Los Angeles Outside" then city = "Outside Los Angeles County";
city=Upcase(substr(city,1,1));
If city = "L" then city = "Los Angeles County";
Else If city = "O" then city = "Outside Los Angeles County";
Else If city = "U" then city = "Outside Los Angeles County";
Else city = "Missing";

substr(age,6,1)=" ";
If age = "20-29" then age = "18-29";

gender=Upcase(substr(gender,1,1));
If gender = "M" then gender = "Male";
Else If gender = "F" then gender = "Female";
Else If gender = "W" then gender = "Female";
Else gender = " ";

zipcode   = compress(zipcode,,"kd");
q1        = compress(compress(q1,,"kd"),"3456");
q2        = compress(compress(q2,,"kd"),"3456");
q3        = compress(compress(q3,,"kd"),"3456");
q4        = compress(compress(q4,,"kd"),"3456");
q5        = compress(compress(q5,,"kd"),"3456");
q6        = compress(compress(q6,,"kd"),"3456");
q7        = compress(compress(q7,,"kd"),"3456");
q8        = compress(compress(q8,,"kd"),"3456");
q9        = compress(compress(q9,,"kd"),"3456");
q10       = compress(compress(q10,,"kd"),"3456");
quizscore = compress(quizscore,,"kd");


Array cha[13] id zipcode--quizscore;
Array num[13] a1-a13;
DO i = 1 to 13;
num[i]=Input(cha[i],5.);
End;
Drop i id zipcode--quizscore;

Array ucla[10] a3-a12;
Do I = 1 to 10;
If ucla[I]=0 Then ucla[I]=2;
End;
Drop I;

Rename a1  = id
       a2  = zipcode
	   a3  = q1
	   a4  = q2
	   a5  = q3
	   a6  = q4
	   a7  = q5
	   a8  = q6
       a9  = q7
	   a10 = q8
	   a11 = q9
	   a12 = q10
	   a13 = quizscore
;

Label 
a1		    =	"Id number"
city	    =	"County"
age		    =	"Age"
gender	    =	"Gender"
a2          =	"Zipcode"
a3		    =	"Physically hit or slap someone riding in my car (1=yes; 2=no)"
a4		    =	"Read electronic billboards (1=yes; 2=no)"
a5		    =	"Fall asleep (1=yes; 2=no)"
a6		    =	"Drive under the influence of alcohol (1=yes; 2=no)"
a7		    =	"Dance (1=yes; 2=no)"
a8		    =   "Watch television or videos (1=yes; 2=no)"
a9		    =	"Text or talk on phone (1=yes; 2=no)"
a10		    =	"Do paperwork for work or homework for school (1=yes; 2=no)"
a11		    =	"Use a laptop computer (1=yes; 2=no)"
a12 		=	"Do you consider yourself to be a safe driver (1=yes; 2=no)"
a13      	=	"Score on driving exam (75/100 points is passing)"
datesurv	=	"Date student was surveyed"
;

Format a3-a12    questionft.
       a13       scoreft.
       datesurv  WEEKDATE.
;
Run;

ods rtf file= "E:\Final\sasdata\Task 1 proc contents and frequency distribution.doc";

Proc Contents data=yufan.task1 position;
Run;

Proc Freq data=yufan.task1;
Title "Line listing: task1";
Run;

ods rtf close;

Proc Tabulate data=yufan.task1 format=10.0;
Title "Question 10 answers, by age and gender";
Class age gender q10 quizscore;
Table age*gender*quizscore (All='Total'), q10*(N PCTN='%') All='Total'/ rts=8;
Run;

Proc Logistic data=yufan.task1;
Title 'Crude logistic regression of the effect of gender on quizscore';
Class gender (PARAM=REF REF='Male') quizscore (PARAM=REF REF='Fail');
Model quizscore=gender;                           
Run; 

/*                                                The LOGISTIC Procedure

                                                Odds Ratio Estimates

                                                          Point          95% Wald
                              Effect                   Estimate      Confidence Limits

                              gender Female vs Male       0.843       0.648       1.097

/* Interpretation:

The odds of women passing the quiz is 0.843 times that of men (95% CL 0.648, 1.097) */

Proc Logistic data=yufan.task1;
Title 'Crude logistic regression of the effect of age on quizscore';
Class age (PARAM=REF REF='Under 18') quizscore (PARAM=REF REF='Fail');
Model quizscore=age;                           
Run; 

/*                                                The LOGISTIC Procedure

                                                Odds Ratio Estimates

                                                             Point          95% Wald
                           Effect                         Estimate      Confidence Limits

                           age 18-29       vs Under 18       1.580       0.559       4.462
                           age 30-39       vs Under 18       1.569       0.558       4.406
                           age 40-49       vs Under 18       1.662       0.593       4.660
                           age 50-59       vs Under 18       1.723       0.614       4.836
                           age 60-69       vs Under 18       1.920       0.669       5.507
                           age 70 or Older vs Under 18       2.059       0.632       6.703


/* Interpretation:

The odds of individuals who were older than 18 (take 30-39 age group as an example) passing the quiz 
is 1.569 times that of those who were under 18 (95% CL 0.558, 4.406) */

Proc Logistic data=yufan.task1;
Title 'Crude logistic regression of the effect of text or talk with phone on quizscore';
Class q7 (PARAM=REF REF='no') quizscore (PARAM=REF REF='Fail');
Model quizscore=q7;                           
Run;

/*                                                The LOGISTIC Procedure

                                                Odds Ratio Estimates

                                                          Point          95% Wald
                              Effect                   Estimate      Confidence Limits

                                 q7 yes     vs no       0.776       0.530       1.137

/* Interpretation:

The odds of people who text or talk with phone passing the quiz is 0.776 times that of those who
do not (95% CL 0.530, 1.137) */


Proc Logistic data=yufan.task1;
Title 'Effect of gender on quizscore, controlling for age and text or talk with phone';
Class gender (PARAM=REF REF='Male') age (PARAM=REF REF='Under 18') quizscore (PARAM=REF REF='Fail') q7 (PARAM=REF REF='no');
Model quizscore=gender age q7/ lackfit;
Run; 

*Gender may or may not be a confounder;

/*                                                The LOGISTIC Procedure

                                                 Odds Ratio Estimates

                                                               Point          95% Wald
                          Effect                            Estimate      Confidence Limits

                          gender Female vs Male                0.840       0.645       1.095
                          age    20-29       vs Under 18       1.271       0.411       3.929
                          age    30-39       vs Under 18       1.259       0.409       3.875
                          age    40-49       vs Under 18       1.331       0.433       4.087
                          age    50-59       vs Under 18       1.380       0.449       4.243
                          age    60-69       vs Under 18       1.533       0.489       4.807
                          age    70 or Older vs Under 18       1.653       0.468       5.831
                          q7     yes     vs no                 0.733       0.494       1.085



                                       Hosmer and Lemeshow Goodness-of-Fit Test

                                          Chi-Square       DF     Pr > ChiSq

                                              2.5381        8         0.9599





/*Interpretation:

Explanatory Models
1. Include potential confounders and exclude intermediate variables.
2. Describe a magnitude of effect.


Controlling for age and text or talk with phone, the odds of women passing the quiz is 0.840 times that of men
(95% CL[AOR] 0.645, 1.095).

-----------------

Predictive Models
1. May or may not include potential confounders, but do not include intermediate variables.
2. Describe the direction of the effect estimate.


Females seemed to be LESS LIKELY to pass the driving exam than men (AOR=0.840, 95% CL 0.645, 1.095).
In addition, individuals who were older than 18 (take 30-39 age group as an example) seemed to be MORE LIKELY to pass 
the driving exam than those who were under 18 (AOR=1.259 95% CL 0.409, 3.875). What's more, people who text or talk 
with phone seemed to be LESS LIKELY to pass the driving exam (AOR=0.733 95% CL 0.494, 1.085). However, all of the 
test statistics were not significant.

According to Hosmer and Lemeshow Goodness-of-Fit Test, we didn't found sufficient evidence to suggest that this 
logistic regression model was not a good fit of the relationship between exposures and outcome 
(Chi-Square=2.5381, df=8, P=0.9599).

*/

