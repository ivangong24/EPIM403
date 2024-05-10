/************************************************************
Program name: "E:\midterm\midterm1.sas"
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

Value $genderft 'M'    = 'Male'
                'F'    = 'Female';
Value raceft     1     = 'Hispanic/Latino/Chicano'
	             2     = 'African American/Black'
				 3     = 'White (non-Hispanic)'
				 4     = 'Asian'
				 5     = 'Other/Mixed Race/Ethnicity'
				 6     = 'Refused';
Value clinicft   1     = 'Weight Reduction'
	             2     = 'Sexual Health';
Value todayft    1     = 'Normal'
	             2     = 'High'
				 3     = 'Low';
Value historyft  1     = 'Yes'
                 2     = 'No';
Value hbpft      1     = 'Hypertension'
                 2     = 'Normal blood pressure'
                 3     = 'Hypotension';
Value spaft      1     = 'Antelope Valley' 
	             2     = 'San Fernando Valley'
				 3     = 'Gabriel Valley'
				 4     = 'Metro'
				 5     = 'West'
				 6     = 'South'
				 7     = 'East'
				 8     = 'South Bay';
Value ageft      10-19 = '10-19 years old'
	             20-29 = '20-29 years old'
                 30-39 = '30-39 years old'
				 40-49 = '40-49 years old'
				 50-59 = '50-59 years old'
				 60-69 = '60-69 years old';
Run;

Data yufan.midterm1;
Set yufan.table1_021820;
age = ROUND(YRDIF(dob, datetest, 'ACTUAL'));

Label id       = 'Client ID Number'
      gender   = 'Gender'
      dob      = 'Date of Birth'
	  race     = 'Race/Ethnicity'
	  clinic   = 'Clinic Type'
	  today    = 'Blood pressure today'
	  datetest = 'Date Tested'
	  hbp      = 'Hypertension history'
	  diabetes = 'Diabetes history'
	  choles   = 'High cholesterol history'
	  alcohol  = 'Alcoholism history'
	  drug_use = 'Drug use history'
	  asthma   = 'Asthma history'
	  trich    = 'Trichomonas vaginalis history'
	  chl      = 'Chlamydia infection history'
	  gc       = 'Gonorrhea infection history'
	  hbp_test = 'HBP Test'
	  spa      = 'Service Planning Area'
      age      = 'Age';

Format gender    genderft.
       dob       weekdate17.
       race      raceft.
	   clinic    clinicft.
	   today     todayft.
	   datetest  weekdate17.
	   hbp       historyft.
	   diabetes  historyft.
	   choles    historyft.
       alcohol   historyft.
       drug_use  historyft.
       asthma    historyft.
	   trich     historyft.
	   chl       historyft.
	   gc        historyft.
       hbp_test  hbpft.
	   spa       spaft.
       age       ageft.;
Run;

Proc Contents data=yufan.midterm1 position;
Run;

Proc Freq data=yufan.midterm1;
Tables gender--age;
Title2 'Frequency distribution';
Run;

Proc Freq data=yufan.midterm1;
Tables gender*diabetes/chisq;
Title2 'Chi-square test between gender and diabetes';
Run;

/*Based on the result, there is no sufficient evidence suggests that
 diabetes is associated with gender (Chi-square=0.0285, df=1, P=0.8659)*/

Proc Freq data=yufan.midterm1;
Tables race*diabetes/chisq;
Title2 'Chi-square test between race and diabetes';
Run;

/*Based on the result, there is evidence suggests that 
diabetes is associated with race (Chi-square=12.0439, df=3, P=0.0072)*/

Proc Freq data=yufan.midterm1;
Tables age*diabetes/chisq;
Title2 'Chi-square test between age and diabetes';
Run;

/*Based on the result, there is no sufficient evidence suggests that 
diabetes is associated with age (Chi-square=7.2599, df=3, P=0.0641)*/

Proc Freq data=yufan.midterm1;
Tables gender*diabetes/cmh;
Title2 'Crude table between gender and diabetes';
Run;

/*The odds of diabetes among female patients is 0.9391 times that of male
patients (OR=0.9391, 95% CL:(0.4527, 1.9480))*/

Proc Freq data=yufan.midterm1;
Tables alcohol*diabetes/cmh;
Title2 'Crude table between alcoholism and diabetes';
Run;

/*The odds of diabetes among patients with alcoholism history is 0.1612 times
that of patients did not drink alcohol(OR=0.1612, 95% CL:(0.0215, 1.2074))*/

Proc Freq data=yufan.midterm1;
Tables drug_use*diabetes/cmh;
Title2 'Crude table between drug use and diabetes';
Run;

/*The odds of diabetes among patients who use drugs is 0.2877 times
that of patients did not use drugs(OR=0.2877, 95% CL:(0.0669, 1.2379))*/

Proc Freq data=yufan.midterm1;
Tables gender*drug_use*diabetes/All;
Title2 'Adjusted table between drug use and diabetes, gender as potential confounder';
Run;

/* After controlling for gender, the odds of diabetes among
patients with drug use was 0.3136 times that of patients who didn't use drugs 
(OR= 0.2879 95% CL: (0.0669, 1.2395)). According to Breslow-Day Test for Homogeneity, 
the stratified OR is similar (chi-square=0.0804, df=1, P=0.7767).*/
