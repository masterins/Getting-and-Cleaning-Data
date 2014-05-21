Getting-and-Cleaning-Data
=========================

Open the library that use, this library are: data.table and reshape2
Remember that you need installing the libraries before to start the R program and downloading the data set on a folder
Loads files test and training sets and the activities in different variables in the folder UCI HAR Dataset there are two subfolder and are: test and train in the root of folder there are 3 data set in txt format
Steps for this:
First open the files that has a root, remember one condition for this project is give appropriately labels the data set with descriptive activity names
Second I open the files that it is in subfolder dataset, in this case test and train and give appropriately labels to the variables
Now I have all the files in the Data set variables in R
Remember that uses descriptive activity names to name the activities in the data set this is a constraint for this project, they need to change the code for the events name eg: WALKING_UPSTAIRS
with the factor function, I try to change the code of columns test_data_avtive$V1 and train_Data_Active$1, with the information of activities$V1 and labels activies$v1
And now I have test_Data_Active$V1 and train_Data_Active$V1 with the correct information labels and levels
And now I need to put the name for each columns in the all variables of data set, in this case test_data, train_data, test_Data_Active, These is a another constraint for the project  and it is: Appropriately labels the data set with descriptive activity names
And now all the data set variables have name in the columns
Another point in this project is: extracts only the measurements on the mean and standard deviation for each measurement.
 the measurements are in test_data and Train_data, First get the data about the mean and standard deviation with the function grep, I try to find all the data with the next pattern ".*mean\\(\\)|.*std\\(\\)" inside of test_data and train_Data, this result  it is stored in  new variables, I called test_colnames and train_colnames, this new variable I need to put in the  data set of test_Data and train_Data but in a new column.
I need to combine data from test_data and train_data into the one data set, it including the activities for this I need to use the cbind function of test_data and test_data_active and test_data_sub, and train_data, train_Data_Active, Train_Data_Sub in only two tables test_data and train_data, now finally put all the data of train_data and test_data in a single variable data set, in final_data data set

Finally I need create a new independent tidy data set with the average of each variable for each activity and each subject.
 First I need store the variables of Activities and Subjet in a single variable this is an id
Second I try identify the differences between final_data colnames and variables that I created in the id, using setdiff function. Using the melt function of library reshape2 for reconstruct the columns, using the dcast function of library reshape2 for reorganize a column that it has a mean function and group the result and finally all the data put in a tidy data
Finally, create a new text file using the writa.table function, this file is tidy.txt
