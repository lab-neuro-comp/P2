%% run_for_protolize: Runs the Protolize processing program
function [errors] = run_for_eeglab(handles)
% handles  the handles variable from GUIDE
errors = false;

% gets and sets variables
set(handles.buttonRun, 'String', 'Running...');
must_chop = get(handles.checkMultiple, 'Value');
must_ica = get(handles.checkICA, 'Value');
sampling_rate = str2num(handles.constants.get('fs'));
new_reference = iff(get(handles.checkRerefer, 'Value'), ...
                    str2num(get(handles.editRerefer, 'String')), -1);
resample_rate = iff(get(handles.checkResample, 'Value'), ...
                    str2num(get(handles.editResample, 'String')), -1);

% loop through files
stuff = split_string(get(handles.editInput, 'String'), ';');
for i = 1:length(stuff)
    deal_with_eeglab(stuff{i}, ...
                     must_chop, ...
                     new_reference, ...
                     resample_rate, ...
                     sampling_rate, ...
                     must_ica);
end

% return to previous UI state
set(handles.buttonRun, 'String', 'Run');
