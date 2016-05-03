%% setup_for_eeglab: gets the UI ready for the EEGLAB processing program
function [errors] = setup_for_eeglab(handles)
set(handles.checkMultiple ,'Visible', 'off');
errors = false;