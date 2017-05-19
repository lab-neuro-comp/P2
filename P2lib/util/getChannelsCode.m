function [channels] = getChannelsCode(labels)
% Turn the labels into'a code for retrieving information later.
%

for n = 1:length(labels)
	newLabels{n} = char(labels(n));
end

channels = join_strings(newLabels, ';');
