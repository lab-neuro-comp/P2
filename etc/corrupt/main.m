function main(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%

% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% The current idea of this procedure is to calculate the RMS power for each
% channel.
dirData = dir(folder);
dirIndex = [ dirData.isdir ];
files = { dirData(~dirIndex).name };

for file = files
	disp(file);
	% TODO Calculate RMS for each channel
	% TODO Store RMS
end
