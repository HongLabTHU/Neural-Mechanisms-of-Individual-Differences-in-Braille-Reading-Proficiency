% run 
clear all
close all
%% load DCM params
load('../Data/DCM_params_SingleSubj.mat');
modula_para = ModuBMA_singleSubj_RFX_group;

% Here we matched subjs with rsdata and task data because the functional LOC
% was definition by the peak activation in the task and rsFC data jointly.
% N = 13
% Bottom-Up: modula_para(:,1); Top-Down: modula_para(:,2)

modula_para = modula_para([1:12,14],:);

%% load task-behavior data
load('../Data/task_data_withmodu20210912.mat')

Beha_task = [task_data_withmodu.Childhood, task_data_withmodu.Adolescence, task_data_withmodu.Adult, task_data_withmodu.TrainTime, task_data_withmodu.BrailleYear];
Beha_name = {'Childhood'; 'Adolescence'; 'Adult'; 'TrainTime'; 'BrailleYear'};

% for DCM_param-LOC area-profi mediation
profi = task_data_withmodu.Speed([1:12,14]);

%% load LOC-FC data, Using the data after adjusting life periods span
load('../Data/avg_std_FCz_seedROI_tarvertex.mat')
load('../Data/z_001IFC2extrafull0_V1_BS.mat')
% avg_ROI_z_seed_lh_tar_all{1}: LOC seed; avg_ROI_z_seed_lh_tar_all{2}: V1 seed;

%% newdata.IFG2V2 = L_IFC2L_LOC

IFC2LLOC = B_z_lh{1,1}([1:5,7:14]);
stan_IFC2LLOC = (IFC2LLOC-avg_ROI_z_seed_lh_tar_all{1}([1:5,7:13,end-1]))./std_ROI_z_seed_lh_tar_all{1}([1:5,7:13,end-1]);
rsFC = stan_IFC2LLOC;

%% activated peak&rsFC-defined plastic LOC area: all the vertex within anatomical LOC whose rsFC with the peak activation vertex > threshold )
%% N = 13, calculate area of funLOC
load('../Data/peakLOC_rsFC.mat')
stan_z_seed_lh_tar_lh_LOC = z_seed_lh_tar_lh_LOC-avg_z_seed_lh_tar_lh_all;

max(max(stan_z_seed_lh_tar_lh_LOC))
min(min(stan_z_seed_lh_tar_lh_LOC))
thre = -0.4:0.2:2.2;

LOC_area_rsFC = zeros(13,length(thre));
for ith = 1:length(thre)
    LOC_area_rsFC_tmp = (stan_z_seed_lh_tar_lh_LOC>thre(ith));
    LOC_area_rsFC(:,ith) = sum(LOC_area_rsFC_tmp, 2);
end

%% normalized funLOC area
% to keep consistent with the normalized rsFC, 100 is the num of vertex within anotomical left LOC
LOC_area_rsFC = LOC_area_rsFC./100;

%% N = 13, DCM param - funLOC area
r_rank = zeros(2,length(thre)); p_rank = ones(2,length(thre));
r_rank_profi = zeros(1,length(thre)); p_rank_profi = ones(1,length(thre));
r_rank_rsFC = zeros(1,length(thre)); p_rank_rsFC = ones(1,length(thre));
r = zeros(2,length(thre)); p = ones(2,length(thre));
r_profi = zeros(1,length(thre)); p_profi = ones(1,length(thre));
r_rsFC = zeros(1,length(thre)); p_rsFC = ones(1,length(thre));

modu_type = {'BU','TD'};

for j = 1:length(thre)
    if sum(LOC_area_rsFC(:,j)==0)<1  
        for i = 1:2                     
            [r(i,j), p(i,j)] = corr(modula_para(:,i), LOC_area_rsFC(:,j));            
        end
        % correlation with proficiency        
        [r_profi(j), p_profi(j)] = corr(LOC_area_rsFC(:,j), profi); 
        
    end
end
star_thre_idx = intersect(find(p_profi<0.05), find(p(2,:)<0.05))

figure;
subplot(2,1,1); plot(thre,p(1,:));
title('BU-funLOC area')
hold on; scatter(thre(star_thre_idx),p(1,star_thre_idx),'b','filled');

subplot(2,1,2); plot(thre,p(2,:));
title('TD-funLOC area')
hold on; scatter(thre(star_thre_idx),p(2,star_thre_idx),'r','filled')

%% plot eps figures
% TD_modu-LOC_area 
uiopen('/Users/rinsen/New_Journey/VWFA/My_paper/paper_20190727/AllFigures/Figs_ai20211219/processing/Fig5_LOCarea_profi.fig',1)

figure;scatter(modula_para(:,2),LOC_area_rsFC(:,7),100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
title('TD modu-LOC area')
xlim([-2,5])
% BU_modu-LOC_area
figure;scatter(modula_para(:,1),LOC_area_rsFC(:,7),100,'MarkerEdgeColor','k','MarkerFaceColor','k');
title('BU modu-LOC area')


% LOC_area-proficiency
figure;scatter(LOC_area_rsFC(:,7),profi,100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
title('LOC area-profi')
ylim([0,200])

