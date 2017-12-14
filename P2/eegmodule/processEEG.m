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
msgHandle = 0;
needCut = 0;

if (isequal(checkRerefer, 1) | isequal(checkRemove, 1) | isequal(checkInfo, 1) | isequal(checkICA, 1))
    for n = 1:size(ints_table)
        isFull = strcmp(lower(ints_table{n, 6}), 'full');
        if isFull
            % Variables
            arqedf = ints_table{n, 10};
            int1 = ints_table{n, 7}
            int2 = ints_table{n, 8}
            samplingRate = ints_table{n, 9};
            
            % Loading EDF
            msgHandle = confirm_window(checkShow, 'Loading EDF...', 1, msgHandle);
            
            % Checks whether the EDF needs to be cut or not
            if ((int1 == 0) && (int2 == 0))
                EEG = pop_biosig(arqedf, 'rmeventchan', 'off');
            else
                blockrange = floor([int1 int2]);
                EEG = pop_biosig(arqedf, 'blockrange', blockrange, 'rmeventchan', 'off');
            end
            
            [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                                 'setname', ints_table{n, 11},...
                                                 'overwrite', 'on');
            msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            
            % Rerefering EDF
            if isequal(checkRerefer, 1)
                msgHandle = confirm_window(checkShow, 'Rerefering EDF...', 1, msgHandle);

                % Checking if previous selections can be reused
                channelsCodeRerefer = getChannelsCode({EEG.chanlocs.labels});
                if rereferReuse.containsKey(channelsCodeRerefer)
                    fprintf('Reusing previous selection');
                    toBeRerefered = rereferReuse.get(channelsCodeRerefer);
                else
                    h = msgbox('Choose the channel for rerefering:');
                    toBeRerefered = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
                    
                    try
                        close(h);
                    end

                    if toBeRerefered > 0
                        rereferReuse.put(channelsCodeRerefer, toBeRerefered);
                    end
                end
                % Rerefering all channels according to new reference
                if toBeRerefered > 0
                    EEG = pop_reref(EEG, toBeRerefered);
                    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);                
                end
                msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            end

            % Remove EDF channels
            if isequal(checkRemove, 1)
                msgHandle = confirm_window(checkShow, 'Removing channels...', 1, msgHandle);

                % Checking if previous selections can be reused
                channelsCodeRemove = getChannelsCode({EEG.chanlocs.labels});
                if cutReuse.containsKey(channelsCodeRemove)
                    fprintf('Reusing previous selection');
                    toRemove = cutReuse.get(channelsCodeRemove);
                else
                    h = msgbox('Choose the channels to be removed:');
                    toRemove = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
                    
                    try
                        close(h);
                    end
                    
                    if toRemove > 0
                        cutReuse.put(channelsCodeRemove, toRemove);
                    end
                end
                % Removing channels
                if toRemove > 0
                    EEG = pop_select(EEG, 'nochannel', toRemove);
                    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                end
                msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            end

            % Saving suject info
            if isequal(checkInfo, 1)
                msgHandle = confirm_window(checkShow, 'Saving subject info...', 1, msgHandle);

                EEG = eeg_checkset(EEG);
                EEG = pop_editset(EEG, 'subject', ints_table{n, 2}, ...
                                       'condition', ints_table{n, 3}, ...
                                       'session', ints_table{n, 4}, ...
                                       'group', ints_table{n, 5});
                [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            end

            % Running ICA
            if isequal(checkICA, 1)
                msgHandle = confirm_window(checkShow, 'Running ICA...', 1, msgHandle);

                EEG = eeg_checkset(EEG);

                % Resampling the dataset to make ICA faster
                if samplingRate > 200
                    resamplingRate = 200;
                    EEG = pop_resample(EEG, resamplingRate);
                    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
                end
            
                EEG = pop_runica(EEG, 'icatype', 'runica',...
                                      'options', { 'extended' 1 });
                [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            end

            % Storing data
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            EEG = pop_saveset(EEG, 'filename', ints_table{n, 11}, ...
                                   'filepath', output_folder);

            clear EEG;

        elseif ((~isFull) && (~needCut))
            needCut = 1;
        end
    end
end

% User has to do these steps manually
if (isequal(checkArtifacts, 1) | isequal(checkLocate, 1))
    for n = 1:size(ints_table)
        if strcmp(lower(ints_table{n, 6}), 'full');
            % Loading SET
            arqset = ints_table{n, 11};
            EEG = pop_loadset( 'filename', arqset, 'filepath', output_folder);
            
            h = msgbox({['Analysing']; [arqset]});

            % Removing artifacts
            if isequal(checkArtifacts, 1)
                msgHandle = confirm_window(checkShow, 'Removing artifacts...', 1, msgHandle);

                pop_eegplot(EEG, 0);
                pop_eegplot(EEG);
                EEG = pop_subcomp(EEG);
                rmvagain = 'Yes';

                while strcmp(rmvagain, 'Yes')
                    rmvagain = questdlg('Would you like to remove some other component?', ...
                                        'Remove Component', ...
                                        'Yes', 'No', 'Yes');
                    switch rmvagain
                        case 'Yes'
                            pop_eegplot(EEG, 0);
                            pop_eegplot(EEG);
                            EEG = pop_subcomp(EEG);
                        case 'No'
                            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                    end
                end
                msgHandle = confirm_window(checkShow, '', 0, msgHandle);
            end

            % Locating electrodes
            if isequal(checkLocate, 1)
                msgHandle = confirm_window(checkShow, 'Locating electrodes...', 1, msgHandle);

                EEG = pop_chanedit(EEG);
                [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
                confirm_window(checkShow, '', 0, msgHandle);
            end

            try
                close(h);
            end

            % Storing data
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            EEG = pop_saveset(EEG, 'filename', ints_table{n, 11}, ...
                                   'filepath', output_folder);

            clear EEG;
        end
    end
end

% Process goes back to be fully automatic
if needCut
    for n = 1:size(ints_table)
        if ~strcmp(lower(ints_table{n, 6}), 'full');
            % Variables
            arqset = ints_table{n, 10};
            int1 = ints_table{n, 7}
            int2 = ints_table{n, 8}
            blockrange = floor([int1 int2]);

            % Loading analised dataset
            EEG = pop_loadset(arqset);
            % Opens new dataset with EEG
            [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                                             'setname', ints_table{n, 11},...
                                                             'overwrite', 'on');

            % Cuts dataset according to int1 and int2
            EEG = pop_select(EEG, 'time', blockrange);
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            
            EEG = eeg_checkset(EEG);
            EEG = pop_editset(EEG, 'subject', ints_table{n, 2}, ...
                                   'condition', ints_table{n, 3}, ...
                                   'session', ints_table{n, 4}, ...
                                   'group', ints_table{n, 5});

            % Storing data
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            EEG = pop_saveset(EEG, 'filename', ints_table{n, 11}, ...
                                   'filepath', output_folder);

            clear EEG;
        end
    end
end

% Creating epochs
%if isequal(checkEvent, 1)
    for n = 1:size(ints_table)
        if strcmp(lower(ints_table{n, 6}), 'full');
            arqset = ints_table{n, 10};
            EEG = pop_loadset(arqset);

            msgHandle = confirm_window(checkShow, 'Creating epochs...', 1, msgHandle);

            EEG = pop_editeventfield(EEG, 'type', 1, 'latency', 0);
            for j = (n + 1):size(ints_table)
                [filepath, name, ext] = fileparts(ints_table{j, 10});

                if strcmp(strcat(name, ext), ints_table{n, 11})
                    typeEvent = ints_table{j, 6}
                    latency = ints_table{j, 7} - ints_table{n, 7};
                    EEG = pop_editeventvals(EEG, 'append', {1 typeEvent latency});
                    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
                end
            end
            EEG = pop_editeventvals(EEG, 'delete', 1);
            EEG = pop_epoch(EEG, {}, [0 (ints_table{j, 8} - ints_table{j, 7})]);
            [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
            msgHandle = confirm_window(checkShow, '', 0, msgHandle);
        end
    end
%end