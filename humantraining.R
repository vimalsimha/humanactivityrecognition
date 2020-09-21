## Code for Weight Lifting Exercise Data Analysis
library(caret)
library(kernlab)
library(ggplot2)
library(randomForest)

#Data Cleaning
training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",na.strings = c("NA","NaN","","#DIV/0!"))
training <- training[,!sapply(training, function(x) mean(is.na(x)))>0.5]
training <- training[-c(1:7)] 


## Examine correlations of variables
M <- abs(cor(training[,-53]))
diag(M) <- 0
which(M > 0.8, arr.ind = T)

## Split training dataset into subtraining and subtesting datasets
inTrain <- createDataPartition(y=training$classe,p=0.75,list=FALSE)
subtraining <- training[inTrain,]
subtesting <- training[-inTrain,]

##
set.seed(10)

## Train Models
modrpart <- train(classe ~ .,method="rpart",preProcess="pca",data=subtraining)
modgbm <- train(classe ~ .,method="gbm",preProcess="pca",data=subtraining)
modtreebag <- train(classe ~ .,method="treebag",preProcess="pca",data=subtraining)
modrf <- randomForest(classe ~ .,preProcess="pca",data=subtraining)

## Predict on subtesting and create confusion matrix
confusionMatrix(subtesting$classe,predict(modrpart,subtesting))
confusionMatrix(subtesting$classe,predict(modgbm,subtesting))
confusionMatrix(subtesting$classe,predict(modtreebag,subtesting))
confusionMatrix(subtesting$classe,predict(modrf,subtesting))

##
library(rattle)
fancyRpartPlot(modfit$finalModel)

