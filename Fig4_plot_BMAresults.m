%% USE: plot Exceedance probability
load('../Data/BMS.mat');

figure;
bar(0.2,BMS.DCM.rfx.model.xp(1),'BarWidth' ,0.16); 
hold on
bar(0.4,BMS.DCM.rfx.model.xp(2), 'BarWidth' ,0.16);
hold on
bar(0.6,BMS.DCM.rfx.model.xp(3), 'BarWidth' ,0.16);
hold on
bar(0.8,BMS.DCM.rfx.model.xp(4), 'BarWidth' ,0.16);
xlim([0,1])

%% USE! BMA parameter distribution

for j = 1:10000
    a_BU(j) = BMS.DCM.rfx.bma.a(4,2,j);
    a_TD(j) = BMS.DCM.rfx.bma.a(2,4,j);
    a_LOC2IPS(j) = BMS.DCM.rfx.bma.a(1,2,j);
end
a_BU = a_BU';
a_TD = a_TD';
a_LOC2IPS = a_LOC2IPS';


for j = 1:10000
    b_BU(j) = BMS.DCM.rfx.bma.b(4,2,1,j);
    b_TD(j) = BMS.DCM.rfx.bma.b(2,4,1,j);
end
b_BU = b_BU';
b_TD = b_TD';

%% USE: plot fitted gaussian curve of data; the hist result is different from hist( ,100).
% plot top-down&bottom-up, a&b together
% BU
figure;
histfit(a_BU,100);
hold on;plot([BMS.DCM.rfx.bma.mEp.A(4,2) BMS.DCM.rfx.bma.mEp.A(4,2)], [0,400])

hold on;histfit(b_BU,100);
hold on;plot([BMS.DCM.rfx.bma.mEp.B(4,2) BMS.DCM.rfx.bma.mEp.B(4,2)], [0,400])

% TD
histfit(a_TD,100);
hold on;plot([BMS.DCM.rfx.bma.mEp.A(2,4) BMS.DCM.rfx.bma.mEp.A(2,4)], [0,400])

hold on;histfit(b_TD,100);
hold on;plot([BMS.DCM.rfx.bma.mEp.B(2,4) BMS.DCM.rfx.bma.mEp.B(2,4)], [0,400])
xlim([-1,2])

%% USE: boxplot for Nsamples = 10000, modulatory effects
b_BU_TD = [b_BU;b_TD]; % 20000*1
g1 = repmat({'b_BU'},10000,1);
g2 = repmat({'b_TD'},10000,1);
g = [g1;g2];

figure;boxplot(b_BU_TD,g,'Positions',[0.2,0.65],'Widths',0.06,'Symbol','')
hold on; scatter([0.2,0.65],[BMS.DCM.rfx.bma.mEp.B(4,2),BMS.DCM.rfx.bma.mEp.B(2,4)],'b+')
