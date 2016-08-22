%% recordmodule_savedata: Saves created data into memory into newly coded files
function [newfilelist] = recordmodule_savedata(oldfilelist, data)
% Saves created data into memory into newly coded files
newfilelist = { };
limit = length(oldfilelist);
index = 1;
while index <= limit
    outlet = generate_new_name(oldfilelist{index});
    newfilelist{length(newfilelist)+1} = outlet;
    write_signal(data{index}, outlet);
    index = index + 1;
end

function [outlet] = generate_new_name(inlet)
outlet = strcat(generate_new_name_loop(inlet, length(inlet)), 'chop.ascii');
function [outlet] = generate_new_name_loop(inlet, index)
if isequal(inlet(index), '.')
    outlet = inlet(1:index);
else
    outlet = generate_new_name_loop(inlet, index-1);
end
