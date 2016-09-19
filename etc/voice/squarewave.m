function [fx] = squarewave(t, w, limit)
% Square wave signal to test MATLAB's filter function
% t = time, w = frequency, limit = number of harmonics

K = 1:limit;
fx = 0;
sw = [];
for k = K
	fx = fx + ((4*sin(2*pi*((2*k)-1)*w*t))/(pi*((2*k)-1)));
	%sw(k) = fx;
end

b = [1 0 0];
a = [1 10*pi (10*pi)^2];

%plot(fx); pause;
%plot(sw); pause;
%testanalysis = filter(b, a, sw);
%plot(testanalysis); pause;
%disp('Did this work?');
%disp(t);
%figure;
%plot(sw); pause;