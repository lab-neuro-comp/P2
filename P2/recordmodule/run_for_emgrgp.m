%% run_for_emgrgp: Separate EMG and GSR in a signal
function [errors] = run_for_emgrgp(handles)
% Separate EMG and GSR in a signal
errors = true;
set(handles.buttonRun, 'String', 'Running...');
inlet = split_string(get(handles.editInput, 'String'), ';');
% TODO for each given param file, separate each signal
for n = 1:length(inlet)
    stuff = recordmodule_parsefiles(inlet{n}); % TODO extract test cases
    for m = 1:length(stuff)
        recordmodule_respostagalvanica(stuff{m});
    end
end
set(handles.buttonRun, 'String', 'Run');
