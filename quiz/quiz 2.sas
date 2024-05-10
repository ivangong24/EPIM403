/************************************************************
Program name: "E:\quiz2.sas"
Programmer's name: Yufan Gong
Creation Date: 2/1/2020
Purpose: To complete takehome quiz2
************************************************************/
Title "Yufan Gong (Tuesday Lab)";
libname yufan "E:\";
options pageno=1;
options nodate formdlim = -;
Proc contents data=yufan.newheart;
run;
Proc Means N Mean CLM Q1 Qrange Max Maxdec=1 data=yufan.newheart;
Title2 "Question 2: Numeric variables with 95% CLs by gender and status, respectively";
Var Ageatstart weight systolic diastolic;
Class sex Status;
Run;
Proc Means N Nmiss Mean CLM Alpha=0.2 Qrange P80 CV Min Maxdec=0 data=yufan.newheart;
Title2 "Question 3: Means and 80% CLs for variables: age, weight, systolic, and diastolic";
Var Ageatstart weight systolic diastolic;
Run;
Proc Means N Nmiss Mean CLM Alpha=0.01 Qrange P80 CV Min Maxdec=0 data=yufan.newheart;
Title2 "Question 4: Means and 99% CLs for variables: age, weight, systolic, and diastolic";
Var Ageatstart weight systolic diastolic;
Run;
/*Q6 a*/
Proc Means Nmiss Mean CLM Alpha=0.2 Median Qrange CV Min Maxdec=0 data=yufan.newheart;
Title2 "Question 6a: Ageatstart scores by smoking status";
Var Ageatstart;
Class Smoking_status;
Run;
/*Q6 b*/
Proc Univariate Plot data=yufan.newheart;
Title2 "Question 6b: Cholesterol stats";
Var Cholesterol;
Run;
