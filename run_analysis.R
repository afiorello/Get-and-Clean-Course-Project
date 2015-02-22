######## SET-UP #################

rm(list=ls()) # to clear your workspace.

########## LOAD PACKAGES ##################

library(dplyr)
#install.packages ("tidyr") #tidy you data with tidyr package
library (tidyr)
# http://vita.had.co.nz/papers/tidy-data.pdf by Hadley Wickham 
#install.packages ("stringi") # dependency, not sure if it is auto load
library (stringi)

########## DOWN LOAD FILES ##################

setwd("~/Desktop/R Programs/data/") #sets working directory

#remove 's' in "https"
dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "fit_data.zip")
unzip("fit_data.zip", exdir = "GC_course_proj_data")

############ LOAD COMMON VARIABLES ####################

setwd("~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset") #sets working directory
var_names<-read.table("features.txt") #loads table of variable(column) names
temp<-select(var_names, V2) #loads data(variable names) in column V2 
act_labs<-read.table("activity_labels.txt") #loads table of the 6 activities

############ MERGE TEST DATA ####################

setwd("~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/test") #sets working directory
test_data<-read.table("X_test.txt") #loads test data
#test_data_temp<-test_data[1:6,1:6]
#names(test_data_temp)

names(test_data)<-temp[1:561,] #set column names

test_subs<-read.table("subject_test.txt") #load table with sujects' referance numbers
names(test_subs)<-"subjects" #sets column name

test_labs<-read.table("y_test.txt") #loads table of referance numbers of the 6 activies

# procedure to match referance number in 1st column test_lab to activity name and place activity 
# name in new second column test_labs
for (i in seq_along(test_labs[,1])){
        for (j in seq_along(act_labs[,1])){
                if (test_labs[i,1]==act_labs[j,1]){
                        test_labs[i,2]<-act_labs[j,2]
                }
        }        
}
names(test_labs)[2]<-"activities" #sets name of new column

#the final test data merge
test_final<-cbind(test_subs, select(test_labs,activities), test_data)

############ MERGE TRAINING DATA ####################

setwd("~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/train") #sets working directory

train_data<-read.table("X_train.txt") #loads test data
names(train_data)<-temp[1:561,] #set column names

train_subs<-read.table("subject_train.txt") #load table with sujects' referance numbers
names(train_subs)<-"subjects" #sets column name

train_labs<-read.table("y_train.txt") #loads table of referance numbers of the 6 activies

# procedure to match referance number in 1st column test_lab to activity name and place activity 
# name in new second column train_labs
for (i in seq_along(train_labs[,1])){
        for (j in seq_along(act_labs[,1])){
                if (train_labs[i,1]==act_labs[j,1]){
                        train_labs[i,2]<-act_labs[j,2]
                }
        }        
}
names(train_labs)[2]<-"activities" #sets name of new column

#the final training data merge
train_final<-cbind(train_subs, select(train_labs,activities), train_data)

############ MERGE TEST & TRAINING DATA ####################

final<-rbind(test_final, train_final)

############ EXTRACTS MEAN & STANDARED DEV #################

# Make valid and unique column names
fin_colNames<-colnames(final)
colnames(final)<-make.names(fin_colNames, unique = TRUE, allow_ = TRUE)

final_mean_std<-final %>% select(subjects, activities, contains("std"), contains("mean"))

##############  SUMMARIZES TIDY DATA ##################

by_act_sub<-final_mean_std %>% group_by(activities, subjects) #groups data by activities & subjects
by_act_sub_sum <- by_act_sub %>% summarise_each(funs(mean)) #summarizes mean fo each variable by 6 activities

##############  WRITES SUMMARIZED TIDY DATA TO TEXT FILE ##################

setwd("~/Desktop/R Programs/data/GC_course_proj_data/UCI_HAR_Dataset/") #sets working directory
write.table(by_act_sub_sum, file="final_means.txt", row.names=FALSE)
# to see nicely formated data set, try View(by_act_sub_sum)

########################### END ###########################
