function main()
% This is an experiment to recognize the first peak in a square wave signal.
% To run it,
%

% Simulating square wave
inlet = 0:0.001:10;
outlet = (squarewave(inlet, 5)+1)/2;
squarePeaks = getPeaks(inlet, outlet);

figure;
hold on;
plot(inlet, outlet, 'b');
plot(inlet, squarePeaks, 'r');
hold off;

% TODO Test procedure with real data
% Simulating with real life data
period = 1/500;
testfilepath = '../../b/dudu.ascii';
recording = load(testfilepath);
inlet = 0:period:(period*(length(recording(1,:))-1));
realPeaks = getPeaks(inlet, recording(1,:));

figure;
hold on;
plot(inlet, recording, 'b');
plot(inlet, realPeaks, 'r');
hold off;