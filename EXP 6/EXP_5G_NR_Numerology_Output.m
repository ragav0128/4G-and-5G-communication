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

outputFolder = fullfile(scriptPath,'5G_NR_Numerology_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Common Parameters
%% ==========================================================

scs = [15 30 60 120 240];     % Subcarrier Spacing (kHz)
mu = 0:4;                      % Numerology Index

%% ==========================================================
% OBJECTIVE 1 : Subcarrier Spacing vs Numerology
%% ==========================================================

fig1 = figure;

bar(scs)

grid on

set(gca,'XTick',1:5)
set(gca,'XTickLabel',mu)

xlabel('Numerology Index (\mu)')
ylabel('Subcarrier Spacing (kHz)')
title('5G NR Subcarrier Spacing for Different Numerologies')

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_Subcarrier_Spacing.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : Slot Duration
%% ==========================================================

slot = [1 0.5 0.25 0.125 0.0625];   % Slot Duration (ms)

fig2 = figure;

plot(scs,slot,'o-','LineWidth',2)

grid on

xlabel('Subcarrier Spacing (kHz)')
ylabel('Slot Duration (ms)')
title('5G NR Slot Duration for Different Subcarrier Spacing')

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_Slot_Duration.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : OFDM Symbols per Slot
%% ==========================================================

symbols = [14 14 14 14 14];

fig3 = figure;

bar(scs,symbols)

grid on

xlabel('Subcarrier Spacing (kHz)')
ylabel('Number of OFDM Symbols')
title('OFDM Symbols per Slot for Different Subcarrier Spacing')

ylim([0 16])

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_OFDM_Symbols.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp(' ');
disp('==============================================');
disp('5G NR NUMEROLOGY RESULTS');
disp('==============================================');

Result = table(mu',scs',slot',symbols',...
    'VariableNames',{'Numerology','SCS_kHz',...
                     'SlotDuration_ms','OFDMSymbols'});

disp(Result);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All objectives executed successfully.');
disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');
disp('1. Objective1_Subcarrier_Spacing.png');
disp('2. Objective2_Slot_Duration.png');
disp('3. Objective3_OFDM_Symbols.png');