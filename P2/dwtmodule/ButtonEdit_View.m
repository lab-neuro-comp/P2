function [handles] = ButtonEdit_View(handles)
% apply the chosen transformations on the decomposition structure
global fs

% # get correct decompositions
decomposition = handles.approximations;
if isequal(get_yielding(handles), 'Details')
    decomposition = handles.details;
end

% # check what to do
chosen_index = get(handles.PopupCurrentSignal, 'Value');
chosen_signal = decomposition{chosen_index};
if isequal(get(handles.RadioReplace, 'Value'), true)
    % replace signal
    chosen_signal = replace_signal(chosen_signal, ...
                                   str2num(get(handles.EditV1, 'String')));
elseif isequal(get(handles.RadioConstrain, 'Value'), true)
    % constrain signal
    chosen_signal = constrain_signal(chosen_signal, ...
                                     str2num(get(handles.EditV2, 'String')), ...
                                     str2num(get(handles.EditV1, 'String')));
else % no EOG right now :(
    warndlg('No EOG edition by now');
    return
end

% # determine scope of action
lowerbound = 1;
upperbound = length(chosen_signal);
if isequal(true, get(handles.CheckInterval, 'Value'))
    lowerbound = floor(str2num(get(handles.EditMinTime, 'String')) * fs);
    upperbound = floor(str2num(get(handles.EditMaxTime, 'String')) * fs);
    if isequal(lowerbound, 0)
        lowerbound = 1;
    elseif or(upperbound <= lowerbound, ...
           or(lowerbound < 0, ...
              upperbound > (length(chosen_signal) * fs)))
        warndlg('boundaries not set correctly');
        return
    end
end

% # edit signal
edited_signal = decomposition{chosen_index};
for index = lowerbound:upperbound
    edited_signal(index) = chosen_signal(index);
end

% # save editions
decomposition{chosen_index} = edited_signal;
if isequal(get_yielding(handles), 'Details')
    handles.details = decomposition;
else
    handles.approximations = decomposition;
end
