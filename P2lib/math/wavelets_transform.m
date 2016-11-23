function [apps dtls] = wavelets_transform(signal, level, transform)
% Assesses the wavelets transform of the given signal by given number of
% levels.
%
%     [apps dtls] = wavelets_transform(signal, level, transform)
%
% Returns the signal's approximations and details as cell arrays of length
% `level`. The contents of these approximations and details depend on the string
% `transform`, that determines which mother wavelet to be used.
[apps dtls] = trans_loop(signal, {}, {}, 1, level, transform);

function [apps dtls] = trans_loop(signal, apps, dtls, level, limit, trans)
if level <= limit
    [app dtl] = dwt(signal, trans);
    [apps dtls] = trans_loop(app, ...
                             push_cell(apps, app), ...
                             push_cell(dtls, dtl), ...
                             level + 1, limit, trans);
end
