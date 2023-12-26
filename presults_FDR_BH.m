addpath  /Users/rinsen/matlab/Toolbox/MultipleTestingToolbox
load('../Data/p_rsdata.mat')
% corrected for Fig3
[q, c_alpha, h, extra]=fdr_BH([plist], 0.05)

% for another distinct question: corrected for correlation with practice time of all periods
[q, c_alpha, h, extra]=fdr_BH([plist_pract], 0.05)

% corrected for Fig5
load('../Data/p_taskdata.mat')
[q, c_alpha, h, extra]=fdr_BH([plist_task], 0.05)