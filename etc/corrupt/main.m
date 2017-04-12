function main(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%
% Right now it is being called as `main ..\..\b\SST` or
% `main ..\..\..\SST\data\ns\EEG\edf`
%
% The current idea of this procedure is to extract a sample of the signal and
% calculate its DWT, trying to filter the signal in an useful way.
%

% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% Running procedure
% TODO Load files
files = getEDFs(folder);
% TODO Filter them using the DWT
% TODO Save files to memory
