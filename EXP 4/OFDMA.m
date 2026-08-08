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

outputFolder = fullfile(scriptPath,'OFDMA_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Objective 1 : Resource Block Allocation
%% ==========================================================

bandwidth = 10e6;      % 10 MHz
rb_size = 180e3;       % 180 kHz per Resource Block

total_RB = floor(bandwidth/rb_size);

users = 1:6;

base = floor(total_RB/length(users));

alloc = base*ones(1,length(users));

alloc(1:mod(total_RB,length(users))) = ...
    alloc(1:mod(total_RB,length(users))) + 1;

utilization = (alloc/total_RB)*100;

disp('Total Resource Blocks')
disp(total_RB)

disp('RB Allocation per User')
disp(alloc)

fig1 = figure;

subplot(2,1,1)
stem(users,alloc,'filled','LineWidth',2)
title('OFDMA Resource Block Allocation')
xlabel('User Index')
ylabel('Allocated RBs')
grid on

subplot(2,1,2)
plot(users,utilization,'-o','LineWidth',2)
title('Resource Block Utilization')
xlabel('User Index')
ylabel('Utilization (%)')
grid on

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_RB_Allocation.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 2 : Resource Block Utilization
%% ==========================================================

total_RB = 50;

users = 1:5;

alloc = [12 10 9 8 11];

util = (alloc/total_RB)*100;

disp('Resource Block Utilization (%)')
disp(util')

fig2 = figure;

subplot(2,1,1)
plot(users,alloc,'-o','LineWidth',2)
title('RB Allocation per User')
xlabel('User Index')
ylabel('Allocated RBs')
grid on

subplot(2,1,2)
plot(users,util,'-s','LineWidth',2)
title('RB Utilization')
xlabel('User Index')
ylabel('Utilization (%)')
grid on

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_RB_Utilization.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 3 : User Throughput
%% ==========================================================

rb_bw = 180e3;

alloc_RB = [12 10 9 8 11];

mod_eff = [2 4 6 4 2];

throughput = (alloc_RB.*rb_bw.*mod_eff)/1e6;

disp('User Throughput (Mbps)')
disp(throughput')

fig3 = figure;

subplot(2,1,1)
plot(users,throughput,'-o','LineWidth',2)
title('User Throughput')
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
    fullfile(outputFolder,'Objective3_User_Throughput.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ')
disp('All OFDMA objectives executed successfully.')

disp(['Images saved in: ',outputFolder])

disp('Saved Files:')
disp('1. Objective1_RB_Allocation.png')
disp('2. Objective2_RB_Utilization.png')
disp('3. Objective3_User_Throughput.png')