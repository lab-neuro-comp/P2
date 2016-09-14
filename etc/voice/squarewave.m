function [fx] = squarewave(t, w, limit)
% Square wave signal to test MATLAB's filter function
% t = time, w = frequency, limit = number of harmonics

K = 1:limit;
fx = 0;
for k = K
	fx = fx + ((4*sin(2*pi*((2*k)-1)*w*t))/(pi*((2*k)-1)));
end