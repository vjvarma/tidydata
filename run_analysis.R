##loading data from features

features = read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/features.txt"
                      , stringsAsFactors=FALSE)[,2]


## loading data from train set and test set

mydata.train.x <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/train/X_train.txt",col.names = features)
mydata.test.x <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/test/X_test.txt",col.names = features)
mydata.train.y <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/train/y_train.txt")
mydata.test.y <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/test/y_test.txt")
subject.train <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/train/subject_train.txt")
subject.test <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/test/subject_test.txt")

##loading data from action

action <- read.table("C:/Users/vijay/Desktop/coursera/UCI HAR Dataset/activity_labels.txt"
                         , stringsAsFactors=FALSE)[,2]
##Adding action and subject 

mydata.train.y$V1 <- factor(mydata.train.y$V1)
names(mydata.train.y) <- c("action")
levels(mydata.train.y$action) <- action

mydata.test.y$V1 <- factor(mydata.test.y$V1)
names(mydata.test.y) <- c("action")
levels(mydata.test.y$action) <- action

subject.test$V1<- factor(subject.test$V1)
names(subject.test) <- c("subjects")

subject.train$V1 <- factor(subject.train$V1)
names(subject.train) <- c("subjects")


## subsetting mean and std values

Mean<-grep("mean",names(mydata.test.x),value = TRUE)
std<-grep("std",names(mydata.test.x),value = TRUE)
mydata.test.x<-subset.data.frame(mydata.test.x,select =c(Mean,std))

Mean<-grep("mean",names(mydata.train.x),value = TRUE)
std<-grep("std",names(mydata.train.x),value = TRUE)
mydata.train.x<-subset.data.frame(mydata.train.x,select =c(Mean,std))


mydata.test.x<-cbind(subject.test,mydata.test.y,mydata.test.x)
mydata.train.x<-cbind(subject.train,mydata.train.y,mydata.train.x)


## merging train set and test set

fulldata<-rbind(mydata.test.x,mydata.train.x)

names(fulldata) <- gsub("\\.", "", names(fulldata))

names(fulldata) <- tolower(names(fulldata))

write.table(fulldata, "TidyData.txt")

##tidy data set have all the average value

avg <- aggregate(fulldata[, 3:80] , list(subjects = fulldata$subject , action = fulldata$activity), mean)

write.table(avg,"avg.txt")
