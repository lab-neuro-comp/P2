function [timevector] = turn_to_time(analysis, recordtime)

timevector = [];
m = 1;
newscale = length(analysis);

% Timevector is an array that contains the times marked during the analysis
for n = 1:length(analysis)
	if analysis(n) == 1
		timevector(m) = (recordtime*n)/newscale;
		m = m + 1;
	end
end