function [S] = sigmoid(x)
% Function to be used during learning process
S = 2 * x^2 / (1 + x^2); 
% S = erf(x * sqrt(pi) / 2);