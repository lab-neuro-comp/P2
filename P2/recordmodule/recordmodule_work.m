%% recordmodule_work: Reads every file and cuts them based on the intervals and on the frequency
function [outlet] = recordmodule_work(filelist, fslist, intslist)
% Reads every file and cuts them based on the intervals and on the frequency
outlet = { };
limit = length(filelist);
for index = 1:limit
    inlet = load(filelist{index});
    outlet = chop_signal(inlet, fslist{index}, intslist{index}(1), intslist{index}(2));
    figure;
    plot(1:length(inlet), inlet);
    plot(1:length(outlet), outlet);
end
