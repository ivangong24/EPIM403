/*****************************************
Program name: "E:\quiz 3.sas"
Programmer's name: Yufan Gong
Creation Date: 2/7/2020
Purpose: To complete quiz 3
*****************************************/
Title1 "Yufan Gong (Tuesday Lab)";
libname yufan "E:\";
Data yufan.a;
Length before after $ 12;
Input before $ after $ count1;
Datalines;
1-before_yes 2-after_no 96
1-before_yes 1-after_yes 232
2-before_no 2-after_no 78
2-before_no 1-after_yes 140
;
Run;
Proc Freq data=yufan.a;
Title2 "Examining the change of people's attitudes towards vaping before and after workshop presentation";
Tables before*after/agree;
Weight count1;
Run;

/*We conclude that the workshop presentation was effective in changing people's 
attitudes towards vaping (S=8.2034, df=1, p=0.0042)*/

Title2;
Data yufan.b;
Length exposure outcome $ 20;
Input exposure $ outcome $ count2;
Datalines;
non_cell_users 1-type_2_diabetes 177
cell_users 1-type_2_diabetes 462
non_cell_users 2-no_type_2_diabetes 1507
cell_users 2-no_type_2_diabetes 957
;
Run;
Proc Contents data=yufan.b position;
Run;
Proc Freq data=yufan.b;
Title2 "Examining the association between cell phone use and Type 2 diabetes";
Tables exposure*outcome/cmh;
Weight count2;
Footnote "UCLA Fielding School of Public Health / Department of Epidemiology";
Run;

/*The odds of Type 2 diabetes among cell phone users were 4.11 times that of those who 
don't use cell phones. (OR= 4.1103, 95% CL:(3.3947, 4.9766))*/

/*Assume the data come from a cohort study: The risk of Type 2 diabetes among cell phone 
users was 3.10 times that of non-cell phone users. (RR= 3.0976, 95% CL:(2.6444, 3.6286))*/

/*Assume the data come from a cohort study: The risk of not having Type 2 diabetes among
cell phone users was 0.75 times that of non-cell phone users. (RR= 0.7536, 95% CL:(0.7243, 0.7841))*/

Data yufan.c;
Input Sex $ Status $ count3;
Datalines;
Female Alive 414
Female Dead 173
Male Alive 214
Male Dead 199
;
Run;
Proc Freq data=yufan.c;
Title2 "Task 3: The risk of dying in the Cohort Study Examing High Fat Consumption";
Tables Sex*Status/cmh nocol norow;
Weight count3;
Footnote "EPIDEM M403 -- Frequency Counts";
Run;


/*The risk of dying among females who comsume high fat food was 0.61 times that of males 
who comsume high fat food.(RR= 0.6117, 95% CL:(0.5211, 0.7179))*/
