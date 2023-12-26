% Fig1
num = xlsread('../Data/AllBlindSubjs_behaviour data.xlsx', -1);
profi_all = num(:,4);
figure;
histfit(profi_all,11)
ylim([0,15])
pd = fitdist(profi_all,'Normal');
