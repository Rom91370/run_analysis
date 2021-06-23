# run_analysis

First step is to merge the data. I use rbind function to merge the data from the txt file : X_train and X_test (which are the observations).
I do the same with the txt file Y_train and Y_test (which are the activity).

Then i combine activity with observations with the function cbind

Second step I use the function grep on the txt file features to know which columns I need to keep if I want only the mean and standard deviation columns
Then I use select function the keep the right columns

Third step the number 1 to 6 by the related activity

4th step I use the funtion setNames to rename the columns by the name of the features

5th step I add a subject column then I use the function group_by to get the data arrange by activity and subject
Finaly I use the function summarise_each to get the mean of each observations for each activity abd subject.
