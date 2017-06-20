function main()
% This is an experiment to recognize the first peak in a square wave signal.
% To run it,
%

% Simulating square wave
inlet = 0:0.001:10;
outlet = (squarewave(inlet, 5)+1)/2;

% Plotting square wave
hold on;
plot(inlet, outlet);
bert = -imag(hilbert(outlet));
[downbert upbert] = moses(bert, 1);
plot(inlet, downbert, 'r');
plot(inlet, upbert, 'g');

% Discovering peaks
result = [ ];
note = false;
for it = (upbert-1);
	if and(~note, it > 0)
		result(end+1) = 1;
	else
		result(end+1) = 0;
	end
	note = it > 0;
end
plot(inlet, result, 'm');
hold off;

% TODO Get this peak detection peak algorithm in its own script
