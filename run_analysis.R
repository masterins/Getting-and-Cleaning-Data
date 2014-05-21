#Open the library that use
#Remember that you need installing the libraries before to start the R program
#and downloading the data set on a folder
library(data.table)
library(reshape2)

#Loads files test and training sets and the activities in different varialbles
#in the folder UCI HAR Dataset there are two subfolder and are: test and train
#in the root of folder there are 3 data set in txt format
#First open the files that has a root
#Rememberr one condition for this project is give appropriately labels the data set with descriptive activity names

features <- read.table("./features.txt",header=FALSE,colClasses="character")
activities <- read.table("./activity_labels.txt",header=FALSE,colClasses="character")

# Second I open the  files that it is in  subfolder dataset, in this case test and train
# and give appropriately labels to the variables

# Test folder
test_Data <- read.table("./test/X_test.txt",header=FALSE)
test_Data_Active  <- read.table("./test/y_test.txt",header=FALSE)
test_Data_Sub <- read.table("./test/subject_test.txt",header=FALSE)
# train folder
train_Data <- read.table("./train/X_train.txt",header=FALSE)
train_Data_Active <- read.table("./train/y_train.txt",header=FALSE)
train_Data_Sub <- read.table("./train/subject_train.txt",header=FALSE)

# Now I have all the files in the Data set variables in R------------------------------------------------------------------

#Remeber that Uses descriptive activity names to name the activities in the data set this is a constraint for this project
#They need to change the code for the events name eg: WALKING_UPSTAIRS
#with the factor function, I try to change the code of columns test_data_avtive$V1 and train_Data_Active$1, 
#with the information of activities$V1 and labels activies$v1

test_Data_Active$V1 <- factor(test_Data_Active $V1,levels=activities$V1,labels=activities$V2)
train_Data_Active$V1 <- factor(train_Data_Active$V1,levels=activities$V1,labels=activities$V2)

# And now I have test_Data_Active$V1 and train_Data_Active$V1 with the correct information labels and levels---------------

# And now I need to put the name for each columns in the all variables of data set, in this case test_data, train_data, test_Data_Active, 
# These is a another constraint for the project  and it is: Appropriately labels the data set with descriptive activity names

colnames(test_Data)<-features$V2
colnames(train_Data)<-features$V2
colnames(test_Data_Active )<-c("Activities")
colnames(test_Data_Sub)<-c("Subject")
colnames(train_Data_Active)<-c("Activities")
colnames(train_Data_Sub)<-c("Subject")

# And now all the data set variables have name in the columns
#-------------------Part of mean and strandard deviation----------------------------------------------------------------------
# Another point in this project is: extracts only the measurements on the mean and standard deviation for each measurement.
# the measurements are in test_data and Train_data
# First get the datas about the mean and standar deviation
# with the function grep, I try to find all the data with the next pattern ".*mean\\(\\)|.*std\\(\\)" inside of test_data and train_Data
# This result  it is stored in  new variables, I called test_colnames and train_colnames

test_colnames <- grep(".*mean\\(\\)|.*std\\(\\)", colnames(test_Data))
train_colnames <- grep(".*mean\\(\\)|.*std\\(\\)", colnames(train_Data))

#this new variable I need to put in the  data set of test_Data and train_Data but in a new column

test_Data<-test_Data[,test_colnames]
train_Data<-train_Data[,train_colnames]

# I need to combine data from test_data and train_data into the one data set, it including the activities
# for this I need to use the cbind function of test_data and test_data_active and test_data_sub
# and train_data, train_Data_Active, Train_Data_Sub in only two tables test_data and train_data
test_Data<-cbind(test_Data,test_Data_Active )
test_Data<-cbind(test_Data,test_Data_Sub)
train_Data<-cbind(train_Data,train_Data_Active)
train_Data<-cbind(train_Data,train_Data_Sub)

# now finally put all the data of train_data and test_data in a single variable data set, in final_data data set
final_data<-rbind(test_Data,train_Data)

# finally I need create a new independent tidy data set with the average of each variable for each activity and each subject.
# First I need store the variables of Activities and Subjet in a single variable this is a id
id_vars = c("Activities", "Subject")
#Second Second I try identify the diferencia  between final_data colnames and variables that I created in the id, using setdiff function
measure_vars_final = setdiff(colnames(final_data), id_vars)
# using the melt function of library reshape2 for reconstruct the columns
melted_data_final <-melt(final_data, id=id_vars, measure.vars=measure_vars_final)
# using the dcast function of library reshape2 for reorganize a column that it has a mean function and group the result
# and finally all the data put in a tidy data
tidy_data<-dcast(melted_data_final, Activities + Subject ~ variable, mean)

# create a new text file using the writa.table function, this file is tidy.txt
write.table(tidy_data, file="tidy.txt")
