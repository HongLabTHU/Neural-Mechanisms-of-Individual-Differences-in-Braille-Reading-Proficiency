% This script was to perform a leave-one-out cross-validation procedure for one model 
% by commenting on the statements of other models (in this script and in the Fig6_costfunc.m). 
% Now you can directly get the results of the 'two-tale' model by running this script. 

clear all
global rsFC_train LOC_area_rsFC_train profi_train

load('../Data/ModelRawdataLOC_area_rsFC.mat')

thre_idx = 7;
[rsFC_tmp, sorted_idx] = sort(rsFC);
LOC_area_rsFC_tmp = LOC_area_rsFC(sorted_idx,:);
profi_tmp = profi(sorted_idx);

%% USE! sorted rsFC: cross-validation leave-one-out
sse = 0; % Initialize the sum of squared error.

% 'two-tale' Model, summed linear
coef_summed_linear = cell(length(profi),1);
cost_summed_linear = zeros(length(profi),1);
profi_hat_summed_linear = cell(length(profi),1);

% % rsFCOnly linear
% coef_rsFC_linear = cell(length(profi),1);
% cost_rsFC_linear = zeros(length(profi),1);
% profi_hat_rsFC_linear = cell(length(profi),1);

% % LOCareaOnly linear
% coef_LOCarea_linear = cell(length(profi),1);
% cost_LOCarea_linear = zeros(length(profi),1);
% profi_hat_LOCarea_linear = cell(length(profi),1);

for i = 1:length(sorted_idx)
    test = zeros(length(sorted_idx),1);
    test(i) = 1;
    test = logical(test);
    rsFC_train = rsFC_tmp(~test);
    LOC_area_rsFC_train = LOC_area_rsFC_tmp(~test,thre_idx);
    profi_train = profi_tmp(~test);
    
    % summed linear
    % n_param = 3
    [coef_summed_linear{i}, cost_summed_linear(i)] = fmincon('Fig6_costfunc', [1, 1, 0],[],[],[],[],[1e-3, 1e-3, -Inf]);
    profi_hat_summed_linear{i} = MysumLinear(coef_summed_linear{i}, rsFC_tmp(test), LOC_area_rsFC_tmp(test,thre_idx));
    sse = sse + sum((profi_hat_summed_linear{i} - profi_tmp(test)).^2);
      
%     % rsFConly linear
%     % n_param = 2
%     [coef_rsFC_linear{i}, cost_rsFC_linear(i)] = fmincon('Fig6_costfunc', [1, 0],[],[],[],[],[1e-3, -Inf]);
%     profi_hat_rsFC_linear{i} = rsFCLinear(coef_rsFC_linear{i}, rsFC_tmp(test));
%     sse = sse + sum((profi_hat_rsFC_linear{i} - profi_tmp(test)).^2);

%     % LOCareaonly linear
%     % n_param = 2
%     [coef_LOCarea_linear{i}, cost_LOCarea_linear(i)] = fmincon('Fig6_costfunc', [1, 0],[],[],[],[],[1e-3, -Inf]);
%     profi_hat_LOCarea_linear{i} = LOCareaLinear(coef_LOCarea_linear{i}, LOC_area_rsFC_tmp(test,thre_idx));
%     sse = sse + sum((profi_hat_LOCarea_linear{i} - profi_tmp(test)).^2);

end

MSE = sse / (length(sorted_idx));

% summed linear
MSE_summed_linear = MSE;

% % rsFC linear
% MSE_rsFC_linear = CVerr;

% % LOCarea linear
% MSE_LOCarea_linear = CVerr;

% % summed linear
profi_hat = cell2mat(profi_hat_summed_linear);
% % rsFC linear
% profi_hat = cell2mat(profi_hat_rsFC_linear);
% % LOCarea linear
% profi_hat = cell2mat(profi_hat_LOCarea_linear);

[R, tmp_p] = corr(profi_hat, profi_tmp);

% summed linear
R2_summed_linear = R*R;

% % rsFConly linear
% R2_rsFC_linear = R*R;

% % LOCareaonly linear
% R2_LOCarea_linear = R*R;

sum_sse = (profi_tmp-cell2mat(profi_hat_summed_linear)).^2;
% rsFC_sse = (profi_tmp-cell2mat(profi_hat_rsFC_linear)).^2;
% LOCarea_sse = (profi_tmp-cell2mat(profi_hat_LOCarea_linear)).^2;

%% calculate the mean coefs from cross-validation
% summed linear
coef_summed_linear_avg = mean(cell2mat(coef_summed_linear), 1);
% % LOCareaonly linear
% coef_LOCarea_linear_avg = mean(cell2mat(coef_LOCarea_linear), 1);
% % rsFConly linear
% coef_rsFC_linear_avg = mean(cell2mat(coef_rsFC_linear), 1);

%% save model parameters
% save('./modelCV_NormalizedFunLOCarea.mat','coef_summed_linear','coef_rsFC_linear','coef_LOCarea_linear','USEsids','modula_para','modu_type','profi','rsFC','LOC_area_rsFC','profi_tmp','profi_hat_summed_linear','profi_hat_rsFC_linear','profi_hat_LOCarea_linear')

%% plot eps figures

% 'two-tale' Model, summed model CV proficiency-predicted profi
figure;scatter(profi_tmp,cell2mat(profi_hat_summed_linear),100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
xlim([40,180]);ylim([20,170]);xticks([50,100,150])
xlabel('proficiency')
ylabel('predicted proficiency')

% % Model 2, rsFCOnly model CV proficiency-predicted profi
% figure;scatter(profi_tmp,cell2mat(profi_hat_rsFC_linear),100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
% xlim([40,180]);ylim([20,170]);xticks([50,100,150])
% xlabel('proficiency')
% ylabel('predicted proficiency')
% 
% % Model 3, LOCareaOnly model CV proficiency-predicted profi
% figure;scatter(profi_tmp,cell2mat(profi_hat_LOCarea_linear),100,'MarkerEdgeColor','k','MarkerFaceColor','k');lsline
% xlim([40,180]);ylim([20,170]);xticks([50,100,150])
% xlabel('proficiency')
% ylabel('predicted proficiency')

%% --------------------------------------------------------------------------
%% 'two tale' Model 1, summed linear, n_param = 3
function profi_hat = MysumLinear(param, rsFC_test, LOC_area_rsFC_test)
    a = param(1);       
    b = param(2);       
    err = param(3);       
    profi_hat=(a*rsFC_test) + (b*LOC_area_rsFC_test) + err;
end

%% rsFC only Linear n_param = 2
function profi_hat = rsFCLinear(param, rsFC_test)
    a = param(1);       
    err = param(2);      
    profi_hat=a*rsFC_test + err;
end

%% LOC only Linear n_param = 2
function profi_hat = LOCareaLinear(param, LOC_area_rsFC_test)
    a = param(1);       
    err = param(2);       
    profi_hat=(a*LOC_area_rsFC_test) + err;
end