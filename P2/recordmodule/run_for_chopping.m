function [errors] = run_for_chopping(handles)
errors = true;
msgbox('Not implemented yet!');
% TODO Write code to chop signals based on a file
set(handles.buttonRun, 'String', 'Running...');
inputfile = get(handles.editInput, 'String');
[filelist fslist intslist] = recordmodule_readcsv(inputfile);
set(handles.buttonRun, 'String', 'Run');
