% run script for visuals - analyses in grey matter, 97332 voxels:
% (1) Politic > Neutral; (2) Neural_&_Behavioral correlations
% 
% Crating:
% (1) Inflated Brains; (2) Nifti_BNA_Analysis (summary tables)

% upload the data:
% ---------------
% sigvals_euc_dis = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigvals_euc_dis.mat');
% sigindx_euc_dis = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigindx_euc_dis.mat');
% politic_more_than_neutral = niftiread();
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/ttest - euclidean distance political vs. neutral/stats_euc_dic.mat');
politic_more_than_Neutral = stats_euc_dis.tstat';


% load the relevant "collective_kept_vox":
% ----------------------------------------
kept_vox_220394_of_902629 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox.mat');
kept_vox_220394_of_902629 = kept_vox_220394_of_902629.unified_keptVox;
kept_vox_97332_of_220394 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/GM_reshape_adjusted_to_unified_keptvox_GM.mat');
kept_vox_97332_of_220394 = kept_vox_97332_of_220394.GM_reshape_adjusted_to_unified_keptvox_GM;


kept_vox_97332_of_902629 = kept_vox_220394_of_902629; % combining the two keptvox vectors
kept_vox_97332_of_902629(kept_vox_220394_of_902629) = kept_vox_97332_of_220394;

% create vector ready for analysis:
% ---------------------------------
politic_more_than_Neutral_whole_brain = double(kept_vox_97332_of_902629);
politic_more_than_Neutral_whole_brain(kept_vox_97332_of_902629) = politic_more_than_Neutral;




% create_nifties:
% ---------------
outputpath = '/media/ubuntu/4TeraDrive/elections/results/results_with_GM_97332_voxels';
savename_ttest = 'politic_more_than_Neutral_whole_brain';
values_to_nifti(politic_more_than_Neutral_whole_brain, 2, '', outputpath, savename_ttest, false)
