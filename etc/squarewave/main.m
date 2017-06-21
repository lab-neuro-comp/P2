function main()
% This is an experiment to recognize the first peak in a square wave signal.
% To run it,
%

% Simulating square wave
inlet = 0:0.001:10;
outlet = (squarewave(inlet, 5)+1)/2;
figure;
hold on;
squarePeaks = getPeaks(inlet, outlet);
plot(inlet, outlet, 'b');
plot(inlet, squarePeaks, 'r');
hold off;

% TODO Test procedure with real data
