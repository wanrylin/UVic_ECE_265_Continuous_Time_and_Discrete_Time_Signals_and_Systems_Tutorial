%% Tutorial 5: concise complete solutions to 9.201 and 9.202
% Download and fully extract the course companion package. Place this .m file
% and the complete companion folder together in any new folder, as shown below.
% Folder layout: Tutorial5_Lab/tutorial5_matlab_answers.m
%                Tutorial5_Lab/companion/data/audio/
%                Tutorial5_Lab/companion/third_party/
% Some data/audio entries link to third_party files, so keep both folders and
% the companion package's complete internal structure; do not copy only the links.
% Open this file in MATLAB and click Run. Set play_audio=false below for a quiet run.
% The outputs folder stores the two 9.202 WAV files. The 9.201 output arrays
% remain in the echoes cell array in the MATLAB workspace.
% Signal Processing Toolbox is required for fftfilt and resample; no fallback is included.
% Comments appear above their code; only the calculations, playback and output saving remain.
% Describe what you actually hear; the explanations below are theoretical, not listening notes.
% Each part plays its original input and results as soon as that part is complete.

%% 0. Start from a new lab folder
% Use true for playback; change this line to false to compute and save without sound.
play_audio = true;
% Find this script's folder, independently of the original project or MATLAB's current folder.
script_dir = fileparts(mfilename('fullpath'));
% Read audio from the companion folder placed beside this script.
audio_dir = fullfile(script_dir, 'companion', 'data', 'audio');
% Use a timestamp to create this run's output subfolder; this line usually needs no changes.
output_dir = fullfile(script_dir, 'outputs', char(datetime('now', 'Format', 'yyyyMMdd_HHmmss_SSS')));
% Create the output folder and any missing parent folders.
mkdir(output_dir);

%% 1. 9.201(a): read the snare and average its left/right channels to mono
% Read the specified stereo snare recording and its sample rate fs.
[x, fs] = audioread(fullfile(audio_dir, 'Snare2-HitNS_v6_rr1_Sum.wav'));
% Rows are sample times and columns are channels; average the two columns along dimension 2.
x = mean(x, 2);
% Playback gain prevents clipping without changing the stored echoes or their relative levels.
% All cases have N<=10 and alpha<=0.95; use a weight-sum bound to set one safe gain in advance.
gain = 1 / max(1, max(abs(x)) * sum(0.95.^(0:10)));
% Store the 21 outputs of different lengths in a cell array for playback and inspection by part.
echoes = cell(1, 21);
% Keep parameter labels so each sound can be identified during playback.
labels = cell(1, 21);
% Start one continuous case counter for the three groups of experiments.
i = 0;

%% 2. 9.201(a.i): fix N=10 and alpha=0.80, and vary d
% The question specifies only d in [0,1]; these six values are this solution's choice.
% The definition has d>0, but the experiment includes 0; at d=0, copies coincide and only amplitude changes.
% Test each of the six delay values, in seconds.
for d = [0, 0.1, 0.3, 0.5, 0.7, 1]
    % Assign a result number to this case.
    i = i + 1;
    % With N=10 and alpha=0.80 fixed, construct h and compute full convolution for this d.
    echoes{i} = make_echo(x, fs, 10, d, 0.80);
    % Record the part and parameters to display during playback.
    labels{i} = sprintf('9.201(a.i): N=10, d=%.1f, alpha=0.80', d);
    % Finish this case and continue with the next delay.
end
% The actual spacing is floor(fs*d)/fs seconds; larger d separates copies, while smaller d can cause overlap.
% Play this part immediately, before computing the later alpha and N experiments.
if play_audio
    % Play the original snare, followed by this part's six delay results.
    play_echo_group(x, fs, echoes(1:6), labels(1:6), gain);
    % Continue to the next part only after playback finishes.
end

%% 3. 9.201(a.ii): fix N=10 and d=0.5, and vary alpha
% Test all five attenuation factors specified in the question.
for alpha = [0.25, 0.50, 0.75, 0.90, 0.95]
    % Continue numbering cases after the previous group.
    i = i + 1;
    % With N=10 and d=0.5 fixed, compute the output for this alpha.
    echoes{i} = make_echo(x, fs, 10, 0.5, alpha);
    % Record the parameters associated with this sound.
    labels{i} = sprintf('9.201(a.ii): N=10, d=0.5, alpha=%.2f', alpha);
    % Finish this case and continue with the next attenuation factor.
end
% Copy k has weight alpha^k; values closer to 1 make later copies decay more slowly.
% Play this group's results now, with the same gain used for every other group.
if play_audio
    % Play the original snare, followed by this part's five alpha results.
    play_echo_group(x, fs, echoes(7:11), labels(7:11), gain);
    % Start the N experiments only after playback finishes.
end

%% 4. 9.201(a.iii): fix d=0.5 and alpha=0.80, and vary N
% Test every required integer N=1,2,...,10, not just a subset.
for N = 1:10
    % Continue numbering cases after the first two groups.
    i = i + 1;
    % With d=0.5 and alpha=0.80 fixed, compute the output for this N.
    echoes{i} = make_echo(x, fs, N, 0.5, 0.80);
    % Record the parameters associated with this sound.
    labels{i} = sprintf('9.201(a.iii): N=%d, d=0.5, alpha=0.80', N);
    % Finish this case and continue with the next number of delayed copies.
end
% There are N+1 terms: k=0 is the original sound, followed by N progressively weaker delayed copies.
% Increasing N extends the stored output tail, but not every copy is necessarily heard as a distinct echo.
% Play this part now rather than combining its playback with the earlier parts.
if play_audio
    % Play the original snare, followed by this part's ten N results.
    play_echo_group(x, fs, echoes(12:21), labels(12:21), gain);
    % Finish playback for the last group of 9.201.
end

%% 5. 9.201(b): explain the overall behavior using your listening observations
% Each shifted impulse in h produces a delayed input copy, so:
% y(n)=sum_{k=0}^N alpha^k x(n-kD), where D=floor(fs*d).
% The output combines the original sound with delayed, attenuated copies: a simple echo system.
% d controls copy spacing, alpha controls decay, and N controls the number of delayed copies.
% At d=0 all terms coincide and only amplitude changes; describe each case after listening yourself.

%% 6. 9.202: prepare the file paths for the two assigned rooms
% Use the same original singing recording in both experiments.
singing_file = fullfile(audio_dir, 'singing.wav');
% Select the first room's impulse response.
creswell_file = fullfile(audio_dir, 'creswell_crags_ir_3.wav');
% Select the second room's impulse response.
stpauls_file = fullfile(audio_dir, 'st_pauls_cathedral_ir_1.wav');
% Set the output path for part (b.i).
creswell_output = fullfile(output_dir, '9_202_b_i_creswell.wav');
% Use a different path for part (b.ii); Assignment 3B also requires this WAV to be submitted.
stpauls_output = fullfile(output_dir, '9_202_b_ii_st_pauls.wav');

%% 7. 9.202(b.i): process the first room, then compare the original and result
% Process the singing with the first response; the function computes, normalizes and saves it.
conv_reverb(singing_file, creswell_file, creswell_output);
% Play the first room as soon as it is complete, before processing the second room.
if play_audio
    % Read the original singing and its own sample rate.
    [original, fs_original] = audioread(singing_file);
    % Identify the original singing as the next sound.
    disp('9.202: original singing.');
    % Play at the correct sample rate and wait for completion.
    playblocking(audioplayer(original, fs_original));
    % Read the saved first-room output and its sample rate.
    [creswell, fs_creswell] = audioread(creswell_output);
    % Identify part (b.i) as the next sound.
    disp('9.202(b.i): Creswell Crags.');
    % Play the complete first-room output, including the reverberation tail after the input stops.
    playblocking(audioplayer(creswell, fs_creswell));
    % Continue to the next part after listening to (b.i).
end

%% 8. 9.202(b.ii): process the second room, then compare the original and result
% Process the same singing with the second room to complete the other assigned experiment.
conv_reverb(singing_file, stpauls_file, stpauls_output);
% Play this part's original and result immediately after the second-room output is saved.
if play_audio
    % Read the original singing again as the listening reference for the second room.
    [original, fs_original] = audioread(singing_file);
    % Identify the original singing as the reference played first.
    disp('9.202: original singing.');
    % Play the complete original and wait before starting the second-room output.
    playblocking(audioplayer(original, fs_original));
    % Read the saved second-room output and its sample rate.
    [stpauls, fs_stpauls] = audioread(stpauls_output);
    % Identify part (b.ii) as the next sound.
    disp('9.202(b.ii): St. Paul''s Cathedral.');
    % Play the complete second-room output and wait for completion.
    playblocking(audioplayer(stpauls, fs_stpauls));
    % Finish the listening portion of 9.202.
end
% Describe the tail, reflections, clarity and timbre you actually hear; do not invent conclusions.
% Each result is normalized separately, so absolute playback levels cannot compare the rooms' true gains.
% Display the output folder so you can find both results, including the required (b.ii) WAV.
disp(output_dir);

%% 9.201: construct the specified impulse response and solve one parameter case
% Return the full output y from the input, rate and N/d/alpha, without applying the playback gain.
function y = make_echo(x, fs, N, d, alpha)
    % Convert seconds to samples and round down as specified to obtain integer spacing D.
    D = floor(fs * d);
    % Indices 0 through ND require ND+1 samples; start with a zero column vector.
    h = zeros(N * D + 1, 1);
    % Include the original at k=0 and delayed copies at k=1,...,N: N+1 terms in total.
    for k = 0:N
        % Sequence index kD maps to MATLAB position kD+1 because arrays start at 1.
        position = k * D + 1;
        % Add weight alpha^k; at d=0 impulses coincide, so add rather than overwrite.
        h(position) = h(position) + alpha^k;
        % Finish this impulse's contribution and continue to the next term.
    end
    % Append length(h)-1 zeros and use fftfilt for full convolution, retaining the entire tail.
    y = fftfilt(h, [x; zeros(numel(h) - 1, 1)]);
    % Return y, whose length is length(x)+N*D.
end

%% Play the current part: original snare first, followed by this group's results
% Receive the current group's outputs and labels; all groups use the same safe gain.
function play_echo_group(x, fs, echoes, labels, gain)
    % Identify the original sound as the reference for the current part.
    disp('9.201: original mono snare, at the same comparison gain.');
    % Play the original snare and wait, preventing overlap with the processed sounds.
    playblocking(audioplayer(gain * x, fs));
    % Iterate only over the current part's supplied results, not the other parts.
    for j = 1:numel(echoes)
        % Display the part and parameters associated with this sound.
        disp(labels{j});
        % Keep the common gain, correct rate and full tail; wait until this result finishes.
        playblocking(audioplayer(gain * echoes{j}, fs));
        % Continue with the next parameter result in this part.
    end
    % Return to the main script after all sounds in the current part finish.
end

%% 9.202(a): read, prepare channels, resample, convolve, normalize and save
% The three arguments are the input sound, room response and output file paths.
function conv_reverb(in_file, ir_file, out_file)
    % Read the original sound and its rate; the exercise permits assuming a mono input.
    [x, fs_x] = audioread(in_file);
    % Read the room impulse response and its own sample rate.
    [h, fs_h] = audioread(ir_file);
    % Extract the response filename to identify this course file's particular format.
    [~, ir_name] = fileparts(ir_file);
    % This Creswell file is four-channel B-format; its companion README specifies channel 1 for mono.
    if strcmp(ir_name, 'creswell_crags_ir_3')
        % Select all sample times from column 1; this is not a general rule for four-channel audio.
        h = h(:, 1);
        % Average left/right channels for an ordinary stereo response as permitted by the question.
    elseif size(h, 2) == 2
        % Average along dimension 2, leaving one mono sample at every time.
        h = mean(h, 2);
        % Leave an already-mono response unchanged and finish channel preparation.
    end
    % Choose the higher of the two rates as the common sample rate.
    fs = max(fs_x, fs_h);
    % Resample the original sound if its rate is lower.
    if fs_x < fs
        % Compute new samples at ratio fs/fs_x; do not merely change playback speed.
        x = resample(x, fs, fs_x);
        % Resample the room response instead if its rate is lower.
    elseif fs_h < fs
        % Resample at ratio fs/fs_h to put both signals on the same time grid.
        h = resample(h, fs, fs_h);
        % Leave both signals unchanged if the rates already match.
    end
    % Arrange input samples as a column vector.
    x = x(:);
    % Arrange response samples as a column vector too.
    h = h(:);
    % Append length(h)-1 zeros so fftfilt retains the full convolution tail.
    y = fftfilt(h, [x; zeros(numel(h) - 1, 1)]);
    % Find the largest sample magnitude, including peaks on the negative side.
    peak = max(abs(y));
    % Normalize a nonzero output; leave a zero output unchanged to avoid division by zero.
    if peak > 0
        % Divide all samples by the same number to give maximum magnitude 1.
        y = y / peak;
        % Finish peak normalization.
    end
    % Write at the common rate, completing the requested file-to-file processing.
    audiowrite(out_file, y, fs);
    % Finish the function; the result has been written to out_file.
end
