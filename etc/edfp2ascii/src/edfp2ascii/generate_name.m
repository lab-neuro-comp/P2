function [outlet] = generate_name(inlet, ext)
outlet = strcat(inlet(1:get_offset(inlet)), ext);
function [offset] = get_offset(inlet)
offset = get_offset_loop(inlet, length(inlet));
function [offset] = get_offset_loop(inlet, where)
if isequal(inlet(where), '.')
	offset = where-1;
else
	offset = get_offset_loop(inlet, where-1);
end