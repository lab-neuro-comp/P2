function [handles] = set_signal_to_analyze(handles, inlet)
% alters the decomposition structure after the alterations made by the user.
% @param  handles  the handles to the structures in the window.
% @param  inlet    the edited decomposed signal.
% @return handles with the appropriate side-effects.
currentsignal_index = get(handles.PopupCurrentSignal, 'Value');
{choosen_wavelet choosen_level} = handles.lastwavelet;
sublevel = choosen_level - currentsignal_index;
[dec book] = wavedec(inlet, sublevel, choosen_wavelet);
stuff = get_decomposition(dec, book);

if isequal(get_yielding(handles), 'Details')
    more = get(handles.PopupWaveletLevel, 'Value');
else
    more = 0;
end

handles.decomposition{currentsignal_index + more} = inlet;

% -------------------------------------------------------------------------------------
function [handles] = old_set_signal_to_analyze(handles, inlet)
popupindex = get(handles.PopupCurrentSignal, 'Value');
more = 0;
if isequal(get_yielding(handles), 'Details')
    more = get(handles.PopupWaveletLevel, 'Value');
end
handles.decomposition{popupindex + more} = inlet;
