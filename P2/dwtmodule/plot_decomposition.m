function [handles] = plot_decomposition(handles)
% Plots many DWT signals
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
function [data] = what_to_plot(decomposition, what)
% Determines whether one should plot approximations or details or nothing
data = {};

if ~isequal(length(decomposition), 0)
    % TODO: implement division of data here.
    [lowerbound, upperbound] = get_boundaries(what, length(decomposition));

    for n = lowerbound:upperbound
        data{length(data)+1} = decomposition{n};
    end
end

% ---------------------------------------------------------------------------
function [lowerbound, upperbound] = get_boundaries(what, limit)
if isequal(what, 'Approximations')
    lowerbound = 1;
    upperbound = limit/2;
else
    lowerbound = limit/2 + 1;
    upperbound = limit;
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
