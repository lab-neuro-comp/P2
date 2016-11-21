%% run_for_protolize: Runs the Protolize processing program
function [errors] = run_for_protolize(handles)
% handles  the handles variable from the UI
javaaddpath(strcat(pwd, '/edf.jar'));
set(handles.buttonRun, 'String', 'Running...');
stuff = split_string(get(handles.editInput, 'String'), ';');
errors = false; % this variable is useless right now
for i = 1:length(stuff)
    multiple = get(handles.checkMultiple, 'Value');
    errors = errors || ConvertEDF2ASCII(stuff{i}, multiple);
end
set(handles.buttonRun, 'String', 'Run');
msgbox('Done!');

function [errors] = ConvertEDF2ASCII(file, multiple)
errors = false;
edf = br.unb.biologiaanimal.edf.EDF(file);
if multiple
    % TODO Turn this into multiple files
    n = length(outlet);
    while ~isequal(outlet(n), '.')
        n = n - 1;
    end
    root = file(1:n);
    labels = edf.getLabels();
    for n = 1:length(labels)
        label = char(labels(n));
        outlet = strcat(root, label, '.ascii');
        edf.toSingleChannelAscii(outlet, label);
    end
else
    outlet = file;
    n = length(outlet);
    while ~isequal(outlet(n), '.')
        n = n - 1;
    end
    outlet = strcat(outlet(1:n), 'ascii');
    edf.toAscii(outlet);
end
