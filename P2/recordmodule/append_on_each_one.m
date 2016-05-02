%% append_on_each_one: append a stirng on a group of strings
function [outlet] = append_on_each_one(inlet, to_append)
outlet = {};
for i = 1:length(inlet)
	outlet{i} = strcat(to_append, inlet{i});
end