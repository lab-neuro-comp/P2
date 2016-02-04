function [handles] = set_signal_to_analyze(handles, inlet)
popupindex = get(handles.PopupCurrentSignal, 'Value');
more = 0;
if isequal(get_yielding(handles), 'Details')
    more = get(handles.PopupWaveletLevel, 'Value');
end
handles.decomposition{popupindex + more} = inlet;
