function paramain(folder)
% Runs the separated process of extracting samples of recording and calculating
% the STFT for each one of them.
%
% Usually called as `paramain ..\..\b\SST` or
% `paramain ..\..\..\SST\data\ns\EEG\edf`


% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% Deleting ids file
idsFile = strcat(folder, filesep, 'ids.txt');
if isequal(exist(idsFile, 'file'), 2)
	delete(idsFile);
end

% Running procedure
generateChopsOnly(folder);
calculateStftOnly(folder);
