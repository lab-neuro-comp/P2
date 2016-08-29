function [output_file] = recognize_density(input_file, density, windowsize)
% Get the dot density of a bitset
hole = floor(sqrt(windowsize));
sideeffect_file = 'fx.ascii';
output_file = 'density.ascii';
inlet = fopen(input_file);
fxlet = br.eng.crisjr.buffer.Buffer(sideeffect_file);
outlet = br.eng.crisjr.buffer.Buffer(output_file);
% fxlet = fopen(sideeffect_file, 'wt');
% outlet = fopen(output_file, 'wt');
last = 0;
linenumber = 1;
queue = make_queue(inlet, windowsize);
while length(queue) > 0
    % TODO Analyze derivative of queue
    dot_density = sigmoid(calculate_dot_density(queue));
    fxlet.write(sprintf('%f\n', dot_density));
    % fprintf(fxlet, '%f\n', dot_density);
    current = dot_density >= density;
    if current > last % is rising?
        outlet.write(sprintf('%f\n', linenumber));
        % fprintf(outlet, '%f\n', linenumber);
    end
    last = current;
    linenumber = linenumber + hole;
    queue = update_queue(inlet, queue, windowsize);
end
fclose(inlet);
close(fxlet);
close(outlet);
% fclose(fxlet);
% fclose(outlet);

function [queue] = make_queue(inlet, windowsize)
queue = [];
for n = 1:windowsize
    queue(length(queue)+1) = str2num(fgetl(inlet));
end

function [density] = calculate_dot_density(queue)
density = 0;
for item = queue
    density = density + item;
end
density = density / length(queue);

function [queue] = update_queue(inlet, queue, windowsize)
limit = floor(sqrt(windowsize));
data = fgetl(inlet);
n = 1;
if ischar(data)
    queue = queue(limit:length(queue));
    while and(n <= limit, ischar(data))
        queue(length(queue)+1) = str2num(data);
        data = fgetl(inlet);
        n = n+1;
    end
else
    queue = [];
end
