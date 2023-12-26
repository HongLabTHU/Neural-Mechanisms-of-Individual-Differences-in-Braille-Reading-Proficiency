% plot Figure 5ABC, correlation of TD modu-profi, and BU modu-profi,
% N = 14
% scripted by wrx, 20220224
clear all
close all
%% load load sid list used in PPI (same in DCM)
load('../Data/DCM_params_SingleSubj.mat');
modula_para = ModuBMA_singleSubj_RFX_group;

%% load task-behavior data
load('../Data/task_data_withmodu20210912.mat')

% N = 14, with LYH
profi = task_data_withmodu.Speed;

%%
[r_TD, p_TD] = corr(modula_para(:,2),profi)
[r_BU, p_BU] = corr(modula_para(:,1),profi)

%% plot eps figures
uiopen('/Users/rinsen/New_Journey/VWFA/My_paper/paper_20190727/AllFigures/Figs_ai20211219/processing/Fig5_LOCarea_profi.fig',1)
% TD_modu-profi

figure;scatter(modula_para(:,2),profi,100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
title('TD modu-profi')
xlim([-2,5])
ylim([0,200])

% BU_modu-profi
figure;scatter(modula_para(:,1),profi,100,'MarkerEdgeColor','k','MarkerFaceColor','k');
title('BU modu-profi')
ylim([0,200])

%% partial correlation: TD-profi controlling BU
[r_partial_TD,p_partial_TD] = partialcorr(modula_para(:,2),profi,modula_para(:,1))

%% partial correlation: BU-profi controlling TD
[r_partial_BU,p_partial_BU] = partialcorr(modula_para(:,1),profi,modula_para(:,2))

%% plot figures
figure('color','w');
stem(0.2,r_TD);
hold on;stem(0.2,r_partial_TD); % 横纵坐标值，以X值为中心，宽0.15，画柱状条，facecolor是柱状条的颜色（rgb吧）

hold on;stem(0.6,r_BU); % 横纵坐标值，以X值为中心，宽0.15，画柱状条，facecolor是柱状条的颜色（rgb吧）
hold on;stem(0.6,r_partial_BU); % 横纵坐标值，以X值为中心，宽0.15，画柱状条，facecolor是柱状条的颜色（rgb吧）
xlim([0,0.8])
ylim([0,0.5])
yticks(0.1:0.1:0.5)
set(gca, 'xtick',[]);   % 去掉x轴标记

