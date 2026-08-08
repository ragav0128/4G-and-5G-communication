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

outputFolder = fullfile(scriptPath,'TDMA_Analysis_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Objective 1 : TDMA Time Slot Structure
%% ==========================================================

FrameTime = 4.615;      % GSM Frame Time (ms)
Slots = 8;              % Number of Time Slots
SlotDuration = FrameTime/Slots;

t = 0:SlotDuration:FrameTime;

fig1 = figure;

subplot(2,1,1)
stem(t,ones(size(t)),'filled')
title('TDMA Time Slot Structure')
xlabel('Time (ms)')
ylabel('Slot Level')
grid on

subplot(2,1,2)
plot(t,ones(size(t)),'-o','LineWidth',1.5)
title('Continuous View of Slot Allocation')
xlabel('Time (ms)')
ylabel('Slot Presence')
grid on

exportgraphics(fig1,...
    fullfile(outputFolder,'Objective1_TDMA_Time_Slot_Structure.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 2 : GSM Frame Utilization
%% ==========================================================

TotalSlots = 8;
AllocatedSlots = 6;
FreeSlots = TotalSlots - AllocatedSlots;

Utilization = (AllocatedSlots/TotalSlots)*100;

disp(' ')
disp('==============================')
disp('Frame Utilization (%)')
disp(Utilization)

fig2 = figure;

subplot(2,1,1)
plot([1 2],[AllocatedSlots FreeSlots],'-o','LineWidth',2)
title('GSM Frame Utilization')
xlabel('Slot Type')
ylabel('Number of Slots')
xticks([1 2])
xticklabels({'Allocated','Free'})
grid on

subplot(2,1,2)
pie([AllocatedSlots FreeSlots])
title('Slot Distribution in GSM Frame')
legend('Allocated','Free')

exportgraphics(fig2,...
    fullfile(outputFolder,'Objective2_GSM_Frame_Utilization.png'),...
    'Resolution',300);

%% ==========================================================
% Objective 3 : TDMA Slot Allocation per User
%% ==========================================================

Users = 1:8;

AvailableSlots = 5;

Alloc = zeros(1,8);
Alloc(1:AvailableSlots) = 1;

Blocked = 1 - Alloc;

disp(' ')
disp('==============================')
disp('User Wise Slot Allocation')

disp(table(Users',Alloc',...
    'VariableNames',{'User','Status_1_Allocated_0_Blocked'}))

fig3 = figure;

subplot(2,1,1)
stem(Users,Alloc,'filled','LineWidth',2)
title('TDMA Slot Allocation per User')
xlabel('User Index')
ylabel('Slot Status')
ylim([-0.2 1.2])
grid on

subplot(2,1,2)
plot(Users,Alloc,'-o','LineWidth',2)
hold on
plot(Users,Blocked,'-s','LineWidth',2)

title('TDMA Slot Utilization Analysis')
xlabel('User Index')
ylabel('Status')

legend('Allocated','Blocked')
grid on

exportgraphics(fig3,...
    fullfile(outputFolder,'Objective3_TDMA_Slot_Allocation.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ')
disp('All objectives executed successfully.')
disp(['Images saved in: ',outputFolder])

disp('Saved Files:')
disp('1. Objective1_TDMA_Time_Slot_Structure.png')
disp('2. Objective2_GSM_Frame_Utilization.png')
disp('3. Objective3_TDMA_Slot_Allocation.png')