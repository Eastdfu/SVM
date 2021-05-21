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
% intialize matrix for (1/2 * ct*H*c)
% assign H which Hij = y(i)*y(j)*(X(i)'*X(j))
H = (y' * y) .* (X * X');
% start optimization
cvx_begin
    % optimize al which with length of m (same with X's length)
    variables al(m);
    % maximize dual formula
    maximize (sum(al) - (al.' * H * al) / 2)
    % constraints
    subject to
        % sum of y*Lagrange multipliers shold be 0
        y * al == 0;
        % upper bound of each Lagrange multiplier
        al <= C;
        % lower bound of each Lagrange multiplier
        al >= 0;
cvx_end
doptval = cvx_optval;
%  f(x) = ¦²¦ÁiyixiTx + b
dw =(al .* y.').' * X;
db = sum( y - (al.' .* y * X * X.') ) / m;

y_predict_train = X * dw + db;
y_predict_train(y_predict_train < 0) = -1;
y_predict_train(y_predict_train > 0) = 1;
dacc_train = sum(y_predict_train == y') / m

% poptval = cvx_optval;
load('test.mat');
[m, n] = size(X);
y(y == 0) = -1;
y_predict = X * dw + db;
y_predict(y_predict < 0) = -1;
y_predict(y_predict > 0) = 1;
dacc_test = sum(y_predict == y') / m
