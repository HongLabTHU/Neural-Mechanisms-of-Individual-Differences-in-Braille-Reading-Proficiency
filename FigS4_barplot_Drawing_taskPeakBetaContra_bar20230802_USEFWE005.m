%% load data
% from spm_regions.m line 190: 20211219
load('../Data/MyVOI_y_withextrafull0_20211219.mat');load('../Data/anno_IPS_idx.mat');

load('../Data/Task/SI_grpGLM/interaction_F/F_mask_idx_FWE005.mat');

%% supra thre results of activations within the mask used in rsfMRI
PPC_lh_idx_new = anno_IPS_lh_idx;
LOC_lh_idx_new = intersect(LOC_lh_idx,idx_supra_clu_thre);
V1_lh_idx_new = intersect(V1_lh_idx,idx_supra_clu_thre);
IFC_lh_idx_new = intersect(IFC_lh_idx,idx_supra_clu_thre);

%% N = 14 for Blind grpGLM analysis
load('../Data/Task/SI_grpGLM/interaction_F/BetaContra_Braille_Blank.mat');
Beta_subjs_lh_Blind = Beta_Braille_Blank;
peak_T_V1 = zeros(14,2);
peak_T_extra = zeros(14,2);
peak_T_IFC = zeros(14,2);
peak_T_PPC = zeros(14,2);

for i = 1:14
    T_V1{i} = Beta_subjs_lh_Blind(i,V1_lh_idx_new);
    T_extra{i} = Beta_subjs_lh_Blind(i,LOC_lh_idx_new);
    T_IFC{i} = Beta_subjs_lh_Blind(i,IFC_lh_idx_new);
    T_PPC{i} = Beta_subjs_lh_Blind(i,PPC_lh_idx_new);
    
    sorted = sort(T_V1{i});
    peak_T_V1(i,1) = sorted(end);
    
    sorted = sort(T_extra{i});
    peak_T_extra(i,1) = sorted(end);
    
    sorted = sort(T_IFC{i});
    peak_T_IFC(i,1) = sorted(end);
    
    sorted = sort(T_PPC{i});
    peak_T_PPC(i,1) = sorted(end);
end


%% N = 14 for Sighted grpGLM analysis
load('../Data/Task/SI_grpGLM/interaction_F/BetaContra_Braille_Blank_Sighted.mat');
Beta_subjs_lh_Sighted = Beta_Braille_Blank_Sighted;

for i = 1:14
    T_V1{i} = Beta_subjs_lh_Sighted(i,V1_lh_idx_new);
    T_extra{i} = Beta_subjs_lh_Sighted(i,LOC_lh_idx_new);
    T_IFC{i} = Beta_subjs_lh_Sighted(i,IFC_lh_idx_new);
    T_PPC{i} = Beta_subjs_lh_Sighted(i,PPC_lh_idx_new);
    
    sorted = sort(T_V1{i});
    peak_T_V1(i,2) = sorted(end);
    
    sorted = sort(T_extra{i});
    peak_T_extra(i,2) = sorted(end);
    
    sorted = sort(T_IFC{i});
    peak_T_IFC(i,2) = sorted(end);
    
    sorted = sort(T_PPC{i});
    peak_T_PPC(i,2) = sorted(end);
end

%% figure
figure;
bar(0.2,mean(peak_T_extra(:,1)), 'BarWidth' ,0.2, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','black','LineWidth',2.0);
hold on
bar(0.4,mean(peak_T_extra(:,2)), 'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0);
hold on

bar(0.7,mean(peak_T_V1(:,1)),'BarWidth' ,0.2, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','black','LineWidth',2.0); % 横纵坐标值，以X值为中心，宽0.15，画柱状条，facecolor是柱状条的颜色（rgb吧）
hold on
bar(0.9,mean(peak_T_V1(:,2)),'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0); % 横纵坐标值，以X值为中心，宽0.15，画柱状条，facecolor是柱状条的颜色（rgb吧）
hold on

bar(1.2,mean(peak_T_IFC(:,1)), 'BarWidth' ,0.2, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','black','LineWidth',2.0);
hold on
bar(1.4,mean(peak_T_IFC(:,2)), 'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0);
hold on

bar(1.7,mean(peak_T_PPC(:,1)), 'BarWidth' ,0.2, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','black','LineWidth',2.0);
hold on
bar(1.9,mean(peak_T_PPC(:,2)), 'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0);

set(gca,'XLim',[-0.2,2.3])%统一设置matlab图的一些性质，'性质',value值
set(gca, 'xtick',[]);   % 去掉x轴标记
% set(gca,'YLim',[0,1.5])%统一设置matlab图的一些性质，'性质',value值

errorbar(0.2,mean(peak_T_extra(:,1)),std(peak_T_extra(:,1))./sqrt(length(peak_T_extra(:,1))),'k.','Marker','none','LineWidth',2.0);
errorbar(0.7,mean(peak_T_V1(:,1)),std(peak_T_V1(:,1))./sqrt(length(peak_T_V1(:,1))),'k.','Marker','none','LineWidth',2.0);
errorbar(1.2,mean(peak_T_IFC(:,1)),std(peak_T_IFC(:,1))./sqrt(length(peak_T_IFC(:,1))),'k.','Marker','none','LineWidth',2.0);
errorbar(1.7,mean(peak_T_PPC(:,1)),std(peak_T_PPC(:,1))./sqrt(length(peak_T_PPC(:,1))),'k.','Marker','none','LineWidth',2.0);

errorbar(0.4,mean(peak_T_extra(:,2)),std(peak_T_extra(:,2))./sqrt(length(peak_T_extra(:,2))),'k.','Marker','none','LineWidth',2.0);
errorbar(0.9,mean(peak_T_V1(:,2)),std(peak_T_V1(:,2))./sqrt(length(peak_T_V1(:,2))),'k.','Marker','none','LineWidth',2.0);
errorbar(1.4,mean(peak_T_IFC(:,2)),std(peak_T_IFC(:,2))./sqrt(length(peak_T_IFC(:,2))),'k.','Marker','none','LineWidth',2.0);
errorbar(1.9,mean(peak_T_PPC(:,2)),std(peak_T_PPC(:,2))./sqrt(length(peak_T_PPC(:,2))),'k.','Marker','none','LineWidth',2.0);

set(gca,'Fontname', 'Arial','FontSize',20,'FontWeight','Bold','LineWidth',2.0)%给横纵坐标这两条线设置宽度参数，宽度同上面的y=0那条线'LineWidth',2.0，好像跟默认不设置值效果一样

    