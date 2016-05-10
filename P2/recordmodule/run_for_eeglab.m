%% run_for_protolize: Runs the Protolize processing program
function [errors] = run_for_eeglab(handles)
% handles  the handles variable from the UI
errors = false;

% gets and sets variables
set(handles.buttonRun, 'String', 'Running...');
must_chop = get(handles.checkMultiple, 'Value');
must_rerefer = get(handles.checkRerefer, 'Value');
must_resample = get(handles.checkResample, 'Value');
sampling_rate= str2num(handles.constants.get('fs'));
new_reference = '';
resample_rate = -1;
if must_rerefer
	new_reference = get(handles.editRerefer, 'String');
end
if must_resample
	resample_rate = str2num(get(handles.editResample, 'String'));
end

% loop through files
stuff = split_string(get(handles.editInput, 'String'), ';');
for i = 1:length(stuff)
    deal_with_eeglab(stuff{i}, must_chop, new_reference, resample_rate);
end

% return to previous UI state
set(handles.buttonRun, 'String', 'Run');