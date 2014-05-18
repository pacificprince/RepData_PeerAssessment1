setInternet2(TRUE)

temp <- tempfile()
zipFileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(zipFileURL, temp)
varTypes <- c("numeric", "character", "numeric")
data <- read.table(unz(temp, "activity.csv"), header=TRUE, sep=",", colClasses=varTypes)
data$date <- as.Date(data$date , "%Y-%m-%d")
unlink(temp)

totalStepsPerDay <- aggregate(data$steps ~ data$date, FUN = sum)
colnames(totalStepsPerDay) <- c("date", "totalSteps")

ggplot(totalStepsPerDay, aes(x=totalSteps)) + geom_histogram(binwidth=.5) + 
  ylab("Total Steps Per Day") + xlab("Month") 


for i=seq_len(NROW(data)){
  if(is.na(data$step[i])){
    interval <- data$interval[i]
    avgstep <- avgStepsPerInterval$step[avgStepsPerInterval$interval == interval]
    data$step[i] <- avgstep
  }
}