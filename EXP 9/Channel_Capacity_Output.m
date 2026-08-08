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

outputFolder = fullfile(scriptPath,'Channel_Capacity_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% OBJECTIVE 1 : Channel Capacity vs SNR
%% ==========================================================

snr = 0:5:30;

snr_linear = 10.^(snr/10);

capacity = log2(1 + snr_linear);

fig1 = figure;

plot(snr,capacity,'-o',...
    'LineWidth',2,...
    'MarkerSize',6);

grid on;

xlabel('SNR (dB)');
ylabel('Channel Capacity (bps/Hz)');
title('Channel Capacity vs SNR');

exportgraphics(fig1,...
    fullfile(outputFolder,...
    'Objective1_Channel_Capacity_vs_SNR.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : Channel Capacity vs SNR
% ==========================================================
% This is kept as a separate objective because you provided
% it as a separate program.

snr2 = 0:5:30;

snr_linear2 = 10.^(snr2/10);

capacity2 = log2(1 + snr_linear2);

fig2 = figure;

plot(snr2,capacity2,'-o',...
    'LineWidth',2,...
    'MarkerSize',6);

grid on;

xlabel('SNR (dB)');
ylabel('Channel Capacity (bps/Hz)');
title('Channel Capacity vs SNR');

exportgraphics(fig2,...
    fullfile(outputFolder,...
    'Objective2_Channel_Capacity_vs_SNR.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : Antenna Gain for Different Array Sizes
%% ==========================================================

antennas = [4 8 16 32 64];

gain = 10*log10(antennas);

fig3 = figure;

bar(antennas,gain);

grid on;

xlabel('Number of Antenna Elements');
ylabel('Antenna Gain (dB)');
title('Antenna Gain for Different Antenna Array Sizes');

exportgraphics(fig3,...
    fullfile(outputFolder,...
    'Objective3_Antenna_Gain.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp(' ');
disp('==============================================');
disp('ALL THREE OBJECTIVES COMPLETED');
disp('==============================================');

disp(' ');

disp('OBJECTIVE 1 - Channel Capacity vs SNR');
disp(table(snr',capacity',...
    'VariableNames',{'SNR_dB','Capacity_bps_Hz'}));

disp('OBJECTIVE 2 - Channel Capacity vs SNR');
disp(table(snr2',capacity2',...
    'VariableNames',{'SNR_dB','Capacity_bps_Hz'}));

disp('OBJECTIVE 3 - Antenna Gain');
disp(table(antennas',gain',...
    'VariableNames',{'Antenna_Elements','Gain_dB'}));

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All three objectives executed successfully.');

disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');

disp('1. Objective1_Channel_Capacity_vs_SNR.png');
disp('2. Objective2_Channel_Capacity_vs_SNR.png');
disp('3. Objective3_Antenna_Gain.png');