%% Turns a table described in data into a csv string with descriptions.
function [csv] = table2csv(horizontalTags, verticalTags, data)
csv = '';

% TODO Check if tags are ok
% Building first line
line = ' ';
for n = 1:length(horizontalTags)
	tag = horizontalTags{n};
	line = strcat(line, sprintf(';\t%s', tag));
end
csv = strcat(csv, sprintf('%s\r\n', line));

% Building following lines
limit = length(horizontalTags);
for n = 1:length(verticalTags)
	line = verticalTags{n};
	for m = 1:limit
		value = sprintf(';\t%.3f', data{m, n});
		line = strcat(line, value);
	end
	csv = strcat(csv, sprintf('%s\r\n', line));
end
