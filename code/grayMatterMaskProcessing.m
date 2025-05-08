%load the old 220,000~ keptvox and the segmented mask
load('Y:\Teams&Projects\Elections2019\SubsMatCrop\CutOff_3000\all_keptvox_ses01+03\unified_keptVox.mat')
GM = niftiread('Y:\brain masks\MNI152_T1_2mm_Brain_FAST_seg.nii.gz');
%reshape the segmented mask so it will be one long vector(comparing to the
%3d matrix it has been as a brain mask) and it will contain only 1 for gray
%matter and 0 for white/CSF
% GM_reshape = GM(:);
% GM_reshape_onlyones_realreshape = reshape(GM,902629,1);
GM_reshape_onlyones = GM(:);
GM_reshape_talis_method = logical(GM_reshape_onlyones == 2);
%my method for doing it - a bit long and time consuming (for loop...) so it
%is not recommended: 
% for vox = 1:902629
% if GM_reshape_onlyones(vox,:) == 2
%     GM_reshape_onlyones(vox,:) = 1;
% else
%     GM_reshape_onlyones(vox,:) = 0;
% end
% end
% GM_reshape_onlyones_logical = logical(GM_reshape_onlyones);

%creating new keptVox consists only of gray matter places:
GM_and_KeptVox_compare = plus(GM_reshape_talis_method,unified_keptVox_ideology_ingroup_only_yamin_likud_neutral);
GM_and_KeptVox_compare_talis_method = logical(GM_and_KeptVox_compare == 2);

%my method for doing it - a bit long and time consuming (for loop...) so it
%is not recommended: 
% for vox = 1:902629
% if GM_and_KeptVox_compare(vox,:) == 2
%     GM_and_KeptVox_compare(vox,:) = 1;
% else
%     GM_and_KeptVox_compare(vox,:) = 0;
% end
% end
% sum(GM_and_KeptVox_compare);
%https://github.com/Jfortin1/MNITemplate

%specifically for the 100 clusters - the 100 clusters is based on the
%200000~ original keptVox, so we transformed it to include only the gray
%matter areas voxels
GM_reshape_adjusted_to_unified_keptvox = GM_reshape_onlyones(unified_keptVox_ideology_ingroup_only_yamin_likud_neutral);
GM_reshape_adjusted_to_unified_keptvox_GM = logical(GM_reshape_adjusted_to_unified_keptvox == 2);
Combined_task_bibiindictment_ses01_only_GM = Combined_task_bibiindictment_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_gantzlapid_ses01_only_GM = Combined_task_gantzlapid_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_likud_ses01_only_GM = dataMat_combined_likud_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_meretzavoda_ses01_only_GM = Combined_task_meretzavoda_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_neutral_ses01_only_GM = dataMat_combined_neutral_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_yaminhadash_ses01_only_GM = dataMat_combined_yaminhadash_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_shelirabin_ses01_only_GM = Combined_task_shelirabin_ses01(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);

Combined_task_bibiindictment_ses03_only_GM = Combined_task_bibiindictment_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_gantzlapid_ses03_only_GM = Combined_task_gantzlapid_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_likud_ses03_only_GM = dataMat_combined_likud_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_meretzavoda_ses03_only_GM = Combined_task_meretzavoda_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_neutral_ses03_only_GM = dataMat_combined_neutral_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
dataMat_combined_yaminhadash_ses03_only_GM = dataMat_combined_yaminhadash_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);
Combined_task_shelirabin_ses03_only_GM = Combined_task_shelirabin_ses03(GM_reshape_adjusted_to_unified_keptvox_GM, :, :);

save('dataMat_combined_neutral_ses03_only_GM','dataMat_combined_neutral_ses03_only_GM','-v7.3');
save('dataMat_combined_likud_ses03_only_GM','dataMat_combined_likud_ses03_only_GM','-v7.3');
save('dataMat_combined_yaminhadash_ses03_only_GM','dataMat_combined_yaminhadash_ses03_only_GM','-v7.3');