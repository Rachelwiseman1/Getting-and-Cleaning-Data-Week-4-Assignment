library(dplyr)

# 0. Set up for analysis

## Set working directory as UCI HAR Dataset

setwd("your_working_directory/UCI HAR Dataset")

## read in description of features
features <- read.table("./features.txt") 

## read in activity labels 
activity_labels <- read.table("./activity_labels.txt") 

## read in train data 
X_train<-read.table("./train/X_train.txt")
Y_train<-read.table("./train/Y_train.txt") 
subject_train<-read.table("./train/subject_train.txt")

## read in test data 
X_test<-read.table("./test/X_test.txt")
Y_test<-read.table("./test/Y_test.txt") 
subject_test<-read.table("./test/subject_test.txt")

# 1. Merge the training and the test sets to create one dataset

X_total<-rbind(X_train,X_test)
Y_total<-rbind(Y_train,Y_test)
subject_total<-rbind(subject_train,subject_test)

# 2. Extract only the measurements on mean and s.d for each measurement

selected_variables<-features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
X_total<-X_total[,selected_variables[,1]]

# 3. Descriptive activity names to name the activities in the data set

## rename column in Y_total
colnames(Y_total)<-"activity"

## add describtive column
Y_total$activity_label <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))

# 4. label the data set with descriptive variable names

## rename column in X_total
colnames(X_total)<-selected_variables[,2]

## rename column in subject_total
colnames(subject_total) <- "subject"

# 5. Create a second, independent tidy dataset with the average of each variable for each activity and each subject

## merge to create final dataset
total <- cbind(X_total, Y_total, subject_total)

## turn activities and subjects into factors 
total$activity <- factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2])
total$subject  <- as.factor(total$subject) 

## create mean column
total_mean <- total %>% 
  group_by(activity, subject) %>% 
  summarize_all(funs(mean)) 

## export final dataset
write.table(total_mean, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE) 
