


% cluster-size correction - only voxels that were significant in the t test
% ( - more ED in political than in neutral)

        % create a nifti for uncorrected correlations
        kept_vox_220394_of_902629 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox.mat');
        kept_vox_220394_of_902629 = kept_vox_220394_of_902629.(char(fieldnames(kept_vox_220394_of_902629))); % unified_keptVox;
        kept_vox_97332_of_220394 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/GM_reshape_adjusted_to_unified_keptvox_GM.mat');
        kept_vox_97332_of_220394 = kept_vox_97332_of_220394.(char(fieldnames(kept_vox_97332_of_220394))); % GM_reshape_adjusted_to_unified_keptvox_GM;
        kept_vox_24848_of_97332 = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigindx_euc_dis.mat');
        kept_vox_24848_of_97332 = kept_vox_24848_of_97332.(char(fieldnames(kept_vox_24848_of_97332)));

        kept_vox_97332_of_902629 = kept_vox_220394_of_902629; % combining the two keptvox vectors
        kept_vox_97332_of_902629(kept_vox_220394_of_902629) = kept_vox_97332_of_220394;
        kept_vox_24848_of_902629 = kept_vox_97332_of_902629;
        kept_vox_24848_of_902629(kept_vox_97332_of_902629) = kept_vox_24848_of_97332;

        percentile_sig = 95;
        temporary_nifty_path = '/media/ubuntu/4TeraDrive/elections/results/clustersize_corection/only_ttest_sig_voxels';

% % general
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didnt pass fdr in ED political-neutral t-test/general/corr_general_and_ED_no_neutral.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_general.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));
nulldist = nulldist(kept_vox_24848_of_97332, :);

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about 1:30 minutes

new_nifti = double(kept_vox_24848_of_902629);
new_nifti(kept_vox_24848_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_24848_general', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_24848_general', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
disp('General:')
disp(['The correlation threshold (95 percentile of all uncorrected 24848 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.26092
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 19

% % ingroup
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didnt pass fdr in ED political-neutral t-test/ingroup/corr_ingroup_and_ED_no_neutral.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_ingroup.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));
nulldist = nulldist(kept_vox_24848_of_97332, :);

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about 1:30 minutes

new_nifti = double(kept_vox_24848_of_902629);
new_nifti(kept_vox_24848_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_24848_ingroup', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_24848_ingroup', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
disp('Ingroup:')
disp(['The correlation threshold (95 percentile of all uncorrected 24848 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.26092
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 19

% % ideology
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/after removing all voxels which didnt pass fdr in ED political-neutral t-test/ideology/corr_ideology_and_ED_no_neutral.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_ideology.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));
nulldist = nulldist(kept_vox_24848_of_97332, :);

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about 1:30 minutes

new_nifti = double(kept_vox_24848_of_902629);
new_nifti(kept_vox_24848_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_24848_ideology', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_24848_ideology', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
disp('Ideology:')
disp(['The correlation threshold (95 percentile of all uncorrected 24848 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.26092
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 19

