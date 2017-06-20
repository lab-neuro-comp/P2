function [out] = squarewave(t, N)
% Calculates a square wave using the Fourier series definition.
%
%     t: the value in time
%     N: the number of iterations to perform
%
out = 0;
for n = 1:N
	out = out + sin(2*pi*(2*n-1)*t)/(2*n-1);
end
out = (4*out/pi + 1)/2;
