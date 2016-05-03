%% setup_for_protolize: gets the UI ready for the P!! processing program
function [errors] = setup_for_protolize(handles)
set(handles.checkMultiple ,'Visible', 'on');
errors = false;
