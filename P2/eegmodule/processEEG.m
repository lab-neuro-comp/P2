function processEEG(inputfile, eeglab_path, eegloc_path, output_folder, options)
% Runs the standard processing routine for EEG signals.
%
% Parameters:
% - inputfile: a XLS file containing the API format for organizing recordings.
% - eeglab_path: the path to the EEGLab application suite.
% - eegloc_path: the path to the locations file to be used on this processing.
% - output_folder: where to store the produced data
% - options: a vector of booleans describing what to do on this processing.
%   Namely, they must be in this order:
%   + Show processing steps?
%   + Rerefer?
%   + Remove channels?
%   + Locate electrodes?
%   + Save subject's info?
%   + Run ICA?
%   + Remove artifacts?
%

% TODO Add example call
% TODO Add a button to cancel the process

% [A, T] = xlsread(get(handles.editTable, 'String'));
ints_table = ler_arq_ints(inputfile);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Setting options
checkShow = options(1);
checkRerefer = options(2);
checkRemove = options(3);
checkLocate = options(4);
checkInfo = options(5);
checkICA = options(6);
checkArtifacts = options(7);

% Preparing channel selection for reuse
rereferReuse = java.util.HashMap;
cutReuse = java.util.HashMap;

for n = 1:size(ints_table)
    % Variables
    arqedf = ints_table{n, 10};
    int1 = ints_table{n, 7};
    int2 = ints_table{n, 8};
    samplingRate = ints_table{n, 9};
    blockrange = floor([int1 int2]);

    % Loading EDF
    EEG = pop_biosig(arqedf, 'blockrange', blockrange, 'rmeventchan', 'off');
    confirm_window(checkShow, 'EDF Loaded');

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                         'setname', ints_table{n, 11},...
                                         'overwrite', 'on');

    % Rerefering EDF
    if isequal(checkRerefer, 1)
        % Checking if previous selections can be reused
        channelsCodeRerefer = getChannelsCode({EEG.chanlocs.labels});
        if rereferReuse.containsKey(channelsCodeRerefer)
            fprintf('Reusing previous selection');
            toBeRerefered = rereferReuse.get(channelsCodeRerefer);
        else
            h = msgbox('Choose the channel for rerefering:');
            toBeRerefered = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
            close(h);
            if toBeRerefered > 0
                rereferReuse.put(channelsCodeRerefer, toBeRerefered);
            end
        end
        % Rerefering all channels according to new reference
        if toBeRerefered > 0
            EEG = pop_reref(EEG, toBeRerefered);
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            confirm_window(checkShow, 'EDF Rerefered');
        end
    end

    % Remove EDF channels
    if isequal(checkRemove, 1)
        % Checking if previous selections can be reused
        channelsCodeRemove = getChannelsCode({EEG.chanlocs.labels});
        if cutReuse.containsKey(channelsCodeRemove)
            fprintf('Reusing previous selection');
            toRemove = cutReuse.get(channelsCodeRemove);
        else
            h = msgbox('Choose the channels to be removed:');
            toRemove = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
            close(h);
            if toRemove > 0
                cutReuse.put(channelsCodeRemove, toRemove);
            end
        end
        % Removing channels
        if toRemove > 0
            EEG = pop_select(EEG, 'nochannel', toRemove);
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            confirm_window(checkShow, 'EDF Channels Cut');
        end
    end

    % Saving suject info
    if isequal(checkInfo, 1)
        EEG = eeg_checkset(EEG);
        EEG = pop_editset(EEG, 'subject', ints_table{n, 1}, ...
                               'condition', ints_table{n, 2}, ...
                               'session', ints_table{n, 6}, ...
                               'group', ints_table{n, 4});
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'Subject Info Saved');
    end

    % Running ICA
    if isequal(checkICA, 1)
        EEG = eeg_checkset(EEG);

        % Resampling the dataset to make ICA faster
        if samplingRate >= 500
            resamplingRate = 500;
        else
            resamplingRate = samplingRate;
        end
    
        EEG = pop_resample(EEG, resamplingRate);
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

        EEG = pop_runica(EEG, 'icatype', 'runica',...
                              'options', { 'extended' 1 },...
                              'chanind', [ 1:21 ]);
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'ICA Completed');
    end

    % Storing data
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    EEG = pop_saveset(EEG, 'filename', ints_table{n, 11}, ...
                           'filepath', output_folder);

    clear EEG;
end

% User has to do these steps manually
for n = 1:size(ints_table)
    % Loading SET
    arqset = ints_table{n, 11};
    EEG = pop_loadset( 'filename', arqset, 'filepath', output_folder);

    % Removing artifacts
    if isequal(checkArtifacts, 1)
        pop_eegplot(EEG);
        EEG = pop_subcomp(EEG);
        rmvagain = 'Yes';

        while strcmp(rmvagain, 'Yes')
            rmvagain = questdlg('Would you like to remove some other component?', ...
                                'Remove Component', ...
                                'Yes', 'No', 'Yes');
            switch rmvagain
                case 'Yes'
                    pop_eegplot(EEG);
                    EEG = pop_subcomp(EEG);
                case 'No'
                    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                    confirm_window(checkShow, 'Components Removed');
            end
        end
    end

    % Locating electrodes
    if isequal(checkLocate, 1)
        EEG = pop_chanedit(EEG);
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'Electrodes Located');
    end

    % Storing data
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    EEG = pop_saveset(EEG, 'filename', ints_table{n, 11}, ...
                           'filepath', output_folder);

    clear EEG;
end
