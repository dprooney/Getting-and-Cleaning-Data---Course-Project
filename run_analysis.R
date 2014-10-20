# Read in the raw data

if (!exists("tr_xt")) tr_xt<-read.table("UCI HAR Dataset/train/X_train.txt")
if (!exists("tr_yt")) tr_yt<-read.table("UCI HAR Dataset/train/y_train.txt")
if (!exists("tr_st")) tr_st<-read.table("UCI HAR Dataset/train/subject_train.txt")
if (!exists("te_xt")) te_xt<-read.table("UCI HAR Dataset/test/X_test.txt")
if (!exists("te_yt")) te_yt<-read.table("UCI HAR Dataset/test/y_test.txt")
if (!exists("te_st")) te_st<-read.table("UCI HAR Dataset/test/subject_test.txt")

# Select out the mean and standard deviation data

m_and_sds<-rep(seq(0,160,40),each=6)+rep(1:6,5)
m_and_sds<-c(m_and_sds,rep(seq(200,252,13),each=2)+rep(1:2,5))
m_and_sds<-c(m_and_sds,rep(seq(265,423,79),each=6)+rep(1:6,3))
m_and_sds<-c(m_and_sds,rep(seq(502,541,13),each=2)+rep(1:2,4))

tr_xt_s<-tr_xt[,m_and_sds]
te_xt_s<-te_xt[,m_and_sds]

# Name the variables

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

# Create activity names
 
library(plyr)
activities<-c("Walking","Walking upstairs","Walking downstairs","Sitting","Standing","Lying down")
tr_at<-data.frame("Activity"=mapvalues(tr_yt$V1,1:6,activities))
te_at<-data.frame("Activity"=mapvalues(te_yt$V1,1:6,activities))
names(tr_st)<-"Subject"
names(te_st)<-"Subject"

# Merge the data sets

training<-cbind(tr_st,tr_at,tr_xt_s,data.frame("Observation type"=rep("training",nrow(tr_st))))
test<-cbind(te_st,te_at,te_xt_s,data.frame("Observation type"=rep("test",nrow(te_st))))
tidy_dataset<-rbind(training,test)

# Create the second data set of averages

averages<-NULL
for (j in 1:30)
  {for (act in activities)
     {averages<-rbind(averages,colMeans(tidy_data[tidy_data$Subject == j & tidy_data$Activity == act,3:65]))
  }}

step5_dataset<-data.frame("Subject"=rep(1:30,each=6),"Activity"=rep(activities,30),averages)

