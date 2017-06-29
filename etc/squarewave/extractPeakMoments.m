function [outlet] = extractPeakMoments(data, fs, ml)
% Extracts when the peak moments happened after applying the `getPeaks`
% function.
%
%     data - the binary array telling when the events happenned
%     fs - the sample frequency
%     ml - minimum time length between
%
period = 1/fs;
inlet = 0:period:(period*(length(data(1,:))-1));
outlet = [ ];
last = 0;
for n = 1:length(data)
	it = data(n);
	if and(it > 0, inlet(n) - last > ml)
		outlet(end+1) = inlet(n);
		last = inlet(n);
	end
end
