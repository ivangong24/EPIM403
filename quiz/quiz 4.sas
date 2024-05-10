/************************************************************
Program name: "E:\quiz4.sas"
Programmer's name: Yufan Gong
Creation Date: 2/16/2020
Purpose: To complete takehome quiz4
************************************************************/

Title "Yufan Gong (Tuesday Lab)";
Libname yufan "E:\";

Data yufan.a;
Length Beer Outcome Exposure $ 17;
Input Beer $ Outcome $ Exposure $ Count;
Datalines;
Beer_drinkers 1-Obese 1-Spicy_food 65
Beer_drinkers 1-Obese 2-No_Spicy_food 46
Beer_drinkers 2-Not_Obese 1-Spicy_food 215
Beer_drinkers 2-Not_Obese 2-No_Spicy_food 430
Non_Beer_drinkers 1-Obese 1-Spicy_food 89
Non_Beer_drinkers 1-Obese 2-No_Spicy_food 75
Non_Beer_drinkers 2-Not_Obese 1-Spicy_food 298
Non_Beer_drinkers 2-Not_Obese 2-No_Spicy_food 611
;
Run;

Proc Freq Data=yufan.a;
Title2 "Task 1";
Tables Beer*Exposure*Outcome/All;
Weight Count;
Run;

/* After controlling for the effect of beer drinking, the risk of obesity among
people who ate spicy food was 2.22 times that of people who didn't eat spicy food 
(RR= 2.2189 95% CL: (1.7837, 2.7604)). According to Breslow-Day Test for Homogeneity, 
the stratified RR is similar (X^2=0.3045, df=1, P=0.5811), so we can be comfortable 
in combining these two tables.*/

Data yufan.b;
Input Chlamydia $ Year $ Count @@;
Datalines;
Cases 2014 23766 Cases 2015 25764 Cases 2016 28299 Cases 2017 31501 Cases 2018 33493
Noncases 2014 10024642 Noncases 2015 10071273 Noncases 2016 10092241 Noncases 2017 10087258 Noncases 2018 10072025
;
Run;

Proc Freq Data=yufan.b;
Title2 "Task 2";
Tables Chlamydia*Year/ Trend;
Weight Count;
Run;

/* There is a positive trend between Chlamydia cases and year, 
i.e. the cases of Chlamydia increases as time goes by.
(Z=46.5144, P<0.001)*/

OPTIONS FMTSEARCH=(yufan);
Proc Format LIBRARY=yufan;
Value $GENDERft    "1"       = "Male"
                   "2"       = "Female";
Value $RACEft      "H"       = "Hispanic"
                   "B"       = "Black"
			       "W"       = "White"
			       "A"       = "Asian";
Value CENTERft      1        = "Central HC"
                    2        = "Pomona HC";
Value $DISTRICTft  "E"       = "East"
                   "A"       = "Antelope Valley"
			       "M"       = "Metro";
Value AGEft        low-24    = "<25 years old"
                   25-high   = ">=25 years old";
Run;

Data yufan.c;
Input @1  ID       $2.
      @3  GENDER   $1.
	  @4  RACE     $1.
	  @5  CENTER   1.
	  @6  DISTRICT $1.
	  @7  VISIT    MMDDYY8.
	  @15 AGE      2.
	  @17 COST     5.;

      NEWCOST=COST*0.01;
	  Drop COST;

Label ID          = "Patient ID"
      GENDER      = "Gender"
      RACE        = "Race/Ethnicity"
	  CENTER      = "Center"
	  DISTRICT    = "District"
	  VISIT       = "Date of visit"
	  AGE         = "Age group"
	  NEWCOST     = "Cost of visit"
;
FORMAT GENDER      $GENDERft. 
       RACE        $RACEft.
	   CENTER      CENTERft.
	   DISTRICT    $DISTRICTft.
       VISIT       MMDDYY10.
	   AGE         AGEft.
	   NEWCOST     dollar7.2
;
Datalines;
101H2M051220192712654
122B2A022120191612054
131H1E041520192811435
142W2M042020191710111
152A2E061620193511202
171W1A092120194510254
191B1M110220192810425
;
Run;

Proc Contents Data=yufan.c position;
Run;

Proc Print Data=yufan.c noobs double label;
Title2 "Task 3";
Run;

/*****************************************************************
Data yufan.d;
Set yufan.c;
Label VISIT    = "Date of Patient Visit (new label)"
      AGE      = "Age"
      NEWCOST  = "Cost of Visit (Dollars and cents)"
	  ;
Format AGE;
Run;

Proc Print Data=yufan.d noobs double n="No. observations: " label;
Title2 "Task 4";
Sum NEWCOST;
Run;
*****************************************************************/
