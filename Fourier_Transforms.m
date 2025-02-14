% f = SimpleFunctions();
% n = -5:5;
% 
% % Do a plot of a sampled sinusoid with frequency f = 100 Hz
% f = 100;
% 
% % Sampling frequency and interval
% fs = 8000;
% Ts = 1/fs;
% 
% % Set time duration of plot, i.e., 10 msec.
% tfinalplot = 10e-3;
% 
% % Make the time vector for the plot
% nplot=0:Ts:tfinalplot;
% 
% % Sample the sinusoid.
% xnT = sin(2*pi*f*nplot);
% 
% % Make the plot
% stem(nplot, xnT);
% text(1, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
% % Uncomment/edit this next line to save the graph.
% exportgraphics(gcf, 'q1_graph.jpg');


% function q2(f,x)
%     fs = 8000;
%     Ts = 1/fs;
%     tfinalplot = 10e-3;
%     nplot=0:Ts:tfinalplot;
%     tfinal = 2;
%     nsound=0:Ts:tfinal;
%     xnT = sin(2*pi*f*nsound);
%     subplot(4,1,x); stem(nplot, xnT(1:length(nplot)));
% end
% 
% % Making the subplots
% q2(7200,1);
% xlabel('n at 7200 Hz'); ylabel('x');
% q2(7600,2);
% xlabel('n at 7600 Hz'); ylabel('x');
% q2(7800,3);
% xlabel('n at 7800 Hz'); ylabel('x');
% q2(7900,4);
% xlabel('n at 7900 Hz'); ylabel('x');
% text(0.006, -0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
%
% % % Uncomment/edit this next line to save the graph.
% exportgraphics(gcf, 'q3.jpg');

% %Initialize the concatenated vector
% xnT_combined = [];
% tfinal = 2;
% frequencies = [7200,7600,7800,7900];
% fs = 8000;
% Ts = 1/fs;
% nsound=0:Ts:tfinal;
% 
% for i = 1:length(frequencies)
%     % Generate the sinusoidal tone
%     f = frequencies(i);
%     xnT = sin(2*pi*f*nsound);
%     xnT_combined = [xnT_combined, xnT];
% end
% 
% audiowrite('concatenated_sound_q3.wav', xnT_combined, fs);

f = 100;
fs = 16000;
Ts = 1/fs;
tfinalplot = 8;

nplot=0:Ts:tfinalplot;
xnT = cos(pi*2000*nplot.^2 + 2*pi*f*nplot);

% Make the plot
subplot(2,1,1);plot(nplot(1:2000), xnT(1:2000));
xlabel('n at 16 kHz'); ylabel('x');
text(0.005, 0.5,'Marryam Kamal - 400446997', 'FontSize', 10)
exportgraphics(gcf, 'q5_a.jpg');
audiowrite('q5_a.wav', xnT, fs);

f = 100;
fs = 40000;
Ts = 1/fs;
tfinalplot = 8;

nplot=0:Ts:tfinalplot;
xnT = cos(pi*2000*nplot.^2 + 2*pi*f*nplot);

% Make the plot
subplot(2,1,2);plot(nplot(1:2000), xnT(1:2000));
xlabel('n at 8 kHz'); ylabel('x');
exportgraphics(gcf, 'q5_b.jpg');
audiowrite('q5_b.wav', xnT, fs);