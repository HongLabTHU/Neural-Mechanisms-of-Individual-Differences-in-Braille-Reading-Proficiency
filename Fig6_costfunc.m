function cost = Fig6_costfunc(param)
global rsFC_train LOC_area_rsFC_train profi_train
profi_esti = zeros(length(rsFC_train),1);

%% 'two-tale' Model 
a = param(1);       
b = param(2);      
err = param(3);   

profi_esti=(a*rsFC_train) + (b*LOC_area_rsFC_train) + err;

%% rsFC only Linear n_param = 2
% a = param(1);       
% err = param(2);      
% profi_esti=(a*rsFC_train) + err;

%% LOC only Linear n_param = 2
% a = param(1);       
% err = param(2);      
% profi_esti=(a*LOC_area_rsFC_train) + err;

%% ----------------------------- %
cost = sum((profi_train-profi_esti).^2);

end