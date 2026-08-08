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

outputFolder = fullfile(scriptPath,'Propagation_Loss_Objectives_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Objective 1:
% Propagation Loss vs Distance for Different Frequencies
%% ==========================================================

d = 0.1:0.1:5;                 % Distance (km)

f1 = 900;                      % Sub-1 GHz
f2 = 3500;                     % Mid-band
f3 = 28000;                    % mmWave

% Free Space Path Loss
PL1 = 32.44 + 20*log10(f1) + 20*log10(d);
PL2 = 32.44 + 20*log10(f2) + 20*log10(d);
PL3 = 32.44 + 20*log10(f3) + 20*log10(d);

fig1 = figure;

plot(d,PL1,'LineWidth',2);
hold on;
plot(d,PL2,'LineWidth',2);
plot(d,PL3,'LineWidth',2);

title('Propagation Loss vs Distance');
xlabel('Distance (km)');
ylabel('Propagation Loss (dB)');
legend('900 MHz','3.5 GHz','28 GHz','Location','best');
grid on;

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_PropagationLoss_vs_Distance.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 2:
% Propagation Loss vs Operating Frequency
%% ==========================================================

d_fixed = 2;                   % Fixed Distance (km)

freq = [900 3500 28000];

PL_freq = 32.44 + 20*log10(freq) + 20*log10(d_fixed);

fig2 = figure;

plot(freq,PL_freq,'-o','LineWidth',2);

title('Propagation Loss vs Operating Frequency');
xlabel('Frequency (MHz)');
ylabel('Propagation Loss (dB)');
grid on;

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_PropagationLoss_vs_Frequency.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 3:
% Comparison of Propagation Loss Across Frequency Bands
%% ==========================================================

fig3 = figure;

plot(1:3,PL_freq,'-s','LineWidth',2);

title('Propagation Loss Comparison Across Bands');
xlabel('Frequency Band');
ylabel('Propagation Loss (dB)');

xticks([1 2 3]);
xticklabels({'Sub-1GHz','Mid-band','mmWave'});

grid on;

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_PropagationLoss_Comparison.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp('==========================================');
disp('Propagation Loss Results at 2 km');
disp('==========================================');

Frequency_MHz = freq';
Propagation_Loss_dB = PL_freq';

Result = table(Frequency_MHz,Propagation_Loss_dB);

disp(Result);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('Program executed successfully.');
disp(['Images saved in: ',outputFolder]);

disp('Saved Files:');
disp('1. Objective1_PropagationLoss_vs_Distance.png');
disp('2. Objective2_PropagationLoss_vs_Frequency.png');
disp('3. Objective3_PropagationLoss_Comparison.png');