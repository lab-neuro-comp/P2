%% setup_for_eeglab: gets the UI ready for the EEGLAB processing program
function [errors] = setup_for_eeglab(handles)
errors = false;

% turn off P!! stuff
set(handles.checkMultiple, 'String', 'Chop signals?');

% turn on EEGLAB stuff
set(handles.checkRerefer, 'Visible', 'on');
set(handles.checkRerefer, 'Value', false);
set(handles.editRerefer, 'Visible', 'on');
set(handles.editRerefer, 'Enable', 'inactive');
set(handles.checkResample, 'Visible', 'on');
set(handles.checkResample, 'Value', false);
set(handles.editResample, 'Visible', 'on');
set(handles.editResample, 'Enable', 'inactive');
set(handles.checkICA, 'Visible', 'on');