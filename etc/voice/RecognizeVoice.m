function RecognizeVoice(testcase, density, windowsize)
% Recognizes where the voice in a WAV file begins based
% on a chosen lower density and a defined windowsize
[recording, samplerate, nbits] = wavread(testcase);
limit = length(recording);
idea_of_threshold = mean(recording) + std(recording);
voice_file = recognize_voice(recording, idea_of_threshold);
intervals_file = recognize_density(voice_file, density, windowsize);
recognition = load_intervals(intervals_file, limit);
steps = 1:limit;
delete(voice_file);
movefile(intervals_file, strcat(testcase, '.ascii'));
figure;
plot(steps, recording, 'b', ...
     steps, recognition, 'r');

% --- RECOGNIZE VOICE ---------------------------------------------------------
function [output_file] = recognize_voice(data, threshold)
input_file = export_data(imag(hilbert(data)));
output_file = 'threshold.ascii';
inlet = fopen(input_file, 'r');
outlet = fopen(output_file, 'wt');
apply_threshold(inlet, outlet, threshold);
fclose(inlet);
fclose(outlet);
delete(input_file);

function apply_threshold(inlet, outlet, threshold)
before = fgetl(inlet);
while ischar(before)
    if abs(str2num(before)) > threshold
        after = 1;
    else
        after = 0;
    end
    fprintf(outlet, '%f\n', after);
    before = fgetl(inlet);
end

function [where] = export_data(data)
where = 'export.ascii';
fp = fopen(where, 'wt');
fprintf(fp, '%f\n', data);
fclose(fp);

function [data] = import_data(where)
data = [];
inlet = fopen(where);
it = fgetl(inlet);
while ischar(it)
	data(length(data)+1) = str2num(it);
	it = fgetl(inlet);
end
fclose(inlet);

% --- RECOGNIZE DENSITY -------------------------------------------------------

%% calculate_dot_density: Get the dot density of a bitset
function [output_file] = recognize_density(input_file, density, windowsize)
% Get the dot density of a bitset
hole = floor(sqrt(windowsize));
output_file = 'density.ascii';
% sideeffect_file = 'fx.ascii';
inlet = fopen(input_file);
% fxlet = fopen(sideeffect_file, 'wt');
outlet = fopen(output_file, 'wt');
last = 0;
linenumber = 1;
queue = make_queue(inlet, windowsize);
while length(queue) > 0
    dot_density = sigmoid(calculate_dot_density(queue));
    % fprintf(fxlet, '%f\n', dot_density);
    current = dot_density >= density;
    if current > last % is rising?
        fprintf(outlet, '%f\n', linenumber);
    end
    last = current;
    linenumber = linenumber + hole;
    queue = update_queue(inlet, queue, windowsize);
end
fclose(inlet);
% fclose(fxlet);
fclose(outlet);

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

% --- LOAD INTERVALS ----------------------------------------------------------
%% load_intervals: Load the intervals file
function [intervals] = load_intervals(intervals_file, limit)
% Load the intervals file
inlet = fopen(intervals_file);
intervals = [];
it = fgetl(inlet);
while ischar(it)
    intervals(str2num(it)) = 1;
    it = fgetl(inlet);
end
intervals(limit) = 0;
fclose(inlet);

% --- SIGMOID -----------------------------------------------------------------
%% sigmoid: Learning curve function
function [S] = sigmoid(x)
% Function to be used during learning process

S = 2 * x^2 / (1 + x^2); 
% S = erf(x * sqrt(pi) / 2);