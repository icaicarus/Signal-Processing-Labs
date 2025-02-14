% Read in the signal from the audio file
[signal, Fs] = audioread("tones.wav"); 
L = length(signal);
T = 1/Fs;
t = [0:L-1]*T;
% Plot the signal for t_plot msec
t_plot = 5;
msec_per_sec = 1000;
numSamples = t_plot*Fs/msec_per_sec;
plot(msec_per_sec*t(1:numSamples), signal(1:numSamples))
title('Plot of Input Signal')
xlabel('time (milliseconds)')
grid('minor');
exportgraphics(gcf, 'l4_g1.jpg');

[signal, Fs] = audioread("tones.wav"); 
L = length(signal);

% Raw Signal
fftSignal = abs(fft(signal)); % Compute FFT
f = (0:L-1) * (Fs/L); % Frequency vector (unshifted)

% Plotting
stem(f, fftSignal);
title('DTF of the Audio Signal');
xlabel('Frequency (Hz)');
ylabel('|FFT|');
text(2000, 20000,'Marryam Kamal - 400446997', 'FontSize', 10)
exportgraphics(gcf, 'tones_magnitude.jpg');

% Shifted Signal
fftShifted = abs(fftshift(fft(signal))); % Center FFT around zero
fShifted = (-L/2:L/2-1) * (Fs/L); % Frequency vector (shifted)

% Plotting
stem(fShifted, fftShifted);
title('DTF of the Audio Signal (Shifted)');
xlabel('Frequency (Hz)');
ylabel('|FFT|');
text(-8000, 20000,'Marryam Kamal - 400446997', 'FontSize', 10)
exportgraphics(gcf, 'tones_magnitude_shifted.jpg');

% Take the DFT
Y = fft(signal)/L;
f = Fs/2*linspace(0,1,L/2+1);
% Plot the single-sided magnitude spectrum.
plot(f,2*abs(Y(1:L/2+1)));
title('Single-Sided Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
axis([0 Fs/2 0 .5]);
grid('minor');
exportgraphics(gcf, 'single_sided.jpg');

% Define parameters from previous part
[signal, Fs] = audioread("tones.wav"); 
frequencies = [1000, 4000, 6000];
magnitudes = [0.4, 0.2, 0.2]; 

% Time vector for 5 msec
L = length(signal);
T = 1/Fs;
t = [0:L-1]*T;
t_plot = 5;
msec_per_sec = 1000;
numSamples = t_plot*Fs/msec_per_sec;

% Generate the signal
new_signal = zeros(size(t));
for i = 1:length(frequencies)
    new_signal = new_signal + magnitudes(i)*sin(2*pi*frequencies(i)*t);
end

plot(msec_per_sec*t(1:numSamples), new_signal(1:numSamples));
title('Reconstructed Signal');
xlabel('Time (ms)');
ylabel('Amplitude');
grid('minor');
text(0.1, -0.3,'Marryam Kamal - 400446997', 'FontSize', 8);
exportgraphics(gcf, 'recreated_signal.jpg');

function plot_fourier_for_second(audio_file, n)
    % Read the audio file
    [signal, Fs] = audioread(audio_file);


    % Calculate the starting and ending sample indices for the given second
    start_sample = (n - 1) * Fs + 1;
    end_sample = n * Fs;

    if end_sample > length(signal)
        signal_second = signal(start_sample:end);
    else
        signal_second = signal(start_sample:end_sample);
    end

    % Get the length of the truncated signal
    L = length(signal_second);

    % Take the DFT of the specified second
    Y = fft(signal_second) / L;

    % Create the frequency axis for the plot
    f = Fs / 2 * linspace(0, 1, L / 2 + 1);

    % Plot the single-sided magnitude spectrum
    figure;
    plot(f, 2 * abs(Y(1:L / 2 + 1)));
    title('Fourier Transform');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    axis([0 Fs/2 0 .5]);
    grid('minor');
end

plot_fourier_for_second('SecretMessage.wav', 4);
exportgraphics(gcf, '4.jpg');

% Take the DFT
[signal, Fs] = audioread("SecretMessage.wav");
L = length(signal);
Y = fft(signal)/L;
f = Fs/2*linspace(0,1,L/2+1);

% Plot the single-sided magnitude spectrum.
plot(f,2*abs(Y(1:L/2+1)));
title('Single-Sided Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
axis([0 Fs/2 0 .5]);
grid('minor');
exportgraphics(gcf, 'secret_message.jpg');

function peaks_cell = get_peak_frequencies(audio_file)
    % Read the audio file
    [signal, Fs] = audioread(audio_file);
    
    peaks_cell = {};
    N = floor(length(signal)/Fs);
    
    % Loop over each second of the audio
    for n = 1:N
        % Break the signal into the corresponding second
        start_sample = (n - 1)*Fs + 1;
        end_sample = n * Fs;
        signal_second = signal(start_sample:end_sample);
        L = length(signal_second);
        
        % Take the DFT
        Y = fft(signal_second)/L;
        f = Fs/2*linspace(0, 1, L/2 + 1);
        magnitude = 2*abs(Y(1:L/2 + 1));
        
        % Find the peaks in the magnitude spectrum
        [peaks, locs] = findpeaks(magnitude);
        valid_locs = locs(peaks > 0.01); % Only keep peaks with magnitude > 0.01
        peaks_cell{n} = f(valid_locs); % Store the frequencies of the valid peaks
    end
    
    % Display the peak frequencies for each second
    for n = 1:N
        fprintf('Second %d: ', n);
        fprintf('%.f Hz ', peaks_cell{n});
        fprintf('\n');
    end
end

peak_frequencies = get_peak_frequencies('SecretMessage.wav');
