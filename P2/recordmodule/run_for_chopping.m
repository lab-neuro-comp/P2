function [errors] = run_for_chopping(handles)
errors = true;
set(handles.buttonRun, 'String', 'Running...');
inputfile = get(handles.editInput, 'String');
[filelist fslist cutlist intslist] = recordmodule_readcsv(inputfile);
outlet = recordmodule_work(filelist, fslist, intslist);
recordmodule_savedata(filelist, cutlist, outlet);
set(handles.buttonRun, 'String', 'Run');
