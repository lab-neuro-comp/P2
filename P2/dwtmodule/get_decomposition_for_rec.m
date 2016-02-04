function [outlet] = get_decomposition_for_rec(handles)
% extracts the decomposition needed for reconstruction
% from the handles for the signal decomposition
inlet = handles.decomposition;
outlet = append_signal([], inlet{(length(inlet)/2)-1});

n = length(inlet);
limit = length(inlet)/2;
while n >= limit
    outlet = append_signal(outlet, inlet{n});
    n = n-1; % hehehe
end
