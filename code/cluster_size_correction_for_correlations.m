function null_cluster_sizes = cluster_size_correction_for_correlations(actual_r_values, nulldist, percentile_sig, temporary_nifty_path)
% actual_r_values = vox*1
% nulldist = vox*number_of_itterations
% percentile_sig = between 0 and 100
% collective_kept_vox = the vector needed for converting actual_r_values to a nifti

[vox_num, itter_num] = size(nulldist);

if length(actual_r_values) ~= vox_num
    error("check input");
end

corr_threshold = prctile(actual_r_values, percentile_sig);

null_cluster_sizes = zeros(0,0);

% load the relevant "collective_kept_vox":
kept_vox_220394_of_902629 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox.mat');
kept_vox_220394_of_902629 = kept_vox_220394_of_902629.unified_keptVox;
kept_vox_97332_of_220394 = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/GM_reshape_adjusted_to_unified_keptvox_GM.mat');
kept_vox_97332_of_220394 = kept_vox_97332_of_220394.GM_reshape_adjusted_to_unified_keptvox_GM;
kept_vox_24848_of_97332 = load('/mnt/backup2/Teams&Projects/Elections2019/send to taly/fdr correction - euclidean distance political vs. neutral/sigindx_euc_dis.mat');
kept_vox_24848_of_97332 = kept_vox_24848_of_97332.(char(fieldnames(kept_vox_24848_of_97332)));

kept_vox_97332_of_902629 = kept_vox_220394_of_902629; % combining the two keptvox vectors
kept_vox_97332_of_902629(kept_vox_220394_of_902629) = kept_vox_97332_of_220394;
kept_vox_24848_of_902629 = kept_vox_97332_of_902629;
kept_vox_24848_of_902629(kept_vox_97332_of_902629) = kept_vox_24848_of_97332;

for itteration = 1:itter_num % 10 itterations in a second
    % tic;
    temporary_nifty_name = 'temporary_nifti';
    temp_file_name = fullfile(temporary_nifty_path, temporary_nifty_name);
    to_be_viewed = zeros(size(kept_vox_97332_of_902629));
    to_be_viewed(kept_vox_24848_of_902629) = nulldist(:, itteration); % change here to "kept_vox_97332_of_902629" depending on the size of nulldist input
    values_to_nifti(to_be_viewed, 2, kept_vox_97332_of_902629, temporary_nifty_path, temporary_nifty_name, false);
    command = ['cluster --in=', temp_file_name, ' --thresh=', num2str(corr_threshold)];
    [~,cmdout] = system(command);

    % cmdout to matrix:
    lines = splitlines(cmdout);
    numericDataString = strjoin(lines(2:end), '\n');
    dataMatrix = cell2mat(textscan(numericDataString, '%f %f %f %f %f %f %f %f %f'));
    null_cluster_sizes = [null_cluster_sizes; dataMatrix(:, 2)];
    % toc;

end