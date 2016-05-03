%% run_for_protolize: Runs the Protolize processing program
function [errors] = run_for_protolize(handles)
set(handles.buttonRun, 'String', 'Running...');
stuff = split_string(get(handles.editInput, 'String'), ';');
for i = 1:length(stuff)
    errors = ConvertEDF2ASCII(stuff{i}, get(handles.checkMultiple, 'Value'));
end
set(handles.buttonRun, 'String', 'Run');
msgbox('Done!');