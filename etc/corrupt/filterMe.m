function [outlet] = filterMe(inlet)
% TODO Make this magic happen
%
[ apps dtls ] = wavelets_transform(inlet, 5, 'haar');
apps{end} = cell(zeros(1, length(apps{end})));
outlet = inverse_wavelets_transform(apps, dtls, 'haar');
