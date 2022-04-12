%% load FC and behavioral data
clear all
load('./rs_data_behav20210912.mat')
load('./z_001IFC2extrafull0_V1_BS.mat')
load('./avg_std_FCz_seedROI_tarvertex.mat')

%% USE!newdata.IFG2V2 = L_IFC2L_LOC
newdata = rest_data;
IFC2LLOC = B_z_lh{1,1};
stan_IFC2LLOC = (IFC2LLOC-avg_ROI_z_seed_lh_tar_all{1}([1:13,end-1:end]))./std_ROI_z_seed_lh_tar_all{1}([1:13,end-1:end]);
newdata.IFG2V2 = stan_IFC2LLOC;

%% USE!newdata.IFG2V1 = L_IFC2L_V1
IFC2LV1 = B_z_lh{1,2};
stan_IFC2LV1 = (IFC2LV1-avg_ROI_z_seed_lh_tar_all{2}([1:13,end-1:end]))./std_ROI_z_seed_lh_tar_all{2}([1:13,end-1:end]);
newdata.IFG2V1 = stan_IFC2LV1;

%% USE! in Fig 3: FC - behavioral, N = 15
x = [newdata.IFG2V2,newdata.IFG2V1]; 

y = [newdata.Childhood,newdata.Adolescence,newdata.Adult,newdata.TrainTime,newdata.Speed,newdata.BlindYear];

z = [newdata.meanFD,newdata.BlindAge,newdata.Age];

[rho_rank,pval_rank] = partialcorr(x,y,z,'Type','Spearman')
[r_rank,p_rank] = corr(x,y,'Type','Spearman')

[rho,pval] = partialcorr(x,y,z)
[r,p] = corr(x,y)

%% USE!plot figure3 & SI figure3, N = 15

figure;scatter(newdata.Adolescence,newdata.IFG2V2,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
lsline
title('Adole - IFC2LLOC')
ylim([-0.5,3.5])
xlim([0,2e04])

figure;scatter(newdata.Childhood,newdata.IFG2V2,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Child - IFC2LLOC')
ylim([-0.5,3.5])
xlim([0,10.5e03])

figure;scatter(newdata.Adult,newdata.IFG2V2,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Adult - IFC2LLOC')
ylim([-0.5,3.5])
xlim([0,10.5e03])

figure;scatter(newdata.Speed,newdata.IFG2V2,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
lsline
title('Proficiency - IFC2LLOC')
ylim([-0.5,3.5])
xlim([0,200])

%% USE!LIFC-LV1
figure;scatter(newdata.Adolescence,newdata.IFG2V1,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Adole - IFC2LV1')
ylim([-0.515,3.5])
xlim([0,2e04])

figure;scatter(newdata.Speed,newdata.IFG2V1,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Proficiency - IFC2LV1')
ylim([-0.515,3.5])
xlim([0,200])

figure;scatter(newdata.Childhood,newdata.IFG2V1,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Child - IFC2LV1')
ylim([-0.515,3.5])
xlim([0,10.5e03])

figure;scatter(newdata.Adult,newdata.IFG2V1,112,'MarkerEdgeColor','k','MarkerFaceColor','k')
title('Adult - IFC2LV1')
ylim([-0.515,3.5])
xlim([0,10.5e03])
