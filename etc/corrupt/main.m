function main(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%
% Right now it is being called as `main ..\..\b\SST` or
% `main ..\..\..\SST\data\ns\EEG\edf`
%
% The current idea of this procedure is to extract a sample of the signal and
% calculate its STFT, resulting in a plot that will be analyzed later.
%

% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% Running procedure
if isequal(exist('parfor', 'builtin'), 5)
	disp('Running on parallel');
	generateChopsOnParallel(folder);
	calculateStftOnParallel(folder);
else
	disp('Not running on parallel');
	generateChopsOnly(folder);
	calculateStftOnly(folder);
end
