# Load and Process Dataset

#download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv",
#              "data/winequality-white.csv")

#download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv",
#              "data/winequality-red.csv")

whites <- read.csv2("data/winequality-white.csv", header = TRUE, stringsAsFactors = FALSE)
whites <- cbind(type = "white", whites)

reds <- read.csv2("data/winequality-red.csv", header = TRUE, stringsAsFactors = FALSE)
reds <- cbind(type = "red", reds)

wines <- rbind(whites, reds)
wines[, -c(1,13)] <- lapply(wines[, -c(1,13)], as.numeric)

# Create Training, Cross-Validation and Test Sets

library(caret)

set.seed(474)

inTrain <- createDataPartition(wines$quality, p = 0.6, list = FALSE)
training <- wines[inTrain,]
test <- wines[-inTrain,]

inTest <- createDataPartition(test$quality, p = 0.5, list = FALSE)
xval <- test[-inTest,]
test <- test[inTest,]

# Create SVM Prediction Model

library(e1071)

fitSVM <- svm(quality ~ ., data = training[, c(1,3,5,6,7,11,12,13)], 
              gamma = 4, cost = 2)