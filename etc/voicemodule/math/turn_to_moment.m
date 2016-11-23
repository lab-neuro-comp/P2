function [momentvector] = turn_to_moment(analysis, timevector, recordtime)

momentvector = zeros(1, length(analysis));
newscale = length(analysis);

for m = 1:length(timevector)
	n = round((timevector(m)*newscale)/recordtime);
	momentvector(n) = 1;
end