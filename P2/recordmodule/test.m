function test()
handles = { };
handles.editInput = { };
handles.buttonRun = { };
addpath('..\util');
inputfile = 'C:\Users\cris\Documents\work\Lab\EEG\data\chop\arqints.csv';
set(handles.editInput, 'String', inputfile);
set(handles.buttonRun, 'String', 'Run');

disp('# Testing reading input file');
[filelist fslist intslist] = recordmodule_readcsv(inputfile);

disp('# Final test');
run_for_chopping(handles);
