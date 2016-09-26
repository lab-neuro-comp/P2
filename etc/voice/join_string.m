function [outlet] = join_string(inlet)

outlet = '';

if length(inlet) == 0
	return;
end

outlet = inlet{1};
for n = 2:length(inlet)
	outlet = strcat(outlet, ';', inlet{n});
end