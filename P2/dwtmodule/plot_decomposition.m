function [handles] = plot_decomposition(handles)
% handles the handles for the
decomposition = what_to_plot(handles.decomposition, get_yielding(handles));
limit = length(decomposition)+1;

how_many_plots(handles, limit);
choose_plot(handles.plots, 1);
context_plot(handles.signal);

for index = 2:limit
    choose_plot(handles.plots, index);
    context_plot(decomposition{index-1});
end

% ---------------------------------------------------------------------------
function [data] = what_to_plot(decomposition, what) % determines whether one should plot
                                                    % approximations or details or nothing
if isequal(length(decomposition), 0)
    data = {};
    return
end

% TODO: implement division of data here.
limit = length(decomposition);
if isequal(what, 'Approximations')
    data = decomposition{1:limit/2};
elseif isequal(what, 'Details')
    data = decomposition{((limit/2)+1):limit};
end

% ---------------------------------------------------------------------------
function choose_plot(plots, what) % determines which plot to use
axes(plots(what));

% ---------------------------------------------------------------------------
function [step] = get_step(signal) % get step to use in plot based on Frequency
global fs
step = 0:1/fs:(length(signal) - 1)/fs;

% --------------------------------------------------------------------------
function context_plot(signal) % plot the current signal on screen
plot(get_step(signal), signal);
