Weight Lifting Exercise
================
Vimal Simha
4/27/2020

R Markdown
----------

Exploratory Analysis and Data Cleaning
--------------------------------------

We load the training dataset and examine it using the head command. There are 19,622 observations of 160 variables. A cursory inspection reveals a substantial number of NAs, and further investigation reveals the presence of \#DIV/0 values. About 98% of the observations of 67 variables are recorded as NA and a further 33 variables as \#DIV/0. Since a large fraction of values are missing, interpolation is unlikely to work. Therefore, we eliminate these 100 variables from our analysis. A further 7 variables are the index number, username, timestamp and window number which we also eliminate. This leaves us with 52 covariates which we will use to predict the classe variable.

``` r
set.seed(10)
training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",na.strings=c("NA","NaN","","#DIV/0!"))
training <- training[,!sapply(training, function(x) mean(is.na(x)))>0.5]
training <- training[-c(1:7)] 
```

To help better assess the out of sample errors, we divide the training dataset into two subsamples, namely, a subtraining dataset and a subtesting dataset containing 75% and 25% of the observations respectively.

``` r
inTrain <- createDataPartition(y=training$classe,p=0.75,list=FALSE)
subtraining <- training[inTrain,]
subtesting <- training[-inTrain,]
```

Preprocessing
-------------

Examining the correlations of variables shows that several are highly correlated. 38 pairs of variables are strongly correlated (correlation coefficient &gt; 0.8), We perform a principal component analysis (PCA) to reduce the number of variables and reduce the noise.

Predictor Models
----------------

The problem is to classify the weight lifting exercise into one of five classes based on the exercise performance data that we have now reduced to 52 variables.

We will consider the following classification models: - Regression and Classification Tree - Bagging (Bootstrap Aggregating) - Random Forest - Generalised Boosting Regression

We train each model using the subtraining subset of the training data. We then use the model to predict the classe variable in the subtesting dataset. The confusion matrix for each model showing its accuracy, sensitivity and specificity are shown below. These represent out of sample errors as these data have not been used for training the model.

### Recursive Partitioning and Regression Tree

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    A    B    C    D    E
    ##          A 1278    0    0   96   21
    ##          B  642    0    0  171  136
    ##          C  793    0    0   44   18
    ##          D  434    0    0  301   69
    ##          E  486    0    0  130  285
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.3801          
    ##                  95% CI : (0.3665, 0.3939)
    ##     No Information Rate : 0.7408          
    ##     P-Value [Acc > NIR] : 1               
    ##                                           
    ##                   Kappa : 0.1675          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: A Class: B Class: C Class: D Class: E
    ## Sensitivity            0.3518       NA       NA  0.40566  0.53875
    ## Specificity            0.9079   0.8065   0.8257  0.87914  0.85920
    ## Pos Pred Value         0.9161       NA       NA  0.37438  0.31632
    ## Neg Pred Value         0.3289       NA       NA  0.89244  0.93905
    ## Prevalence             0.7408   0.0000   0.0000  0.15131  0.10787
    ## Detection Rate         0.2606   0.0000   0.0000  0.06138  0.05812
    ## Detection Prevalence   0.2845   0.1935   0.1743  0.16395  0.18373
    ## Balanced Accuracy      0.6299       NA       NA  0.64240  0.69898

### Bagging

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    A    B    C    D    E
    ##          A 1371   11    8    3    2
    ##          B   24  899   19    2    5
    ##          C   10   22  790   28    5
    ##          D    0    2   42  751    9
    ##          E    2    8    8    7  876
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.9558          
    ##                  95% CI : (0.9496, 0.9613)
    ##     No Information Rate : 0.2869          
    ##     P-Value [Acc > NIR] : <2e-16          
    ##                                           
    ##                   Kappa : 0.944           
    ##                                           
    ##  Mcnemar's Test P-Value : 0.2406          
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: A Class: B Class: C Class: D Class: E
    ## Sensitivity            0.9744   0.9544   0.9112   0.9494   0.9766
    ## Specificity            0.9931   0.9874   0.9839   0.9871   0.9938
    ## Pos Pred Value         0.9828   0.9473   0.9240   0.9341   0.9723
    ## Neg Pred Value         0.9897   0.9891   0.9810   0.9902   0.9948
    ## Prevalence             0.2869   0.1921   0.1768   0.1613   0.1829
    ## Detection Rate         0.2796   0.1833   0.1611   0.1531   0.1786
    ## Detection Prevalence   0.2845   0.1935   0.1743   0.1639   0.1837
    ## Balanced Accuracy      0.9838   0.9709   0.9475   0.9683   0.9852

### Random Forest

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    A    B    C    D    E
    ##          A 1395    0    0    0    0
    ##          B    5  944    0    0    0
    ##          C    0    5  850    0    0
    ##          D    0    0   15  789    0
    ##          E    0    0    0    2  899
    ## 
    ## Overall Statistics
    ##                                          
    ##                Accuracy : 0.9945         
    ##                  95% CI : (0.992, 0.9964)
    ##     No Information Rate : 0.2855         
    ##     P-Value [Acc > NIR] : < 2.2e-16      
    ##                                          
    ##                   Kappa : 0.993          
    ##                                          
    ##  Mcnemar's Test P-Value : NA             
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: A Class: B Class: C Class: D Class: E
    ## Sensitivity            0.9964   0.9947   0.9827   0.9975   1.0000
    ## Specificity            1.0000   0.9987   0.9988   0.9964   0.9995
    ## Pos Pred Value         1.0000   0.9947   0.9942   0.9813   0.9978
    ## Neg Pred Value         0.9986   0.9987   0.9963   0.9995   1.0000
    ## Prevalence             0.2855   0.1935   0.1764   0.1613   0.1833
    ## Detection Rate         0.2845   0.1925   0.1733   0.1609   0.1833
    ## Detection Prevalence   0.2845   0.1935   0.1743   0.1639   0.1837
    ## Balanced Accuracy      0.9982   0.9967   0.9907   0.9969   0.9998

### Generalised Boosted Regression

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    A    B    C    D    E
    ##          A 1267   35   45   38   10
    ##          B   99  715   83   21   31
    ##          C   46   60  696   32   21
    ##          D   25   14  108  637   20
    ##          E   22   72   65   34  708
    ## 
    ## Overall Statistics
    ##                                          
    ##                Accuracy : 0.8204         
    ##                  95% CI : (0.8093, 0.831)
    ##     No Information Rate : 0.2975         
    ##     P-Value [Acc > NIR] : < 2.2e-16      
    ##                                          
    ##                   Kappa : 0.7725         
    ##                                          
    ##  Mcnemar's Test P-Value : < 2.2e-16      
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: A Class: B Class: C Class: D Class: E
    ## Sensitivity            0.8684   0.7980   0.6981   0.8360   0.8962
    ## Specificity            0.9628   0.9416   0.9593   0.9597   0.9531
    ## Pos Pred Value         0.9082   0.7534   0.8140   0.7923   0.7858
    ## Neg Pred Value         0.9453   0.9542   0.9257   0.9695   0.9795
    ## Prevalence             0.2975   0.1827   0.2033   0.1554   0.1611
    ## Detection Rate         0.2584   0.1458   0.1419   0.1299   0.1444
    ## Detection Prevalence   0.2845   0.1935   0.1743   0.1639   0.1837
    ## Balanced Accuracy      0.9156   0.8698   0.8287   0.8978   0.9246

Final Model
-----------

It is possible to combine the predictions of different methods to further enhance accuracy. However, we do not believe that is necessary in this instance because the Random Forest model can predict the correct outcome with an accuracy of 99.5% (95% confidence interval between 99.2% and 99.6%).

We apply our Random Forest model tuned on the training dataset to the testing data. First, we clean and pre-process the test data, through the same pipeline as the training dataset.

We then apply our model to generate predictions on the test dataset. As there are 20 observations, we do not expect more than one prediction to be incorrect given our out of sample errors that we have stated earlier.

    ##  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 
    ##  B  A  B  A  A  E  D  B  A  A  B  C  B  A  E  E  A  B  B  B 
    ## Levels: A B C D E
