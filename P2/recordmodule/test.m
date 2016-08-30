function test()
handles = { };
handles.editInput = { };
handles.buttonRun = { };
addpath('..\util');
addpath('..\math');
addpath('..\edition');
inputfile = 'C:\Users\cris\Documents\work\Lab\EEG\data\chop\arqints.csv';
set(handles.editInput, 'String', inputfile);
set(handles.buttonRun, 'String', 'Run');

disp('# Testing reading input file');
[filelist fslist cutlist intslist] = recordmodule_readcsv(inputfile);
outlet = recordmodule_work(filelist, fslist, intslist);
recordmodule_savedata(filelist, cutlist, outlet);

disp('# Final test');
run_for_chopping(handles);
