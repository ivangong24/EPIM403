/************************************************************
Program name: "E:\midterm\midterm2.sas"
Programmer's name: Yufan Gong
Creation Date: 2/27/2020
Purpose: To complete midterm
************************************************************/

Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\midterm";

options pageno   =  1;
options formdlim = '-';
options fmtsearch=(yufan);

Proc Format Library=yufan;

Value genderft   0     = 'Male'
                 1     = 'Female';
Value raceft     1     = 'Hispanic'
                 2     = 'Asian'
			     3     = 'African-American'
			     4     = 'White';
Value sesft      1     = 'Low'
                 2     = 'Medium'
			     3     = 'High';
Value $schtypeft 'pub' = 'Public'
                 'pri' = 'Private';
Value progft     1     = 'General'
                 2     = 'Academic Preparatory'
				 3     = 'Vocational/Technical';
Value scoreft    0-63  = 'Fail'
                 64-99 = 'Pass';
Run;

Data yufan.midterm2;
set yufan.hsb2020new;

Label id      = 'ID number'
      female  = 'Gender'
	  race    = 'Race/Ethnicity'
	  ses     = 'Socioeconomic status'
	  schtype = 'School type'
	  prog    = 'High school Program'
	  read    = 'Standardized reading score'
	  write   = 'Standardized writing score'
	  math    = 'Standardized math score'
	  science = 'Standardized science score'
	  socst   = 'Standardized social studies score'
	  ;
Format female      genderft.
       race        raceft.
	   ses         sesft.
	   schtype     $schtypeft.
	   prog        progft.
	   read--socst scoreft.
	   ;
Run;

Proc Contents data=yufan.midterm2 position;
Run;

Proc Freq data=yufan.midterm2;
Tables female--socst;
Title2 'Frequency distribution';
Run;

Proc Freq data=yufan.midterm2;
Tables female*math/chisq;
Title2 'Chi-square test between gender and standardized math score';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 math score is associated with gender (Chi-square=1.2392, df=1, P=0.2656)*/

Proc Freq data=yufan.midterm2;
Tables race*math/chisq;
Title2 'Chi-square test between race and standardized math score';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 math score is associated with gender (Chi-square=4.0919, df=3, P=0.2517)*/

Proc Freq data=yufan.midterm2;
Tables ses*math/chisq;
Title2 'Chi-square test between socioeconomic status and standardized math score';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 math score is associated with gender (Chi-square=0.4149, df=2, P=0.8127)*/

Proc Freq data=yufan.midterm2;
Tables schtype*math/chisq;
Title2 'Chi-square test between school type and standardized math score';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 math score is associated with gender (Chi-square=0.5935, df=1, P=0.4411)*/

Proc Freq data=yufan.midterm2;
Tables prog*math/chisq;
Title2 'Chi-square test between high school program and standardized math score';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 math score is associated with gender (Chi-square=2.3112, df=2, P=0.3149)*/

Proc Freq data=yufan.midterm2;
Tables female*math/cmh;
Title2 'Crude table between gender and math score';
Run;

/*The odds of failing in math among students who failed in reading is 0.5288 times that 
of students who passed reading exam (OR=0.5288, 95% CL:(0.1714, 1.6314))*/

Proc Freq data=yufan.midterm2;
Tables read*math/cmh;
Title2 'Crude table between standardized reading and math score';
Run;

/*The odds of failing in math among students who failed in reading is 3.75 times that 
of students who passed reading exam (OR=3.7500, 95% CL:(1.1601, 12.1218))*/

Proc Freq data=yufan.midterm2;
Tables read*socst/cmh;
Title2 'Crude table between standardized reading and social studies score';
Run;

/*The odds of failing in social studies among students who failed in reading is 4.5873 times 
that of students who passed reading exam (OR=4.5873, 95% CL:(1.3889, 15.1514))*/

Proc Freq data=yufan.midterm2;
Tables female*read*math/All;
Title2 'Adjusted table between standardized reading and math score, gender as potential confounder';
Run;

/* After controlling for gender, the odds of failing in math among students 
who failed in reading is 3.4382 times that of students who passed reading exam
(OR= 3.4382 95% CL: (1.0762, 10.9839)). According to Breslow-Day Test for Homogeneity, 
the stratified OR is similar (chi-square=1.8273, df=1, P=0.1764).*/

