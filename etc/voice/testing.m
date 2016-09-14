function [analysis] = testing()
% Testing filter function with the following transfer function:
% H(s) = s^2/(s^2 + 20*s + 6400)
% High pass filter with w0 = 80Hz

T = -10:0.05:10;
n = 1;
w = 1;
limit = 100;
f = [];

for t = T
	f(n) = squarewave(t, w, limit);
	n = n + 1;
end

[b, a] = transfunc(w);
analysis = filter(b, a, f);
figure;
plot(T, f);
figure;
plot(T, analysis);

function [b, a] = transfunc(w)

b = [];
a = [];

b = [w^2 0 0];
a = [1 w*pi (w*pi)^2];