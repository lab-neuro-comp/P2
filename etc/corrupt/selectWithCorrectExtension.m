%% Filtering out files with extensions that are not '*.edf'.
function [outlet] = selectWithCorrectExtension(inlet)
outlet = { };
for n = 1:length(inlet)
	it = inlet{n};
	ext = it(length(it)-3:length(it));
	if isequal('.edf', ext)
		outlet{end+1} = it;
	end
end
