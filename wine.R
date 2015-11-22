# Load and Process Dataset

download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv",
              "data/winequality-white.csv")

download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv",
              "data/winequality-red.csv")

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


# Create Prediction Models

## Linear Regression

fitAll <- lm(quality ~ ., data = training) # RMSE = 0.7583411

corMat <- cor(training[sapply(training, is.numeric)])
diag(corMat) <- 0
which(abs(corMat) > 0.5, arr.ind = T)

fitNew <- lm(quality ~ . - citric.acid - density - fixed.acidity - pH - total.sulfur.dioxide,
             data = training) # RMSE = 0.7575906

summary(fitNew)

library(car)
vif(fitNew)

## Support Vector Machines

library(e1071)

tuneSVM <- tune(svm, quality ~ . - citric.acid - density - fixed.acidity - pH - total.sulfur.dioxide,
               data = training,
               ranges = list(gamma = 2^(-5:5), cost = 2^(-3:3)),
               tunecontrol = tune.control(sampling = "fix", fix = 3/4))

gammas <- 2^(-3:3)
costs <- 2^(-3:3)
i <- 1
tuner <- data.frame(gamma = numeric(), cost = numeric(), error = numeric(), dispersion = numeric())

for(g in gammas){
    for(c in costs){
        tuner[i, 1] <- g
        tuner[i, 2] <- c
        
        fitSVM <- svm(quality ~ . - citric.acid - density - fixed.acidity - pH - total.sulfur.dioxide,
                      data = training, gamma = g, cost = c)
        
        pred <- predict(fitSVM, xval)
        
        tuner[i, 3] <- sqrt(mean((pred-xval$quality)^2))
        tuner[i, 4] <- var(pred) / mean(pred)
        i <- i + 1
    }
}

fitSVM <- svm(quality ~ . - citric.acid - density - fixed.acidity - pH - total.sulfur.dioxide,
              data = training, gamma = 4, cost = 2)

## Random Forests with PCA

preProc <- preProcess(training, method = "pca", thresh = 0.9)
trainingPCA <- predict(preProc, training)
rfFit <- train(training$quality ~ ., data = training, method = "rf", proximity = TRUE)
xvalPCA <- predict(preProc, xval)