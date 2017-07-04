function [r s] = main()
% Full procedure to relate signals and subject data.
%
d = '../../b/';
[r s] = identifySSTEvents([d 'dudu.edf'], [d 'SST-young-serial-1-1.csv']);
