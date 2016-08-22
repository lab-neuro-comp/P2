%% recordmodule_work: Reads every file and cuts them based on the intervals and on the frequency
function [outlet] = recordmodule_work(filelist, fslist, intslist)
% Reads every file and cuts them based on the intervals and on the frequency
outlet = { };
limit = length(filelist);
for index = 1:limit
    inlet = load(filelist{index});
    % TODO chop files
    figure;
    plot(1:length(inlet), inlet);
end
