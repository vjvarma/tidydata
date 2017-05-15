## loading data from train set and test set

mydata.train.x = read.table("../UCI HAR Dataset/train/X_train.txt")
mydata.test.x = read.table("../UCI HAR Dataset/test/X_test.txt")

##loading data from features

mydata.fea = read.table("../UCI HAR Dataset/features.txt")

##taking data from features

features<-as.character(mydata.fea[,2])

##adding features data to test and training dataset


colnames(mydata.test.x)<-features
colnames(mydata.train.x)<-features

##merging train set and test set

fulldata<-rbind(mydata.test.x,mydata.train.x)

##creating a new data set which contains only mean and std


Mean<-grep("mean",names(fulldata),value = TRUE)
std<-grep("std",names(fulldata),value = TRUE)
mean_std<-subset.data.frame(fulldata,select =c(Mean,std))
data_1<-sapply(mean_std,mean)
tidydata<-data.frame(data_1)

##tidy data set have all the average value

names(tidydata)<-"Average"
write.table(tidydata,"C:/Users/",row.name=FALSE)

