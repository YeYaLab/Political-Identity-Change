


% cluster-size correction

        % create a nifti for uncorrected correlations
        kept_vox_220394_of_902629 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox.mat');
        kept_vox_220394_of_902629 = kept_vox_220394_of_902629.unified_keptVox;
        kept_vox_97332_of_220394 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/GM_reshape_adjusted_to_unified_keptvox_GM.mat');
        kept_vox_97332_of_220394 = kept_vox_97332_of_220394.GM_reshape_adjusted_to_unified_keptvox_GM;
        
        kept_vox_97332_of_902629 = kept_vox_220394_of_902629; % combining the two keptvox vectors
        kept_vox_97332_of_902629(kept_vox_220394_of_902629) = kept_vox_97332_of_220394;

        percentile_sig = 95;
        temporary_nifty_path = '/media/ubuntu/4TeraDrive/elections/results/clustersize_corection';

% % general
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/general/corr_general_full.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_general.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about two minutes

new_nifti = double(kept_vox_97332_of_902629);
new_nifti(kept_vox_97332_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_97332_general', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_97332_general', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
disp('General:')
disp(['The correlation threshold (95 percentile of all uncorrected 97332 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.26092
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 19

% % ingroup
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ingroup/corr_ingroup_full.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_ingroup.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about two minutes

new_nifti = double(kept_vox_97332_of_902629);
new_nifti(kept_vox_97332_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_97332_ingroup', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_97332_ingroup', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
disp('Ingroup:')
disp(['The correlation threshold (95 percentile of all uncorrected 97332 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.2836
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 20

% % ideology
% _________

% find threshold for cluster size (based on nulldist)
actual_r_values = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ideology/corr_ideology_full.mat');
actual_r_values = actual_r_values.(char(fieldnames(actual_r_values)));
nulldist = load('/mnt/backup2/Teams&Projects/Elections2019/Null_dist_for_cluster/post thesis/null_mat_ED_ideology.mat');
nulldist = nulldist.(char(fieldnames(nulldist)));

null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path); % about two minutes

new_nifti = double(kept_vox_97332_of_902629);
new_nifti(kept_vox_97332_of_902629) = actual_r_values;

values_to_nifti(new_nifti, 2, '', temporary_nifty_path, 'uncorrected_97332_ideology', false);

% remove small clusters
remove_small_clusters_of_nifti(temporary_nifty_path, 'uncorrected_97332_ideology', prctile(actual_r_values, 95), prctile(null_cluster_sizes, 95))
new_mask = fullfile(temporary_nifty_path, 'uncorrected_97332_ideology');
command = ['fslmaths ', new_mask, ' -thr 0.01 -bin ', new_mask, '_masked'];
unix(command)

disp('Ideology:')
disp(['The correlation threshold (95 percentile of all uncorrected 97332 voxels) is:     ', num2str(prctile(actual_r_values, 95)), '.']) % 0.17727
disp(['The cluster threshold (95 percentile of null_cluster_sizes) is:     ', num2str(prctile(null_cluster_sizes, 95)), '.']) % 20

