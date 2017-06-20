function main()
% This is an experiment to recognize the first peak in a square wave signal.
% To run it,
%

% Simulating square wave
inlet = 0:0.001:10;
outlet= (squarewave(inlet, 5)+1)/2;

% Plotting square wave
hold on;
plot(inlet, outlet);
bert = -imag(hilbert(outlet));
[downbert upbert] = moses(bert, 1);
plot(inlet, downbert, 'r');
plot(inlet, upbert, 'g');
hold off;

% TODO Discover peaks
