function [handles] = processSingleChan(handles)
% Runs the automatic processing steps of a single channel signal.

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Reading parameters file
ints_table = ler_arq_ints(get(handles.editTable, 'String'));

% Different approaches for each file extension
listset = { };
handles.listset = listset;

for n = 1:size(ints_table)
    % Prapring some parameters
    int1 = ints_table{n, 5};
    int2 = ints_table{n, 6};
    samplingRate = ints_table{n, 7};
    blockrange = floor([int1/samplingRate int2/samplingRate]);

    % Loading data
    if get(handles.radioASCII, 'Value')
        arqascii = ints_table{n, 9};
        EEG = pop_importdata('data', arqascii,...
                             'dataformat', 'ascii',...
                             'srate', samplingRate);
    elseif get(handles.radioEDF, 'Value')
        EEG = pop_biosig(arqedf, 'rmeventchan', 'off');
    end

    % Preparing sets' file
    if (get(handles.radioEDA, 'Value'))
        arqset = [ ints_table{n, 1} '-' ...
                   ints_table{n, 3} '-EDA-' ...
                   ints_table{n, 2} '.set' ];
    elseif (get(handles.radioEMG, 'Value'))
        arqset = [ ints_table{n, 1} '-' ...
                   ints_table{n, 3} '-EMG-' ...
                   ints_table{n, 2} '.set' ];
    end
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                         'setname', arqset,...
                                         'overwrite', 'on');

    % Selecting data to keep
    h = msgbox('Cutting dataset...');
    EEG = eeg_checkset(EEG);
    if get(handles.radioEDA, 'Value')
        EEG = pop_select(EEG, 'time', blockrange, 'channel', 'RGP');
    elseif get(handles.radioEMG, 'Value')
        EEG = pop_select(EEG, 'time', blockrange, 'channel', 'EMG');
    end
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    close(h);

    % Storing data
    h = msgbox('Saving dataset...');
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    [arqsetpath, arqsetname, arqsetext] = fileparts(arqset);
    EEG = pop_saveset(EEG, 'filename', strcat(arqsetname, arqsetext), ...
                           'filepath', outputFolder);
    close(h);

    % Adding file to the processed list
    listset{n} = arqset;
    set(handles.listFiles, 'String', listset);
end
