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