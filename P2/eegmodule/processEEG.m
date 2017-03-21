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
checkCut = options(3);
checkLocate = options(4);
checkInfo = options(5);
checkICA = options(6);
checkArtifacts = options(7);

% Preparing channel selection for reuse
rereferReuse = java.util.HashMap;
cutReuse = java.util.HashMap;

studyName = strcat(output_folder, 'Study_', date, '.study');
[STUDY ALLEEG] = pop_study( [], [] );

%Iniciar varredura para corte de intervalos
for n = 1:size(ints_table)
    % Variables
    arqedf = ints_table{n, 9};
    int1 = ints_table{n, 5};
    int2 = ints_table{n, 6};
    edfinfo = br.unb.biologiaanimal.edf.EDF(arqedf);
    samplingRate = edfinfo.getSamplingRate();
    blockrange = floor([int1/samplingRate int2/samplingRate]);

    % Loading EDF
    EEG = pop_biosig(arqedf, 'blockrange', blockrange, 'rmeventchan', 'off');
    confirm_window(checkShow, 'EDF Loaded');

    arqset = change_extension(arqedf, 'set');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                         'setname', arqset,...
                                         'overwrite', 'on');

    % Rerefering EDF
    if isequal(checkRerefer, 1)
        % Checking if previous selections can be reused
        channelsCode = getChannelsCode(edfinfo);
        if rereferReuse.containsKey(channelsCode)
            fprintf('Reusing previous selection');
            toBeRerefered = rereferReuse.get(channelsCode);
        else
            toBeRerefered = rerefermodule(edfinfo);
            if toBeRerefered > 0
                rereferReuse.put(channelsCode, toBeRerefered);
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
    if isequal(checkCut, 1)
        % Checking if previous selections can be reused
        channelsCode = getChannelsCode(edfinfo);
        if cutReuse.containsKey(channelsCode)
            fprintf('Reusing previous selection');
            toRemove = cutReuse.get(channelsCode);
        else
            toRemove = removemodule(edfinfo);
            if ~isempty(toRemove)
                cutReuse.put(channelsCode, toRemove);
            end
        end
        % Removing channels
        if ~isempty(toRemove)
            EEG = pop_select(EEG, 'nochannel', toRemove);
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
            confirm_window(checkShow, 'EDF Channels Cut');
        end
    end

    % Locating electrodes
    if isequal(checkLocate, 1)
        % TODO Check if this loading is correct
        EEG = pop_chanedit(EEG, 'load', eegloc_path);
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'Electrodes Mapped');
    end

    % Saving suject info
    if isequal(checkInfo, 1)
        EEG = eeg_checkset(EEG);
        EEG = pop_editset(EEG, 'subject', ints_table{n, 2});
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'Subject Info Saved');
    end

    % Running ICA
    if isequal(checkICA, 1)
        EEG = eeg_checkset(EEG);

        % TODO Resample the dataset to make ICA faster
        %EEG = pop_resample( EEG, freq);
        %[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        EEG = pop_runica(EEG, 'icatype', 'runica',...
                              'options', {'extended' 1},...
                              'chanind', [ 1:21 ]);
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        confirm_window(checkShow, 'ICA Completed');
    end

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
                    EEG = pop_subcomp(EEG);
                case 'No'
                    confirm_window(checkShow, 'Components Removed');
            end
        end
    end

    % Storing data
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    [arqsetpath, arqsetname, arqsetext] = fileparts(arqset);
    EEG = pop_saveset(EEG, 'filename', strcat(arqsetname, arqsetext), ...
                           'filepath', output_folder);

    % Adding to STUDY
    setFile = strcat(output_folder, arqsetname, arqsetext)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, ...
                                'name', studyName, ...
                                'filename', strcat('/Study_', date), ...
                                'filepath', output_folder, ...
                                'commands', ...
                                {'index', n, ...
                                'load', setFile, ...
                                'subject', ints_table{n, 1}, ...
                                'session', ints_table{n, 8}});
end


% TODO Replace this mesage with a dialog box
fprintf('\t\tDEKITA~! o/\n');
