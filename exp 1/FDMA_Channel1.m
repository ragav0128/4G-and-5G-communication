clc;
clear;
close all;

%% ============================================================
% Create Output Folder
% ============================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,'FDMA_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ============================================================
% OBJECTIVE 1: FDMA Channel Allocation
% ============================================================

fs = 1000;
t = 0:1/fs:1;

TBW = 600;          % Total Bandwidth (kHz)
numUsers = 3;

CBW = TBW/numUsers;
fc = [100 300 500];

m = sin(2*pi*10*t);

s1 = m.*cos(2*pi*fc(1)*t);
s2 = m.*cos(2*pi*fc(2)*t);
s3 = m.*cos(2*pi*fc(3)*t);

fig1 = figure;

subplot(2,1,1)
plot(t,s1,'r',t,s2,'g',t,s3,'b','LineWidth',1.2);
grid on;
title('FDMA Channel Allocation');
xlabel('Time (s)');
ylabel('Amplitude');
legend('User 1','User 2','User 3');

subplot(2,1,2)
bar(1:numUsers,CBW*ones(1,numUsers));
grid on;
xlabel('Users');
ylabel('Channel Bandwidth (kHz)');
title('Channel Bandwidth per User');

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_FDMA_Channel_Allocation.png'),...
    'Resolution',300);

%% ============================================================
% OBJECTIVE 2: FDMA Data Rate
% ============================================================

BW = 200;
M = 2;

DataRate = BW*log2(M);
Rate = DataRate*ones(numUsers,1);

disp(' ');
disp('OBJECTIVE 2 - DATA RATE');
disp('User    Data Rate (kbps)');
disp([(1:numUsers)' Rate]);

fig2 = figure;

bar(1:numUsers,Rate);
grid on;
xlabel('Users');
ylabel('Data Rate (kbps)');
title('FDMA Data Rate for Each User');

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_FDMA_Data_Rate.png'),...
    'Resolution',300);

%% ============================================================
% OBJECTIVE 3: FDMA Signal-to-Noise Ratio
% ============================================================

Ps = 1;
Pn = [0.1;0.05;0.01];

User = (1:numUsers)';
SNR = 10*log10(Ps./Pn);

disp(' ');
disp('OBJECTIVE 3 - SIGNAL TO NOISE RATIO');
disp('User    Noise Power(W)    SNR(dB)');
disp([User Pn SNR]);

fig3 = figure;

bar(User,SNR);
grid on;
xlabel('Users');
ylabel('SNR (dB)');
title('Signal-to-Noise Ratio of FDMA Users');

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_FDMA_SNR.png'),...
    'Resolution',300);

%% ============================================================
% Completion Message
% ============================================================

disp(' ');
disp('All three objectives executed successfully.');
disp(['Images saved in: ', outputFolder]);

disp('Saved Files:');
disp(fullfile(outputFolder,'Objective1_FDMA_Channel_Allocation.png'));
disp(fullfile(outputFolder,'Objective2_FDMA_Data_Rate.png'));
disp(fullfile(outputFolder,'Objective3_FDMA_SNR.png'));