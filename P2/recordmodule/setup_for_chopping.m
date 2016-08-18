%% setup_for_protolize: gets the UI ready for the P!! processing program
function [errors] = setup_for_chopping(handles)
errors = false;

% turn everything off
set(handles.checkMultiple, 'Visible', 'off');
set(handles.checkRerefer, 'Visible', 'off');
set(handles.editRerefer, 'Visible', 'off');
set(handles.checkResample, 'Visible', 'off');
set(handles.editResample, 'Visible', 'off');
set(handles.checkICA, 'Visible', 'off');