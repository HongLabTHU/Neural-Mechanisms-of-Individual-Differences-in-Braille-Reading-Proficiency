%% USE: bar plot for MSE of models
% run Fig6_CV.m for each model and save the data used here
load('../Data/modelCV_NormalizedFunLOCarea.mat')

sum_sse = (profi_tmp-cell2mat(profi_hat_summed_linear)).^2;
rsFC_sse = (profi_tmp-cell2mat(profi_hat_rsFC_linear)).^2;
LOCarea_sse = (profi_tmp-cell2mat(profi_hat_LOCarea_linear)).^2;

figure; bar(0.2,mean(sum_sse),'BarWidth' ,0.2, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','black','LineWidth',2.0); 
hold on; bar(0.5,mean(rsFC_sse),'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0);
hold on; bar(0.8,mean(LOCarea_sse),'BarWidth' ,0.2, 'FaceColor',[1 1 1], 'EdgeColor','black','LineWidth',2.0);

errorbar(0.2,mean(sum_sse),std(sum_sse)./sqrt(length(sum_sse)),'k.','Marker','none','LineWidth',2.0);
errorbar(0.5,mean(rsFC_sse),std(rsFC_sse)./sqrt(length(rsFC_sse)),'k.','Marker','none','LineWidth',2.0);
errorbar(0.8,mean(LOCarea_sse),std(LOCarea_sse)./sqrt(length(LOCarea_sse)),'k.','Marker','none','LineWidth',2.0);

ylim([0,1000])

set(gca,'Fontname', 'Arial','FontSize',20,'FontWeight','Bold','LineWidth',2.0)
set(gca,'XLim',[0,1])
set(gca, 'xtick',[]);   
plot(0:0.1:1,zeros(length(0:0.1:1)),'k','LineWidth',2.0)   

