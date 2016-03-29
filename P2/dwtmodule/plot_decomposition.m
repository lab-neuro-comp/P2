function plot_decomposition(handles)
decomposition = handles.approximations;

if isequal(get_yielding(handles), 'Details')
    decomposition = handles.details;
end
