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

round(prop.table(table(wdbc$diagnosis)) * 100, digits = 1)
