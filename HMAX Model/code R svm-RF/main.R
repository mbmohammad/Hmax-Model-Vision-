# Load the required library
library(e1071)
# Read the training and testing data
train_data <- read.csv("trainall.csv")
test_data <- read.csv("testall.csv")

# Create the SVM model
svm_model <- svm(Y ~ ., data = train_data)
summary(svm_model)
# Make predictions on the test data
predictions <- predict(svm_model, newdata = test_data)
# Assign 1 to positive predictions and -1 to negative predictions
predictions <- ifelse(predictions > 0, 1, -1)
# Calculate the sum of differences and divide by 600
sum_diff <- sum(predictions - test_data$Y == 0) / 600
# Print the result
print(paste("Accuracy:", sum_diff))

install.packages("randomForest")  # install the randomForest package if not already installed
library(randomForest)
# Specify the predictor variables and the target variable
predictors <- names(train_data)[-which(names(train_data) == "Y")]
target <- "Y"
# Train the Random Forest model
rf_model <- randomForest(x = train_data[, predictors],
                         y = train_data[, target],
                         ntree = 100,  # number of trees in the forest
                         importance = TRUE)  # calculate variable importance
predictions <- predict(rf_model, newdata = test_data[, predictors])
# Assign 1 to positive predictions and -1 to negative predictions
predictions <- ifelse(predictions > 0, 1, -1)
# Calculate the sum of differences and divide by 600
sum_diff <- sum(predictions - test_data$Y == 0) / 600
# Print the result
print(paste("Accuracy:", sum_diff))


#