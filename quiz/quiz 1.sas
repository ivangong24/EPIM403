/************************************************************
Program name: Quiz 1
Programmer's name: Yufan Gong
Creation Date: 1/25/2020
Purpose: To complete takehome quiz1
************************************************************/

Title1 Yufan Gong(Tuesday Lab);
Data clinic;
      Infile "E:\center.txt" PAD;
	  Input #1 @1  ID            1.
	           @2  Last         $7.
			   @10 Age           2.
			   @13 SPA          $15.
			#2 @2  Clinic       $15.
			   @20 Visit_date    MMDDYY10.
			#3 @2  STD          $1.
			   @6  Treat_date    MMDDYY10.
			#4 @2  Counsel       MMDDYY10.
			;
	  Format Visit_date MMDDYY10.
             Treat_date DDMMYY10.
			 Counsel    MMDDYY10.;
Run;

Proc Contents data=clinic varnum;
Run;

Proc Print data=clinic noobs double n="Total number of observations: ";
Id SPA;
Title2 "Clinic data";
Run;

/************************************************************
SAS program that would produce each figure in the Task2.pdf: 
Proc Gchart data=clinic;
hbar STD / type=pct nostat;
Run;
Quit;
Proc Freq data=clinic;
Tables SPA*STD / crosslist missing;
Run;
************************************************************/
