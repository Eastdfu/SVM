clc
C = 1/8500;
[train_label, train_feature] = libsvmread('train.libsvm');
model = libsvmtrain(train_label, train_feature, '-t 0 -c 1.1765e-04');
[predicted_label] = libsvmpredict(train_label, train_feature, model);
[test_label, test_feature] = libsvmread('test.libsvm');
[predicted_label] = libsvmpredict(test_label, test_feature, model);
w = model.SVs' * model.sv_coef;
y = train_label(model.sv_indices);
y(y==0) = -1;
b = model.sv_coef ./ y;