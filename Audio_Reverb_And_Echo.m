f = SimpleFunctions();

% Question 2.7A
n = -10:1:10;
x = f.unitstep(n) - f.unitstep(n-3);
v = f.unitstep(n) - f.unitstep(n-4);
y = conv(x, v, "same");
subplot(3,1,1); stem(n,x);
xlabel('n'); ylabel('x');
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,2); stem(n,v);
xlabel('n'); ylabel('v'); 
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,3); stem(n,y);
xlabel('n'); ylabel('y');
text(-9, 2,'Marryam Kamal - 400446997', 'FontSize', 10)

% Question 2.7B
n = -10:1:10;
x = 2*f.delta(n) + f.delta(n-1);
v = f.unitstep(n) - f.unitstep(n-4);
y = conv(x, v, "same");
subplot(3,1,1); stem(n,x);
xlabel('n'); ylabel('x');
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,2); stem(n,v);
xlabel('n'); ylabel('v'); 
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,3); stem(n,y);
xlabel('n'); ylabel('y');
text(-9, 2,'Marryam Kamal - 400446997', 'FontSize', 10)

% Question 2.7C
n = -10:1:10;
x = 2*f.delta(n) + f.delta(n-1);
v = f.delta(n-1) + 2*f.delta(n-2);
y = conv(x, v, "same");
subplot(3,1,1); stem(n,x);
xlabel('n'); ylabel('x');
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,2); stem(n,v);
xlabel('n'); ylabel('v'); 
text(-9, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
subplot(3,1,3); stem(n,y);
xlabel('n'); ylabel('y');
text(-9, 2,'Marryam Kamal - 400446997', 'FontSize', 10)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Audio importing
[signal, Fs] = audioread('my_speech_clip.wav');
L = length(signal);     
T = 1/Fs;               
t = [0:L-1]*T; 

% Signal echo
a = 0.5;                                % Echo amplitude
Te = 200;                               % Echo delay in msec
Te_samples = round((Te/1000) * Fs);     % Convert echo delay to samples

signal(Te_samples+1:end) = signal(Te_samples+1:end) + a*signal(1:end-Te_samples);
signal = signal / max(abs(signal));

% New audio file
audiowrite('speechwithecho.wav', signal, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Signal echo with convolution
a = 0.5;                                % Echo amplitude
Te = 200;                               % Echo delay in msec
Te_samples = round((Te/1000) * Fs);     % Convert echo delay to samples

IR = zeros(1, Te_samples + 1); 
IR(1) = 1;                      % Delta function at t = 0
IR(Te_samples + 1) = a;

signal = conv(signal, IR, 'full');  % Convolve the signal with IR

signal = signal / max(abs(signal));

% New audio file
audiowrite('echo_convolution1.wav', signal, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Signal Reverberation
a = 0.5;                                % Echo amplitude
Te = 200;                               % Echo delay in msec
Te_samples = round((Te/1000) * Fs);     % Convert echo delay to samples
Ne = 5;                             

IR = zeros(1, Ne*Te_samples + 1);       % Create IR vector
for i = 0:Ne-1
    IR(round(i*Te_samples) + 1) = a^i; 
end

signal = conv(signal, IR, 'same'); % Convolve
signal = signal / max(abs(signal));

% New audio file
audiowrite('speechwithreverb.wav', signal, Fs);