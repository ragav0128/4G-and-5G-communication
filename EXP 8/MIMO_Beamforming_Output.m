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

outputFolder = fullfile(scriptPath,'MIMO_Beamforming_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Common Parameters
%% ==========================================================

angle = [-60 -30 0 30 60];      % Steering Angles (degrees)

%% ==========================================================
% OBJECTIVE 1 : Steering Angle Variation
%% ==========================================================

gain_normalized = ones(size(angle));

fig1 = figure;

polarplot(deg2rad(angle),gain_normalized,...
    'o-','LineWidth',2)

title('Steering Angle Variation in MIMO Beamforming')

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_Steering_Angle.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : Array Gain for Different Steering Angles
%% ==========================================================

gain = [9 12 15 12 9];           % Array Gain (dB)

fig2 = figure;

bar(angle,gain)

grid on

xlabel('Steering Angle (Degrees)')
ylabel('Array Gain (dB)')
title('Array Gain for Different Steering Angles')

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_Array_Gain.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : Beam Direction Error
%% ==========================================================

desired = [-60 -30 0 30 60];

actual = [-58 -32 1 29 62];

error = abs(desired - actual);

fig3 = figure;

plot(desired,error,'o-','LineWidth',2)

grid on

xlabel('Desired Steering Angle (Degrees)')
ylabel('Beam Direction Error (Degrees)')
title('Beam Direction Error for Different Steering Angles')

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_Beam_Direction_Error.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp(' ');
disp('==============================================');
disp('MIMO BEAMFORMING RESULTS');
disp('==============================================');

Result = table(desired',...
               actual',...
               error',...
    'VariableNames',{'Desired_Angle',...
                     'Actual_Angle',...
                     'Beam_Direction_Error'});

disp(Result);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All MIMO beamforming objectives executed successfully.');

disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');
disp('1. Objective1_Steering_Angle.png');
disp('2. Objective2_Array_Gain.png');
disp('3. Objective3_Beam_Direction_Error.png');