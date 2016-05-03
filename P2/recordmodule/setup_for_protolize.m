%% setup_for_protolize: gets the UI ready for the P!! processing program
function [errors] = setup_for_protolize(handles)
errors = false;

% turn on P!! stuff
set(handles.checkMultiple ,'Visible', 'on');

% turn off EEGLAB stuff

