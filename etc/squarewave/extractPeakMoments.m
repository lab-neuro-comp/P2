function [outlet] = extractPeakMoments(data, fs)
% Extracts when the peak moments happened after applying the `getPeaks`
% function.
%
%     data - the binary array telling when the events happenned
%     fs - the sample frequency
%
period = 1/fs;
inlet = 0:period:(period*(length(data(1,:))-1));
outlet = [ ];
for n = 1:length(data)
	if data(n) > 0
		outlet(end+1) = inlet(n);
	end
end
