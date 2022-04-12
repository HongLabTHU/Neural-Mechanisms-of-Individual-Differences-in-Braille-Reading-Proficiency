%% load FC and behavioral data
clear all
load('../Data/z_001IFC2extrafull0_V1_BS.mat')

IFC2LLOC = B_z_lh{1,1};
IFC2LV1 = B_z_lh{1,2};

%% USE!box plot, B = 15, S = 14
% z-FC LIFC-FC
LIFC_FC = [IFC2LLOC; S_z_lh{1,1}; IFC2LV1; S_z_lh{1,2}];

g1 = repmat({'BL LOC'},length(IFC2LLOC),1); %
g2 = repmat({'SL LOC'},length(S_z_lh{1,1}),1);
g3 = repmat({'BL V1'},length(IFC2LV1),1);
g4 = repmat({'SR V1'},length(S_z_lh{1,2}),1);
g = [g1;g2;g3;g4];

figure;boxplot(LIFC_FC,g,'Positions',[0.2,0.28,0.65,0.73],'Widths',0.06,'OutlierSize',8)
title('LIFC FC')
set(gca,'YLim',[-0.18,1.08])

%% USE!box plot, B = 15, S = 14
% z-FC LIPS-FC
LIPS_FC = [B_z_lh{2,1}; S_z_lh{2,1}];

G1 = repmat({'BL LOC'},length(B_z_lh{2,1}),1); %
G2 = repmat({'SL LOC'},length(S_z_lh{2,1}),1);
G = [G1;G2];

figure;boxplot(LIPS_FC,G,'Positions',[0.2,0.28],'Widths',0.06,'OutlierSize',8)
title('LIPS FC')
set(gca,'YLim',[-0.18,1.08])
