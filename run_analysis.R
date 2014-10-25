# Read in the raw data. Note the data is not included in the repository.

if (!exists("tr_xt")) tr_xt<-read.table("UCI HAR Dataset/train/X_train.txt")
if (!exists("tr_yt")) tr_yt<-read.table("UCI HAR Dataset/train/y_train.txt")
if (!exists("tr_st")) tr_st<-read.table("UCI HAR Dataset/train/subject_train.txt")
if (!exists("te_xt")) te_xt<-read.table("UCI HAR Dataset/test/X_test.txt")
if (!exists("te_yt")) te_yt<-read.table("UCI HAR Dataset/test/y_test.txt")
if (!exists("te_st")) te_st<-read.table("UCI HAR Dataset/test/subject_test.txt")

# Select out the mean and standard deviation data.

feat<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)[,2]
m_and_sds<-c(grep("-mean()",feat,fixed=TRUE),grep("-std()",feat,fixed=TRUE))
  
tr_xt_s<-tr_xt[,m_and_sds]
te_xt_s<-te_xt[,m_and_sds]

# Name the variables. Could have used the variable names in 'features.txt', but instead decided
# to create less abbreviated ones.

var_names<-c("Mean Body Acceleration (X dir)","Mean Body Acceleration (Y dir)","Mean Body Acceleration (Z dir)",
             "Stdev Body Acceleration (X dir)","Stdev Body Acceleration (Y dir)","Stdev Body Acceleration (Z dir)",
             "Mean Gravity Acceleration (X dir)","Mean Gravity Acceleration (Y dir)","Mean Gravity Acceleration (Z dir)",
             "Stdev Gravity Acceleration (X dir)","Stdev Gravity Acceleration (Y dir)","Stdev Gravity Acceleration (Z dir)",
             "Mean Body Jerk (X dir)","Mean Body Jerk (Y dir)","Mean Body Jerk (Z dir)",
             "Stdev Body Jerk (X dir)","Stdev Body Jerk (Y dir)","Stdev Body Jerk (Z dir)",
             "Mean Angular Velocity (X dir)", "Mean Angular Velocity (Y dir)", "Mean Angular Velocity (Z dir)",
             "Stdev Angular Velocity (X dir)", "Stdev Angular Velocity (Y dir)", "Stdev Angular Velocity (Z dir)",
             "Mean Gyroscopic Jerk (X dir)","Mean Body Gyroscopic Jerk (Y dir)","Mean Body Gyroscopic Jerk (Z dir)",
             "Stdev Gyroscopic Jerk (X dir)","Stdev Body Gyroscopic Jerk (Y dir)","Stdev Body Gyroscopic Jerk (Z dir)",
             "Mean Magnitude of Body Acceleration","Stdev Magnitude of Body Acceleration",
             "Mean Magnitude of Gravity Acceleration","Stdev Magnitude of Gravity Acceleration",
             "Mean Magnitude of Body Jerk","Stdev Magnitude of Body Jerk",
             "Mean Magnitude of Angular Velocity","Stdev Magnitude of Angular Velocity",
             "Mean Magnitude of Gyroscopic Jerk","Stdev Magnitude of Gyroscopic Jerk",
             "Mean Body Acceleration (X dir, freq domain)","Mean Body Acceleration (Y dir, freq domain)","Mean Body Acceleration (Z dir, freq domain)",
             "Stdev Body Acceleration (X dir, freq domain)","Stdev Body Acceleration (Y dir, freq domain)","Stdev Body Acceleration (Z dir, freq domain)",
             "Mean Body Jerk (X dir, freq domain)","Mean Body Jerk (Y dir, freq domain)","Mean Body Jerk (Z dir, freq domain)",
             "Stdev Body Jerk (X dir, freq domain)","Stdev Body Jerk (Y dir, freq domain)","Stdev Body Jerk (Z dir, freq domain)",
             "Mean Angular Velocity (X dir, freq domain)", "Mean Angular Velocity (Y dir, freq domain)", "Mean Angular Velocity (Z dir, freq domain)",
             "Stdev Angular Velocity (X dir, freq domain)", "Stdev Angular Velocity (Y dir, freq domain)", "Stdev Angular Velocity (Z dir, freq domain)",
             "Mean Magnitude of Body Acceleration (freq domain)","Stdev Magnitude of Body Acceleration (freq domain)",
             "Mean Magnitude of Body Jerk (freq domain)","Stdev Magnitude of Body Jerk (freq domain)",
             "Mean Magnitude of Angular Velocity (freq domain)","Stdev Magnitude of Angular Velocity (freq domain)",
             "Mean Magnitude of Gyroscopic Jerk (freq domain)","Stdev Magnitude of Gyroscopic Jerk (freq domain)"
)

names(tr_xt_s)<-var_names
names(te_xt_s)<-var_names
names(tr_st)<-"Subject"
names(te_st)<-"Subject"

# Create activity names
 
library(plyr)
activities<-read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)[,2]
tr_at<-data.frame("Activity"=mapvalues(tr_yt$V1,1:6,activities))
te_at<-data.frame("Activity"=mapvalues(te_yt$V1,1:6,activities))

# Merge the data sets

training<-cbind(tr_st,tr_at,tr_xt_s,data.frame("Observation type"=rep("training",nrow(tr_st))))
test<-cbind(te_st,te_at,te_xt_s,data.frame("Observation type"=rep("test",nrow(te_st))))
tidy_dataset<-rbind(training,test)

# Create the second data set of averages

averages<-NULL
for (j in 1:30)
  {for (act in activities)
     {averages<-rbind(averages,colMeans(tidy_dataset[tidy_dataset$Subject == j & tidy_dataset$Activity == act,3:65]))
  }}

averaged_dataset<-data.frame("Subject"=rep(1:30,each=6),"Activity"=rep(activities,30),averages)

