Code description for run_analysis.R

The following explains the 10 step process used to transform Human Activity Recognition Using Smartphones Data Set 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to final_means.txt

1. SET-UP

  a. Uses rm(list=ls()) to clear variables from workspace.

2. LOAD PACKAGES 

  a. Loads and installs the following packages used to process the data sets: dplyr, tidyr, and stringi.

3. DOWN LOAD FILES

  a. Sets working directory to "~/Desktop/R Programs/data/"
  b. Downloads data set form "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  c. Writes file to working directory.
  d. Unzips file.

4. LOAD COMMON VARIABLES

  a. Sets working directory to "~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset")
  b. Loads table of variables(columns) from file to local variable table
  c. Loads variable names to column V2 in local variable table 
  c. Loads 6 activities from file to local variable table  

5. MERGE TEST DATA

  a. Sets working directory to "~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/test"
  b. Loads test data from file in local variable table
  c. Sets column names form table describled in 5b.
  d. Load table with subjects' referance numbers
  e. Set column name to "subjects"
  f. Loads table of referance numbers of the 6 activies
  g. Runs procedure (nested for loops) to match referance number in 1st column test_lab to activity name and place activity         name in new second column test_labs
  h. Sets "activities" as name of new column
  g. Uses cbind to merge local variables


6. MERGE TRAINING DATA

  a. Sets working directory to "~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/train"
  b. Loads test data from file in local variable table
  c. Sets column names form table describled in 5b.
  d. Load table with subjects' referance numbers
  e. Set column name to "subjects"
  f. Loads table of referance numbers of the 6 activies
  g. Runs procedure (nested for loops) to match referance number in 1st column test_lab to activity name and place activity         name in new second column test_labs
  h. Sets "activities" as name of new column
  g. Uses cbind to merge local variables

7. MERGE TEST & TRAINING DATA

 a. Uses rbind to merge final test and training variables

8. EXTRACTS MEAN & STANDARED DEV

  a. Makes valid and unique column names
  b. Extracts "subject", "activities" variables and variables containing the string "mean" or " std" from the combined test and      traning to form new local variable 
  
9.  SUMMARIZES TIDY DATA
  
  a. Groups data by "activities" and "subjects"
  b. Calulates (summarizes) mean of remaining variables by grouping above.

10.  WRITES SUMMARIZED TIDY DATA TO TEXT FILE

  a. Sets working directory to "~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/
  b. Writes summerized tidy data variable from 9b to "final_means.txt"

END

codeBk<-data.frame(names(by_act_sub_sum))
View(codeBk)
write.table(codeBk, file="code_book.txt", row.names=FALSE)

