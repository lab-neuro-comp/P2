function [channels] = getChannelsCode(edf)
% Turn the labels into'a code for retrieving information later.
%

rawLabels = edf.getLabels();
labels = { };

for n = 1:length(rawLabels)
	labels{n} = char(rawLabels(n));
end

channels = join_strings(labels, ';');
