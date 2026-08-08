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

outputFolder = fullfile(scriptPath,'5G_Network_Slicing_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Common Network Slice Types
%% ==========================================================

sliceNames = {'eMBB','URLLC','mMTC','Private','IoT'};

%% ==========================================================
% OBJECTIVE 1 : Number of Configured Network Slices
%% ==========================================================

count = [1 1 1 1 1];

fig1 = figure;

bar(count);

grid on;

set(gca,'XTick',1:5);
set(gca,'XTickLabel',sliceNames);

xlabel('Network Slice Type');
ylabel('Number of Network Slices');

title('Number of Configured 5G Network Slices');

exportgraphics(fig1,...
    fullfile(outputFolder,...
    'Objective1_Configured_Network_Slices.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 2 : Slice Utilization
%% ==========================================================

slices2 = categorical({'eMBB','URLLC','mMTC','Private','IoT'});

utilization = [85 70 60 75 50];

fig2 = figure;

bar(slices2,utilization);

grid on;

xlabel('Network Slice Type');
ylabel('Slice Utilization (%)');

title('Slice Utilization in 5G Network Slicing');

ylim([0 100]);

exportgraphics(fig2,...
    fullfile(outputFolder,...
    'Objective2_Slice_Utilization.png'),...
    'Resolution',300);

%% ==========================================================
% OBJECTIVE 3 : End-to-End Latency
%% ==========================================================

slices3 = 1:5;

latency = [25 5 40 15 60];

fig3 = figure;

plot(slices3,latency,'-o',...
    'LineWidth',2,...
    'MarkerSize',8);

grid on;

xticks(slices3);

xticklabels({'eMBB','URLLC','mMTC','Private','IoT'});

xlabel('Network Slice Type');
ylabel('End-to-End Latency (ms)');

title('5G Network Slicing: End-to-End Latency');

ylim([0 70]);

exportgraphics(fig3,...
    fullfile(outputFolder,...
    'Objective3_End_to_End_Latency.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

disp(' ');
disp('==============================================');
disp('5G NETWORK SLICING RESULTS');
disp('==============================================');

%% Objective 1 Results

disp(' ');
disp('OBJECTIVE 1 - Configured Network Slices');

Result1 = table(sliceNames',count',...
    'VariableNames',{'Network_Slice','Number_Configured'});

disp(Result1);

%% Objective 2 Results

disp(' ');
disp('OBJECTIVE 2 - Slice Utilization');

Result2 = table(sliceNames',utilization',...
    'VariableNames',{'Network_Slice','Utilization_Percent'});

disp(Result2);

%% Objective 3 Results

disp(' ');
disp('OBJECTIVE 3 - End-to-End Latency');

Result3 = table(sliceNames',latency',...
    'VariableNames',{'Network_Slice','Latency_ms'});

disp(Result3);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All three objectives executed successfully.');

disp(['Output folder: ',outputFolder]);

disp(' ');
disp('Saved PNG Files:');

disp('1. Objective1_Configured_Network_Slices.png');
disp('2. Objective2_Slice_Utilization.png');
disp('3. Objective3_End_to_End_Latency.png');