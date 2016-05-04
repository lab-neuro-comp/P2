%% setup_for_protolize: gets the UI ready for the P!! processing program
function [errors] = setup_for_protolize(handles)
errors = false;

% turn on P!! stuff
set(handles.checkMultiple, 'String', 'Multiple files?');

% turn off EEGLAB stuff
set(handles.checkRerefer, 'Visible', 'off');
set(handles.editRerefer, 'Visible', 'off');
set(handles.checkResample, 'Visible', 'off');
set(handles.editResample, 'Visible', 'off');
set(handles.checkICA, 'Visible', 'off');