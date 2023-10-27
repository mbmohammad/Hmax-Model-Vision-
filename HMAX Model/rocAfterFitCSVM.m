model = fitcsvm(XTrain', ytrain);
y_pred = predict(model, XTest');
scores = model.Fitted.ProbabilityEstimates(:, 2);
[X,Y,T,AUC] = perfcurve(ytest, scores, 1);
plot(X, Y)
xlabel('False Positive Rate')
ylabel('True Positive Rate')
title('Receiver Operating Characteristic (ROC) Curve')
legend(['AUC = ' num2str(AUC)])
