# Open Csv File
wdbc<-read.csv(file="data.csv", stringsAsFactors = FALSE)
# Get the Structure of the Data
str(wdbc)

#First variable "id" is just a unique identifier of Patient
# It does not contribute anything to the data therefore we will remove it

#Droping the id column
wdbc <- wdbc[-1]

#Diagonistic Column 
table(wdbc$diagnosis)

# Giving Diagnosis Variable informative labels
wdbc$diagnosis <- factor(wdbc$diagnosis, levels = c("B","M"), 
                         labels = c("Benign", "Malignant"))

#Provides Percentage from the frequency of the Data
round(prop.table(table(wdbc$diagnosis)) * 100, digits = 1)

#Summary of the Radius , Area and Smoothness
summary(wdbc[c("radius_mean","area_mean","smoothness_mean")])

# Tranformation - normalizing numeric data
normalize <- function(x) {
  return( (x - min(x) ) / (max(x) - min(x)))
}

# Checking Normalize Function
normalize(c(1,2,3,4,5))


#Applying normalize function to all values in the Data Frame
wdbc_n <- as.data.frame(lapply(wdbc[2:31], normalize))

summary(wdbc_n)

summary(wdbc_n$area_mean)

#Data Preapration - creating training and test datasets
# Here we have excluded the Diagnostic Data 
wdbc_train <- wdbc_n[1:469, ]
wdbc_test <- wdbc_n[470:569, ]

# For training our Data Set we would need to store these class labels 
# into factor vectors

wdbc_train_labels <- wdbc[1:469, 1]
wdbc_test_labels <- wdbc[470:569, 1]

# Training a Model on the Data 
install.packages("class")

library(class)

# Training Data using the knn( ) function 
wdbc_pred <- knn(train = wdbc_train, test = wdbc_test,
                 cl = wdbc_train_labels, k = 21)

# Evaluating the model performance 
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prgop.chisq=FALSE)

install.packages("gmodels")
library(gmodels)

CrossTable(x = wdbc_test_labels, y = wdbc_pred,
           prop.chisq=FALSE)

