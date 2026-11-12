%% 11.204(b): Main script — fill the six TODO groups below before clicking Run
% In a new lab folder, place the full companion folder next to this file.
% The response helper and playback resampling require Signal Processing Toolbox.

% Locate the course files relative to this script, not MATLAB's current folder.
script_dir = fileparts(mfilename('fullpath'));
% Prefer a companion folder next to the script (for example, in a new lab folder).
companion_dir = fullfile(script_dir, 'companion');
% In the project's fill-in subfolder, companion is one directory up.
if ~isfolder(companion_dir)
    companion_dir = fullfile(fileparts(script_dir), 'companion');
end
% If neither layout is present, explain where to put the companion folder.
assert(isfolder(companion_dir), 'Place the complete companion folder next to this script.');
% Add only the textbook helper folder; the assignment function is local to this file.
addpath(fullfile(companion_dir, 'textbook', 'exercises'));
% Locate the supplied noisy speech WAV.
input_file = fullfile(companion_dir, 'data', 'audio', 'speech_with_powerline_noise.wav');
% Use a fresh output folder so the input and earlier outputs stay unchanged.
output_dir = tempname;
mkdir(output_dir);
output_file = fullfile(output_dir, 'speech_denoised.wav');
% Call the local function below: remove the first 20 harmonics of 60 Hz.
audio_file_remove_harmonic_noise(input_file, output_file, 60, 20);
% Print the location of the saved WAV in the Command Window.
fprintf('Denoised WAV: %s\n', output_file);

%% Prepare the listening comparison — no automatic playback
% Read the input and saved output WAVs. Playback preparation changes neither file.
[x_listen, fs] = audioread(input_file);
y_listen = audioread(output_file);
% Resample to 48 kHz for playback compatibility without changing pitch or duration.
playback_fs = 48000;
[p, q] = rat(playback_fs / fs);
x_listen = resample(x_listen(:, 1), p, q);
y_listen = resample(y_listen, p, q);
% Use the same playback gain for both clips and reduce it only to avoid clipping.
playback_gain = max(1, max(abs([x_listen; y_listen])));
% In the Command Window, run the next two lines one at a time: noisy, then denoised.
% playblocking(audioplayer(x_listen / playback_gain, playback_fs));
% playblocking(audioplayer(y_listen / playback_gain, playback_fs));

%% 11.204(a): Local function — fill only the marked blanks
function audio_file_remove_harmonic_noise(input_file, output_file, ...
    base_freq, num_harmonics)
% Read the input WAV, remove power-line harmonics, write a WAV and plot three comparisons.
% Use different input and output paths; the main script creates a fresh output folder.
% Classroom fill-in: enter code on the blank lines under the hints. Fill all six TODO groups before running.

% Read the WAV samples and sample rate. Each column is an audio channel.
[x, fs] = audioread(input_file);
% Keep the first column: the only channel for mono, or the left channel for stereo.
x = x(:, 1);
% Fs/2 is the highest distinct nonnegative frequency.
nyquist = fs / 2;
% TODO 1/6: Build the harmonic list and normalize it to Nyquist.
% List the first K requested harmonics in Hz, starting at the fundamental.

% Pass only frequencies strictly below Nyquist to the design helper. Ignore any above it.

% The exercise specifies this pole radius, which controls the notch width.
r = 0.999;
% Start with an empty second-order section (SOS) matrix: three numerator and three denominator coefficients per row.
sos = zeros(0, 6);
% The helper requires a nonempty vector of normalized frequencies strictly between 0 and 1.
if ~isempty(notch_freqs)
    % TODO 2/6: Design the notch sections.
    % Design one second-order section for each harmonic passed to the helper.

    % Prevent a missing line here from silently turning the demo into a unity-gain pass-through.
    assert(~isempty(sos), 'Complete TODO 2/6: design the notch sections.');
% End the design for frequencies strictly below Nyquist.
end
% The exercise discards only frequencies above Nyquist. Handle equality in a separate section.
if any(harmonics == nyquist)
    % At a center of pi, cos(pi)=-1. Substitute it into the helper's coefficient formula.
    sos(end + 1, :) = [1, 2, 1, 1, 2*r, r^2];
% End the Nyquist edge case, which the supplied recording does not trigger.
end
% If there are no valid targets, represent no filtering by a unity-gain section.
if isempty(sos)
    % Identical numerator and denominator give an unchanged output and a response of 1.
    sos = [1, 0, 0, 1, 0, 0];
% End the no-valid-target case.
end
% TODO 3/6: Apply the cascade to the input.
% Filter in row order. Each section's output becomes the next section's input.

% Scale the whole signal only if it is outside the WAV write range to avoid clipping individual samples.
peak = max(abs(y));
% Otherwise keep the original filtered amplitude.
if peak > 1
    % Use the same scale factor for every sample.
    y = y / peak;
% End WAV clipping protection.
end
% TODO 4/6: Write the denoised WAV.
% Write the mono output at the original sample rate.


% Use the same FFT length for both signals. Zero-padding makes the display grid denser.
n_fft = 2^nextpow2(numel(x));
% Mathematical FFT bins start at 0; MATLAB array indices start at 1.
k = (0:floor(n_fft/2)).';
% Convert the nonnegative FFT bin indices to frequencies in Hz.
f_signal = k * fs / n_fft;
% TODO 5/6: Compute both FFTs with matching length and scaling.
% Compute the input FFT, using the original sample count as the shared amplitude scale.

% Apply the same FFT length and amplitude scale to the output.

% Keep the nonnegative-frequency part of the input spectrum.
X = X(k + 1);
% Keep the same frequency bins for the output.
Y = Y(k + 1);
% TODO 6/6: Compute the frequency response of the cascade.
% Use a dense grid to show narrow notches, including the one at 60 Hz.

% The helper's regular grid omits Nyquist; evaluate the response at z^(-1)=-1.
h_nyquist = prod((sos(:, 1) - sos(:, 2) + sos(:, 3)) ./ ...
    (sos(:, 4) - sos(:, 5) + sos(:, 6)));
% Append Nyquist to the filter frequency axis.
f_filter = [f_filter; nyquist];
% Append the matching complex response value.
H = [H; h_nyquist];
% Convert magnitude to dB. The -160 dB display floor does not change the audio.
to_db = @(z) 20 * log10(max(abs(z), 1e-8));
% Use the required upper limit: 1.5 * 20 * 60 = 1800 Hz for the demo.
f_max = 1.5 * num_harmonics * base_freq;
% Put all three plots in one figure.
figure('Name', '11.204: Power-line interference');
% Panel 1: nonnegative-frequency magnitude spectrum of the input.
ax(1) = subplot(3, 1, 1);
% Plot the input spectrum on a hertz axis.
plot(f_signal, to_db(X));
% Label the noisy input panel.
title('Noisy input spectrum');
% Show magnitude in decibels.
ylabel('Magnitude (dB)');
% Panel 2: magnitude response of the entire cascade.
ax(2) = subplot(3, 1, 2);
% This is filter gain, not a signal spectrum.
plot(f_filter, to_db(H));
% Label the cascade response panel.
title('Cascade frequency response');
% Show gain in decibels.
ylabel('Gain (dB)');
% Panel 3: nonnegative-frequency magnitude spectrum of the output.
ax(3) = subplot(3, 1, 3);
% Use the same frequency bins and amplitude scale as in the input plot.
plot(f_signal, to_db(Y));
% Label the denoised output panel.
title('Denoised output spectrum');
% Give the two signal spectra the same vertical range for comparison.
yl = [min([ylim(ax(1)), ylim(ax(3))]), max([ylim(ax(1)), ylim(ax(3))])];
% Set the shared range on the input panel.
ylim(ax(1), yl);
% Set the shared range on the output panel.
ylim(ax(3), yl);
% Show output magnitude in decibels.
ylabel('Magnitude (dB)');
% All three panels use hertz on the horizontal axis.
xlabel('Frequency (Hz)');
% Link horizontal limits and zoom across the panels.
linkaxes(ax, 'x');
% Set the common range to 0 through F; no data are plotted above Nyquist.
xlim(ax(1), [0, f_max]);
% End the 11.204(a) function.
end
