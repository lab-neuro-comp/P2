function [analysis] = testing()
% Testing filter function with the following transfer function:
% H(s) = s^2/(s^2 + 20*s + 6400)
% High pass filter with w0 = 80Hz

T = 0:0.005:5;
n = 1;
w = 1;
limit = 100;
f = [];

for t = T
	f(n) = squarewave(t, w, limit);
	n = n + 1;
end

%[b, a] = transfunc(2*w);
[b, a] = butter(2, [1,5]/100);
analysis = filter(b, a, f);
figure;
plot(T, f);
figure;
plot(T, analysis);
fprintf('%d %d\n', length(T), length(analysis));

function [b, a] = transfunc(w)

b = [1 0 0];
a = [1 w*pi (w*pi)^2];