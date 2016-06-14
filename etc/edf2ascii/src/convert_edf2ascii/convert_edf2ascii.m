%% convertedf2ascii: calls a system executable to translate edf files to the ascii format
function [status, cmdout] = convert_edf2ascii(inlet)
[status, cmdout] = system(sprintf('convert_edf2ascii\\edf2ascii "%s" > %s', inlet, create_outlet(inlet)));
% maybe `setenv('INLET', inlet); !edf2ascii.exe $INLET;`

%% create_outlet: creates an output to the input of the function
function [outlet] = create_outlet(inlet)
outlet = create_outlet_loop(inlet, length(inlet));

%% create_outlet_loop: loop for create_outlet function
function [outlet] = create_outlet_loop(inlet, index)
if isequal(inlet(index), '.')
	outlet = [inlet(1:index) 'ascii'];
else
	outlet = create_outlet_loop(inlet, index-1);
end
