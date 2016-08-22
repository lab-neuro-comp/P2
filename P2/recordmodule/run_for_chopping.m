function [errors] = run_for_chopping(handles)
errors = true;
set(handles.buttonRun, 'String', 'Running...');
inputfile = get(handles.editInput, 'String');
[filelist fslist intslist] = recordmodule_readcsv(inputfile);
outlet = recordmodule_work(filelist, fslist, intslist);
recordmodule_savedata(filelist, outlet);
set(handles.buttonRun, 'String', 'Run');
