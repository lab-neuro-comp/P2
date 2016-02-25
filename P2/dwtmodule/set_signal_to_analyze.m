function [handles] = set_signal_to_analyze(handles, inlet)
% alters the decomposition structure after the alterations made by the user.
% @param  handles  the handles to the structures in the window.
% @param  inlet    the edited decomposed signal.
% @return handles with the appropriate side-effects.
currentsignal_index = get(handles.PopupCurrentSignal, 'Value');
memory = handles.lastwavelet;
choosen_wavelet = memory{1};
choosen_level = memory{2};
sublevel = choosen_level - currentsignal_index;
more = length(handles.decomposition)/2;
signal = handles.decomposition{sublevel};

% % deal with it later:
% if isequal(get_yielding(handles), 'Details')
%     do something stupid
% end

sublevel = sublevel+1;
while choosen_level >= sublevel
    % get transform
    [C, L] = wavedec(signal, 1, choosen_wavelet);
    data = get_decomposition(C, L);
    % update decomposition structure
    handles.decomposition{sublevel} = data(1);
    handles.decomposition{sublevel+more} = data(2);
    % prepare next iteration
    signal = data(1);
    sublevel = sublevel+1; % lol
end

% -------------------------------------------------------------------------------------
function [handles] = old_set_signal_to_analyze(handles, inlet)
popupindex = get(handles.PopupCurrentSignal, 'Value');
more = 0;
if isequal(get_yielding(handles), 'Details')
    more = get(handles.PopupWaveletLevel, 'Value');
end
handles.decomposition{popupindex + more} = inlet;
