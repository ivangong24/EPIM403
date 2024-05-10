/************************************************************
Program name: "E:\quiz 8.sas"
Programmer's name: Yufan Gong
Creation Date: 3/20/2020
Purpose: To complete quiz 8
************************************************************/
Title "Yufan Gong (Tuesday Lab)";

Libname yufan "E:\";

option fmtsearch=(yufan);

Proc Format library=yufan;

Value age 0-39  = "Young"
          40-62 = "Old";
Run;

Data yufan.quiz8;
Set yufan.heart1;
Format AgeAtStart age.;
Run;

Proc Logistic data=yufan.quiz8;
Class sex (PARAM=REF REF="Male") AgeAtStart (PARAM=REF REF="Old")
      Chol_Status (PARAM=REF REF="High") Smoking_Status (PARAM=REF REF="Non-smoker") 
	  Status (PARAM=REF REF="Alive");
Model Status = Sex AgeAtStart Chol_Status Smoking_Status / lackfit;
Run;

*Sex may or may not be a confounder;

/*                                                The LOGISTIC Procedure

                                                 Odds Ratio Estimates

                                                                       Point          95% Wald
                  Effect                                            Estimate      Confidence Limits

                  Sex            Female vs Male                        0.539       0.472       0.616
                  AgeAtStart     Young vs Old                          0.201       0.173       0.233
                  Chol_Status    Borderline vs High                    0.679       0.590       0.782
                  Chol_Status    Desirable  vs High                    0.641       0.546       0.754
                  Smoking_Status Heavy (16-25)     vs Non-smoker       1.452       1.224       1.722
                  Smoking_Status Light (1-5)       vs Non-smoker       1.037       0.841       1.279
                  Smoking_Status Moderate (6-15)   vs Non-smoker       1.388       1.125       1.712
                  Smoking_Status Very Heavy (> 25) vs Non-smoker       1.802       1.431       2.269



                                       Hosmer and Lemeshow Goodness-of-Fit Test

                                          Chi-Square       DF     Pr > ChiSq

                                              6.2460        7         0.5113


/*Interpretation:

Explanatory Models
1. Include potential confounders and exclude intermediate variables.
2. Describe a magnitude of effect.


Controlling for age, cholesterol status and smoking status, the odds of women staying alive
is 0.539 times that of men (95% CL[AOR] 0.472, 0.616).

-----------------

Predictive Models
1. May or may not include potential confounders, but do not include intermediate variables.
2. Describe the direction of the effect estimate.


Females (AOR=0.539, 95% CL 0.472, 0.616), younger people (below 40, AOR=0.201, 95% CL 0.173, 0.233), 
people with borderline (AOR=0.679, 95% CL 0.590, 0.782) or desirable cholesterol status 
(AOR=0.641, 95% CL 0.546, 0.754) seemed to be LESS LIKELY to have died.
However, individuals who smoke moderate (AOR=1.388, 95% CL 1.125, 1.712), heavy (AOR=1.452, 95% CL 1.224, 1.722)
or very heavy (AOR=1.802, 95% CL 1.431, 2.269) seemed to be MORE LIKELY to have died.

According to Hosmer and Lemeshow Goodness-of-Fit Test, we didn't found sufficient evidence to suggest that this 
logistic regression model was not a good fit of the relationship between exposures and outcome 
(Chi-Square=6.2460, df=7, P=0.5113).
*/


/*
Question1: Why did the SAS Institute choose January 1, 1960 as the starting point for its SAS dates?

Answer: The founders of SAS wanted to use the approximate birth date of the IBM 370 system, and they chose
January 1, 1960 as an easy-to-remember approximation.

Reference: https://support.sas.com/publishing/pubcat/chaps/59411.pdf

Question2: Differentiate between PROC MEANS and PROC SUMMARY

Answer: The main difference concerns the default type of output they produce. Proc MEANS by default produces printed 
output in the LISTING window or other open destination whereas Proc SUMMARY does not. Inclusion of the print option 
on the Proc SUMMARY statement will output results to the output window.

The second difference between the two procedures is reflected in the omission of the VAR statement. When all variables 
in the data set are character the same output: a simple count of observations, is produced for each procedure. However, 
when some variables in the dataset are numeric, Proc MEANS analyses all numeric variables not listed in any of the other 
statements and produces default statistics for these variables (N, Mean, Standard Deviation, Minimum and Maximum).

Reference: https://amadeus.co.uk/tips/basic-differences-between-proc-means-and-proc-summary/

Question3:  In the logistic regression model statement, what does the FIRTH option do?

Answer:  FIRTH option is used to analyze results from the usual unconditional, conditional, and exact conditional logistic regression.

Reference: https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_logistic_sect063.htm

*/
