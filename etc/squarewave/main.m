function main()
% This is an experiment to recognize the first peak in a square wave signal.
% To run it,
%

% Simulating square wave
inlet = 0:0.001:10;
outlet= squarewave(inlet, 5);

% Plotting square wave
plot(inlet, outlet);
% TODO Discover peaks
