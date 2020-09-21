How Well Do You Exercise?
================

Six participants were asked to perform weight-lifting exercises at 5 different levels of proficiency and correctness while their movements were monitored using commercially available fitness tracker devices like *Jawbone Up*, *Nike FuelBand*, and *Fitbit*. I developed a model to predict how well the exercise was performed using classification models like Regression and Classification Trees, Bagging, Random Forest and Generalised Boosting Regression, and then applied the model to correctly predict how well 20 other exercises by different participants were performed.

Data
----

-   The [training data](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv) and [test data](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv) can be downloaded from the above links.

-   The data are from [here](http://groupware.les.inf.puc-rio.br/har). Ugulino, W.; Cardador, D.; Vega, K.; Velloso, E.; Milidiu, R.; Fuks, H. Wearable Computing: Accelerometers' Data Classification of Body Postures and Movements. Proceedings of 21st Brazilian Symposium on Artificial Intelligence. Advances in Artificial Intelligence - SBIA 2012. In: Lecture Notes in Computer Science. , pp. 52-61. Curitiba, PR: Springer Berlin / Heidelberg, 2012. ISBN 978-3-642-34458-9. DOI: 10.1007/978-3-642-34459-6\_6.

Code and Instructions
---------------------

-   **humantraining.Rmd** contains the code embedded within it and can be run to generate the output document.

-   **humantraining.R** contains the code for cleaning the data, pre-processing, training the models and generating confusion marices.

-   The data need not be downloaded manually. It will be downloaded by the code. However, make sure you have an active internet connection.

-   The following packages are required - caret, kernlab, ggplot2 and randomforest
