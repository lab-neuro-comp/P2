function [outlet] = get_signal_to_analyze(handles)
% TODO Update this to support the new decomposition structure
popupindex = get(handles.PopupCurrentSignal, 'Value');
more = 0;
if isequal(get_yielding(handles), 'Details')
    more = get(handles.PopupWaveletLevel, 'Value');
end
outlet = handles.decomposition{popupindex + more};
