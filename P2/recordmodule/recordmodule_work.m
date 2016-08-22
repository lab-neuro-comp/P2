%% recordmodule_work: Reads every file and cuts them based on the intervals and on the frequency
function [choplist  ] = recordmodule_work(filelist, fslist, intslist)
% Reads every file and cuts them based on the intervals and on the frequency
choplist = { };
limit = length(filelist);
for index = 1:limit
    inlet = load(filelist{index});
    figure;
    plot(1:length(inlet), inlet);
    outlet = chop_signal(inlet, fslist{index}, intslist{index}(1), intslist{index}(2));
    plot(1:length(outlet), outlet);
    choplist{index} = outlet;
end
