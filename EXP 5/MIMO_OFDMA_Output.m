clc;
clear;
close all;

%% ==========================================================
% Create Output Folder
%% ==========================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,'MIMO_OFDMA_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% OBJECTIVE 1 : MIMO BER Performance
% ==========================================================

% SNR Range
SNR_dB = 0:2:20;
SNR = 10.^(SNR_dB/10);

% MIMO Parameters
Nt = 2;
Nr = 2;

BER = zeros(1,length(SNR));

% Number of bits
numBits = 10000;

for i = 1:length(SNR)

    % Generate random bits
    bits = randi([0 1],numBits,1);

    % BPSK Modulation
    symbols = 2*bits - 1;

    % MIMO Channel
    H = (randn(Nr,Nt) + 1j*randn(Nr,Nt))/sqrt(2);

    % Noise
    noise = (randn(Nr,numBits) + ...
             1j*randn(Nr,numBits))/sqrt(2*SNR(i));

    % Received signal
    % Using the first transmit and first receive path
    tx = H(1,1)*symbols' + noise(1,:);

    % BPSK Detection
    rx = real(tx) > 0;

    % BER Calculation
    BER(i) = sum(rx' ~= bits)/length(bits);

end

%% ==========================================================
% MIMO BER and Reliability Graph
% ==========================================================

fig1 = figure;

subplot(2,1,1)

semilogy(SNR_dB,BER,'-o','LineWidth',2)

title('MIMO BER Performance vs SNR')
xlabel('SNR (dB)')
ylabel('Bit Error Rate (BER)')
grid on

subplot(2,1,2)

plot(SNR_dB,1-BER,'-s','LineWidth',2)

title('MIMO System Reliability vs SNR')
xlabel('SNR (dB)')
ylabel('Reliability (1 - BER)')
grid on

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_MIMO_BER_Reliability.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : MIMO Reliability and Noise
% ==========================================================

Reliability = zeros(1,length(SNR));
noisePower = zeros(1,length(SNR));

for i = 1:length(SNR)

    % Channel model
    H = (randn(Nr,Nt) + ...
         1j*randn(Nr,Nt))/sqrt(2);

    % Noise power
    noisePower(i) = 1/SNR(i);

    % Reliability model
    Reliability(i) = 1 - exp(-SNR(i)/10);

end

%% ==========================================================
% Reliability and Noise Graph
% ==========================================================

fig2 = figure;

subplot(2,1,1)

plot(SNR_dB,Reliability,'-o','LineWidth',2)

title('MIMO Reliability vs SNR')
xlabel('SNR (dB)')
ylabel('Reliability (0 to 1)')
grid on

subplot(2,1,2)

plot(SNR_dB,noisePower,'-s','LineWidth',2)

title('Noise Power Variation with SNR')
xlabel('SNR (dB)')
ylabel('Noise Power')
grid on

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_MIMO_Reliability_Noise.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : OFDMA User Throughput
% ==========================================================

% Resource Block Parameters
rb_bw = 180e3;          % 180 kHz per RB

% Users
users = 1:5;

% Allocated Resource Blocks
alloc_RB = [10 12 8 15 5];

% Modulation Efficiency
% 2 = QPSK
% 4 = 16-QAM
% 6 = 64-QAM
mod_eff = [2 4 6 4 2];

% Throughput Calculation
throughput = ...
    (alloc_RB .* rb_bw .* mod_eff)/1e6;

%% ==========================================================
% Display OFDMA Results
% ==========================================================

disp(' ');
disp('==============================================');
disp('OFDMA USER THROUGHPUT');
disp('==============================================');

Result = table(users',...
               alloc_RB',...
               mod_eff',...
               throughput',...
    'VariableNames',{'User','Allocated_RB',...
                     'Modulation_Efficiency',...
                     'Throughput_Mbps'});

disp(Result);

%% ==========================================================
% OFDMA Throughput Graph
% ==========================================================

fig3 = figure;

subplot(2,1,1)

plot(users,throughput,'-o','LineWidth',2)

title('OFDMA User Throughput')
xlabel('User Index')
ylabel('Throughput (Mbps)')
grid on

subplot(2,1,2)

plot(alloc_RB,throughput,'-s','LineWidth',2)

title('Resource Blocks vs Throughput')
xlabel('Allocated Resource Blocks')
ylabel('Throughput (Mbps)')
grid on

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_OFDMA_Throughput.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
% ==========================================================

disp(' ');
disp('==============================================');
disp('ALL OBJECTIVES EXECUTED SUCCESSFULLY');
disp('==============================================');

disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');
disp('1. Objective1_MIMO_BER_Reliability.png');
disp('2. Objective2_MIMO_Reliability_Noise.png');
disp('3. Objective3_OFDMA_Throughput.png');