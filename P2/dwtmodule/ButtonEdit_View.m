function [handles] = ButtonEdit_View(handles)
% apply the chosen transformations on the decomposition structure

% # get correct decompositions
decomposition = handles.approximations;
if isequal(get_yielding(handles), 'Details')
    decomposition = handles.details;
end

% # check what to do
if isequal(get(handles.RadioReplace, 'Value'), true)
    % replace signal
elseif isequal(get(handles.RadioConstrain, 'Value'), true)
    % constrain signal
else
    % no EOG right now :(
    return
end

% # determine scope of action
% # edit signal
% # save editions
