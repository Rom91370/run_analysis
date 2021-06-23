##1.Merges the training and the test sets to create one data set.

xtestdf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/test/X_test.txt")
View(xtestdf)
dim(xtestdf)

xtraindf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/train/X_train.txt")
View(xtraindf)
dim(xtraindf)

df<-rbind(xtestdf,xtraindf)
dim(df)
View(df)


subjecttraindf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/test/subject_test.txt")
View(subjecttraindf)

subjecttestdf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/train/subject_train.txt")
View(subjecttestdf)

ytraindf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecourseraGetting and cleaning data/UCI HAR Dataset/train/y_train.txt")
dim(ytraindf)
View(ytraindf)
ytestdf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/test/y_test.txt")
dim(ytestdf)
View(ytestdf)

dfactivity<-rbind(ytestdf,ytraindf)
dim(dfactivity)

completedf<-cbind(df,dfactivity)
dim(completedf)

##2.Extracts only the measurements on the mean 
##  and standard deviation for each measurement. 
featuresdf<-read.table(file = "C:/Users/Romain/Desktop/datasciencecoursera/Getting and cleaning data/UCI HAR Dataset/features.txt")
View(featuresdf)
x<-grep("mean\\()|std()",featuresdf[,2])
colmeanstrd<-grep("mean\\()|std()",featuresdf[,2])
meanstddf<-select(completedf,colmeanstrd)
View(meanstddf)
dim(meanstddf)

##3.Uses descriptive activity names to name the activities in the data set
activity<-cbind(dfactivity,meanstddf)

activity[,1][activity[,1]=="1"]<-"WALKING"
activity[,1][activity[,1]=="2"]<-"WALKING_UPSTAIRS"
activity[,1][activity[,1]=="3"]<-"WALKING_DOWNSTAIRS"
activity[,1][activity[,1]=="4"]<-"SITTING"
activity[,1][activity[,1]=="5"]<-"STANDING"
activity[,1][activity[,1]=="6"]<-"LAYING"
View(activity)

##4. Appropriately labels the data set with descriptive variable names. 
nameslist<-featuresdf[featuresdf[,1] %in% x,]
nameslist[,2]
nameslist2<-c("activity",nameslist[,2])
nameslist2
activityrenames<-setNames(activity,nameslist2)
View(activityrenames)

##5. From the data set in step 4, creates a second, 
##   independent tidy data set with the average of 
##   each variable for each activity and each subject.

subejectdf<-rbind(subjecttestdf,subjecttraindf)
df<-cbind(subejectdf,activityrenames)
View(df)
nameslist3<-c("subject",nameslist2)
df<-setNames(df,nameslist3)

groupdf<-group_by(df,activity,subject)
View(groupdf)
meandf<-summarise_each(groupdf,mean)

View(meandf)
