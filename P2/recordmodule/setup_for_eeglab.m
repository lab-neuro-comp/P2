%% setup_for_eeglab: gets the UI ready for the EEGLAB processing program
function [errors] = setup_for_eeglab(handles)
errors = false;

% turn off P!! stuff
set(handles.checkMultiple ,'Visible', 'off');

% turn on EEGLAB stuff
