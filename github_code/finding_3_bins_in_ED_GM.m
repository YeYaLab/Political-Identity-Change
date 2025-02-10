

three_bins_nifti = niftiread('/media/ubuntu/4TeraDrive/elections/results/figures/ttest_on_EDbins/ed_all_mean_divided_to_3_grey_matter.nii');
load('/media/ubuntu/4TeraDrive/elections/dataMats/final_ed_all_,mean_omit_nan.mat')
is_same_nifti = zeros(size(kept_vox_97332_of_902629));
is_same_nifti(kept_vox_97332_of_902629) = final_ED_all_mean_omit_nan;
values_to_nifti(is_same_nifti, 2, '', '', 'is_same_nifti', false);

% "three_bins_nifti" is the "is_same_nifti" but divided into 3 bins

clusters = ceil(3 * tiedrank(final_ED_all_mean_omit_nan) / length(final_ED_all_mean_omit_nan));

% bin 1:
bin_1 = final_ED_all_mean_omit_nan(clusters == 1);
disp(['cluster 1 - mean: ', num2str(mean(bin_1)), ' standard deviation: ', num2str(std(bin_1))])

% bin 2:
bin_2 = final_ED_all_mean_omit_nan(clusters == 2);
disp(['cluster 2 - mean: ', num2str(mean(bin_2)), ' standard deviation: ', num2str(std(bin_2))])

% bin 3:
bin_3 = final_ED_all_mean_omit_nan(clusters == 3);
disp(['cluster 3 - mean: ', num2str(mean(bin_3)), ' standard deviation: ', num2str(std(bin_3))])




%%

% information on sig clusters in corr analysis

file = '/media/ubuntu/4TeraDrive/elections/results/clustersize_corection/only_ttest_sig_voxels';
current_files = dir(file);
string = 'ideology'; % either general / ingroup / ideology
current_files = current_files(contains({current_files.name}, string));

unsignificant_uncorrected = niftiread(fullfile(file, current_files(2).name));
uncorrected_but_above_005 = niftiread(fullfile(file, current_files(1).name));
sig_cluster_index = niftiread(fullfile(file, current_files(5).name));
sig_cluster_size = niftiread(fullfile(file, current_files(6).name));
corrected = niftiread(fullfile(file, current_files(8).name));

num_of_sig_vox = sum((corrected(:) ~= 0));
num_of_clusters = max(sig_cluster_index(:));
cluster_sizes_list = unique(sig_cluster_size(:));
smallest_cluster_size = cluster_sizes_list(2);
largest_cluster_size = max(cluster_sizes_list);
max_corr_value = max(corrected(:));
min_corr_value = unique(corrected(:));
min_corr_value = min_corr_value(2);

corrected = corrected(:);

mean_corr_value = mean(corrected(corrected ~= 0));
std_cor_value = std(corrected(corrected ~= 0));

disp(string)
disp(['num_of_sig_vox = ', num2str(num_of_sig_vox)])
disp(['num_of_clusters = ', num2str(num_of_clusters)])
disp(['smallest_cluster_size = ', num2str(smallest_cluster_size)])
disp(['largest_cluster_size = ', num2str(largest_cluster_size)])
disp(['max_corr_value = ', num2str(max_corr_value)])
disp(['min_corr_value = ', num2str(min_corr_value)])
disp(['mean_corr_value = ', num2str(mean_corr_value)])
disp(['std_cor_value = ', num2str(std_cor_value)])

%%
% create corr nifties that are sig but before FDR

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

% general
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/general/corr_general_full.mat')
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/general/pval_general_full.mat')
sig_general_befor_fdr = zeros(size(kept_vox_97332_of_902629));
corr_general_sig = corr_general_full;
corr_general_sig(pval_general_full > 0.05) = 0;
corr_general_sig(~kept_vox_24848_of_97332) = 0;
sig_general_befor_fdr(kept_vox_97332_of_902629) = corr_general_sig;
sum(corr_general_sig ~= 0)

save_file = '/media/ubuntu/4TeraDrive/elections/results/corr_sig_befor_fdr';

values_to_nifti(sig_general_befor_fdr, 2, '', save_file, 'sig_general_befor_fdr', false)

% ingroup
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ingroup/corr_ingroup_full.mat')
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ingroup/pval_ingroup_full.mat')
sig_ingroup_befor_fdr = zeros(size(kept_vox_97332_of_902629));
corr_ingroup_sig = corr_ingroup_full;
corr_ingroup_sig(pval_ingroup_full > 0.05) = 0;
corr_ingroup_sig(~kept_vox_24848_of_97332) = 0;
sig_ingroup_befor_fdr(kept_vox_97332_of_902629) = corr_ingroup_sig;
sum(corr_ingroup_sig ~= 0)

save_file = '/media/ubuntu/4TeraDrive/elections/results/corr_sig_befor_fdr';

values_to_nifti(sig_ingroup_befor_fdr, 2, '', save_file, 'sig_ingroup_befor_fdr', false)

% ideology
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ideology/corr_ideology_full.mat')
load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/correlation - pre fdr- pvalues and corr values/full grey matter/ideology/pval_ideology_full.mat')
sig_ideology_befor_fdr = zeros(size(kept_vox_97332_of_902629));
corr_ideology_sig = corr_ideology_full;
corr_ideology_sig(pval_ideology_full > 0.05) = 0;
corr_ideology_sig(~kept_vox_24848_of_97332) = 0;
sig_ideology_befor_fdr(kept_vox_97332_of_902629) = corr_ideology_sig;
sum(corr_ideology_sig ~= 0)

save_file = '/media/ubuntu/4TeraDrive/elections/results/corr_sig_befor_fdr';

values_to_nifti(sig_ideology_befor_fdr, 2, '', save_file, 'sig_ideology_befor_fdr', false)

















