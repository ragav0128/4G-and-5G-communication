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

outputFolder = fullfile(scriptPath,'Beamforming_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% OBJECTIVE 1 : Beamforming Gain
%% ==========================================================

antennas = [2 4 8 16 32];

% Beamforming Gain
gain = 10*log10(antennas);

fig1 = figure;

bar(antennas,gain)

grid on

xlabel('Number of Antenna Elements')
ylabel('Beamforming Gain (dB)')
title('Beamforming Gain for Different Antenna Array Sizes')

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_Beamforming_Gain.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : Beam Width
%% ==========================================================

beamwidth = [90 45 22.5 11.25 5.625];

fig2 = figure;

plot(antennas,beamwidth,'o-','LineWidth',2)

grid on

xlabel('Number of Antenna Elements')
ylabel('Beam Width (Degrees)')
title('Beam Width for Different Antenna Array Sizes')

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_Beam_Width.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : Analog Beamforming Main Lobe Direction
%% ==========================================================

theta = [-60 -30 0 30 60];

normalizedGain = [1 1 1 1 1];

fig3 = figure;

polarplot(deg2rad(theta),normalizedGain,...
    'o','LineWidth',2)

title('Main Lobe Direction in Analog Beamforming')

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_Main_Lobe_Direction.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp(' ');
disp('==============================================');
disp('BEAMFORMING ANALYSIS RESULTS');
disp('==============================================');

Result = table(antennas',...
               gain',...
               beamwidth',...
    'VariableNames',{'Antenna_Elements',...
                     'Beamforming_Gain_dB',...
                     'Beamwidth_Degrees'});

disp(Result);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All beamforming objectives executed successfully.');

disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');
disp('1. Objective1_Beamforming_Gain.png');
disp('2. Objective2_Beam_Width.png');
disp('3. Objective3_Main_Lobe_Direction.png');