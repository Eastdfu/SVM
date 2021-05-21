clc
% read train data from train.mat
load('train.mat')
% get size of input matrix
[m, n] = size(X);
% change 0 to -1 which makes constraints easier
y(y == 0) = -1;
% set lambda to 1/2
lambda = 1 / 2;
% set C which influence the accuracy 
C = 1/m;
% start optimization
cvx_begin
    variables pw(n) slack(m)  pb;
    % primal formula with soft margin
    minimize (C * sum(slack) + 0.5 * (pw' * pw))
    % constraints
    subject to
        y' .* (X * pw + pb) >= 1 - slack;
        slack >= 0;
cvx_end

y_predict_train = X * pw + pb;
y_predict_train(y_predict_train < 0) = -1;
y_predict_train(y_predict_train > 0) = 1;
 sum(y_predict_train == y')
pacc_train = sum(y_predict_train == y') / m

% poptval = cvx_optval;
load('test.mat');
[m, n] = size(X);
y(y == 0) = -1;
y_predict = X * pw + pb;
y_predict(y_predict < 0) = -1;
y_predict(y_predict > 0) = 1;
pacc_test = sum(y_predict == y') / m