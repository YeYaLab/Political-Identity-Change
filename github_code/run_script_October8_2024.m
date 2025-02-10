% run script for visuals - analyses in grey matter, 24848 voxels:
% (1) Politic > Neutral; (2) Neural_&_Behavioral correlations
% 
% Crating:
% (1) Inflated Brains; (2) Nifti_BNA_Analysis (summary tables)
%
% 24848 - the voxels of GM that t values (political > neutral) were significant

cd('/mnt/backup2/Teams&Projects/Elections2019/send to taly')

% upload the data:
% ---------------
% politic_more_than_neutral
% sigvals_euc_dis = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigvals_euc_dis.mat');
sigindx_euc_dis = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigindx_euc_dis.mat');
sigindx_euc_dis = sigindx_euc_dis.sigindx_euc_dis; % 97332 voxels with 24848 of them significant, logical
politic_more_than_neutral_97332 = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/ttest - euclidean distance political vs. neutral/stats_euc_dic.mat');
politic_more_than_neutral_97332 = politic_more_than_neutral_97332.stats_euc_dis.tstat'; % 97332 voxels, double
politic_more_than_neutral_97332(~sigindx_euc_dis) = 0;


% neural_and_behav_correlations - general
neural_and_behav_correlations_general = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/general/corr_general_and_ED_no_neutral.mat");
significant_indices_neural_and_behav_correlations_general = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlations - post FDR - only corr values that passed fdr correction/corr_general_only_after_corrections.mat'); % 24848 voxels, only some are significant, logical
neural_and_behav_correlations_general = neural_and_behav_correlations_general.corr_general_vec_and_ED_no_neutral; % 24848 voxels uncorrected
significant_indices_neural_and_behav_correlations_general = significant_indices_neural_and_behav_correlations_general.sigindx_corr_general_only_FDR_corrected; % 24848 voxels,1681 of them significant, logical
neural_and_behav_correlations_general(~significant_indices_neural_and_behav_correlations_general) = 0;
uncorrected_24848_general = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/general/corr_general_and_ED_no_neutral.mat");
uncorrected_24848_general = uncorrected_24848_general.corr_general_vec_and_ED_no_neutral;

% neural_and_behav_correlations - ideology
neural_and_behav_correlations_ideology = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/ideology/corr_ideology_and_ED_no_neutral.mat");
significant_indices_neural_and_behav_correlations_ideology = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlations - post FDR - only corr values that passed fdr correction/corr_ideology_only_after_corrections.mat'); % 24848 voxels, only some are significant, logical
neural_and_behav_correlations_ideology = neural_and_behav_correlations_ideology.corr_ideology_and_ED_no_neutral; % 24848 voxels uncorrected
significant_indices_neural_and_behav_correlations_ideology = significant_indices_neural_and_behav_correlations_ideology.sigindx_corr_ideology_only_FDR_corrected; % 24848 voxels,350 of them significant, logical
neural_and_behav_correlations_ideology(~significant_indices_neural_and_behav_correlations_ideology) = 0;
uncorrected_24848_ideology = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/ideology/corr_ideology_and_ED_no_neutral.mat");
uncorrected_24848_ideology = uncorrected_24848_ideology.corr_ideology_and_ED_no_neutral;

% neural_and_behav_correlations - ingroup
neural_and_behav_correlations_ingroup = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/ingroup/corr_ingroup_and_ED_no_neutral.mat");
significant_indices_neural_and_behav_correlations_ingroup = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlations - post FDR - only corr values that passed fdr correction/corr_ingroup_only_after_corrections.mat'); % 24848 voxels, only some are significant, logical
neural_and_behav_correlations_ingroup = neural_and_behav_correlations_ingroup.corr_ingroup_and_ED_no_neutral; % 24848 voxels uncorrected
significant_indices_neural_and_behav_correlations_ingroup = significant_indices_neural_and_behav_correlations_ingroup.sigindx_corr_ingroup_only_FDR_corrected; % 24848 voxels,2269 of them significant, logical
neural_and_behav_correlations_ingroup(~significant_indices_neural_and_behav_correlations_ingroup) = 0;
uncorrected_24848_ingroup = load("/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didn't pass fdr in ED political-neutral t-test/ingroup/corr_ingroup_and_ED_no_neutral.mat");
uncorrected_24848_ingroup = uncorrected_24848_ingroup.corr_ingroup_and_ED_no_neutral;

% theoretic pvals
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - correlations/theoretic pvalues/theoretic_pvalues_general_only_fdr_corrected.mat');
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - correlations/theoretic pvalues/theoretic_pvalues_ideology_only_fdr_corrected.mat');
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - correlations/theoretic pvalues/theoretic_pvalues_ingroup_only_fdr_corrected.mat');

uncorrected_24848_general(theoretic_pvalues_general_only_fdr_corrected > 0.05) = 0; % 2897 out of 24848
uncorrected_24848_ideology(theoretic_pvalues_ideology_only_fdr_corrected > 0.05) = 0; % 4244 out of 24848
uncorrected_24848_ingroup(theoretic_pvalues_ingroup_only_fdr_corrected > 0.05) = 0; % 3330 out of 24848

% load the relevant "collective_kept_vox":
% ----------------------------------------
kept_vox_220394_of_902629 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox.mat');
kept_vox_220394_of_902629 = kept_vox_220394_of_902629.unified_keptVox;
kept_vox_97332_of_220394 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/GM_reshape_adjusted_to_unified_keptvox_GM.mat');
kept_vox_97332_of_220394 = kept_vox_97332_of_220394.GM_reshape_adjusted_to_unified_keptvox_GM;
kept_vox_24848_of_97332 = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigindx_euc_dis.mat');
kept_vox_24848_of_97332 = kept_vox_24848_of_97332.sigindx_euc_dis;

kept_vox_97332_of_902629 = kept_vox_220394_of_902629; % combining the two keptvox vectors
kept_vox_97332_of_902629(kept_vox_220394_of_902629) = kept_vox_97332_of_220394;

kept_vox_24848_of_902629 = kept_vox_97332_of_902629; % combining the two keptvox vectors
kept_vox_24848_of_902629(kept_vox_97332_of_902629) = kept_vox_24848_of_97332;


% create vector ready for analysis:
% ---------------------------------
politic_more_than_Neutral_whole_brain = double(kept_vox_97332_of_902629);
politic_more_than_Neutral_whole_brain(kept_vox_97332_of_902629) = politic_more_than_neutral_97332;

neural_and_behav_correlations_general_whole_brain_corrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_general_whole_brain_corrected(kept_vox_24848_of_902629) = neural_and_behav_correlations_general;

neural_and_behav_correlations_ideology_whole_brain_corrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_ideology_whole_brain_corrected(kept_vox_24848_of_902629) = neural_and_behav_correlations_ideology;

neural_and_behav_correlations_ingroup_whole_brain_corrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_ingroup_whole_brain_corrected(kept_vox_24848_of_902629) = neural_and_behav_correlations_ingroup;

neural_and_behav_correlations_general_whole_brain_uncorrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_general_whole_brain_uncorrected(kept_vox_24848_of_902629) = uncorrected_24848_general;

neural_and_behav_correlations_ideology_whole_brain_uncorrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_ideology_whole_brain_uncorrected(kept_vox_24848_of_902629) = uncorrected_24848_ideology;

neural_and_behav_correlations_ingroup_whole_brain_uncorrected = double(kept_vox_24848_of_902629);
neural_and_behav_correlations_ingroup_whole_brain_uncorrected(kept_vox_24848_of_902629) = uncorrected_24848_ingroup;


% create_nifties:
% ---------------
cd '/media/ubuntu/4TeraDrive/elections/code'
outputpath = '/media/ubuntu/4TeraDrive/elections/results/results_with_GM_97332_voxels';
savename_ttest = 'politic_more_than_neutral_GM_corrected';
values_to_nifti(politic_more_than_Neutral_whole_brain, 2, '', outputpath, savename_ttest, false)

savename_corr_general = 'neural_and_behav_correlations_general_24848';
values_to_nifti(neural_and_behav_correlations_general_whole_brain_corrected, 2, '', outputpath, savename_corr_general, false)

savename_corr_ideology = 'neural_and_behav_correlations_ideology_24848';
values_to_nifti(neural_and_behav_correlations_ideology_whole_brain_corrected, 2, '', outputpath, savename_corr_ideology, false)

savename_corr_ingroup = 'neural_and_behav_correlations_ingroup_24848';
values_to_nifti(neural_and_behav_correlations_ingroup_whole_brain_corrected, 2, '', outputpath, savename_corr_ingroup, false)

savename_corr_general = 'neural_and_behav_correlations_general_thresh005_24848';
values_to_nifti(neural_and_behav_correlations_general_whole_brain_uncorrected, 2, '', outputpath, savename_corr_general, false)

savename_corr_ideology = 'neural_and_behav_correlations_ideology_thresh005_24848';
values_to_nifti(neural_and_behav_correlations_ideology_whole_brain_uncorrected, 2, '', outputpath, savename_corr_ideology, false)

savename_corr_ingroup = 'neural_and_behav_correlations_ingroup_thresh005_24848';
values_to_nifti(neural_and_behav_correlations_ingroup_whole_brain_uncorrected, 2, '', outputpath, savename_corr_ingroup, false)




