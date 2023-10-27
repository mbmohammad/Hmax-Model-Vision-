train_data <- read.csv("trainall.csv")
test_data <- read.csv("testall.csv")
train_X <- train_data[, -ncol(train_data)]
train_Y <- train_data[, ncol(train_data)]
test_X <- test_data[, -ncol(test_data)]
test_Y <- test_data[, ncol(test_data)]
library(e1071)
library(pROC)
model <- svm(train_X, train_Y)

scores <- predict(model, test_X, probability = TRUE)
positiveScores <- scores
roc_obj <- roc(test_Y, positiveScores)
plot(roc_obj, main = "Receiver Operating Characteristic (ROC) Curve",
     xlab = "False Positive Rate", ylab = "True Positive Rate")
dprime1 <- roc_obj$auc / sqrt(2)

roc_obj <- roc(test_Y[c(1:75, 301:375)], positiveScores[c(1:75, 301:375)])
plot(roc_obj, main = "Receiver Operating Characteristic (ROC) Curve",
     xlab = "False Positive Rate", ylab = "True Positive Rate")
dprime2 <- roc_obj$auc / sqrt(2)

roc_obj <- roc(test_Y[c(76:150, 376:450)], positiveScores[c(76:150, 376:450)])
plot(roc_obj, main = "Receiver Operating Characteristic (ROC) Curve",
     xlab = "False Positive Rate", ylab = "True Positive Rate")
dprime3 <- roc_obj$auc / sqrt(2)

roc_obj <- roc(test_Y[c(151:225, 451:525)], positiveScores[c(151:225, 451:525)])
plot(roc_obj, main = "Receiver Operating Characteristic (ROC) Curve",
     xlab = "False Positive Rate", ylab = "True Positive Rate")
dprime4 <- roc_obj$auc / sqrt(2)


roc_obj <- roc(test_Y[c(226:300, 526:600)], positiveScores[c(226:300, 526:600)])
plot(roc_obj, main = "Receiver Operating Characteristic (ROC) Curve",
     xlab = "False Positive Rate", ylab = "True Positive Rate")
dprime5 <- roc_obj$auc / sqrt(2)

cat("d prime for all:", dprime1, "\n")
cat("d prime for close body:", dprime2, "\n")
cat("d prime for far body:", dprime3, "\n")
cat("d prime for head:", dprime4, "\n")
cat("d prime for medium:", dprime5, "\n")


# Data
dprime <- c(dprime1, dprime4, dprime2, dprime5, dprime3)
xlabels <- c("all", "Head", "Close body", "Medium body", "Far body")

# Plot
plot(dprime, type = "b", xaxt = "n", ylab = "Performance", xlab = "")
axis(1, at = 1:length(dprime), labels = xlabels)
title(main = "d'")




