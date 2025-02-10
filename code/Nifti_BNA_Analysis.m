function summaryGyrusTable = Nifti_BNA_Analysis(NiftiFilePath,outputName, only_grey_matter, atlasPath,atlasVecPath)
% Yohay's Code
% Analayze Nifti results based on the Brainnetome 246 subregions atlas.
% Get data about based regions and networks as defined in the atlas.
%
% INPUT:
% (1) NiftiFilePath - char or string. Full path to a Nifti input file.
% (2) atlasPath - char or string. Full path to the MATLAB file that contains a
% MATLAB table with Brainnetome subregions division. This was a created
% based on the original repo https://github.com/brainnetome/atlas
% and was adujsted specificially for that purpose.
% (5) atlasVecPath - char or string. Path to vector mapping the Nifti file
% to the atlas.
% (4) outputName - the function produces an excel table with the results.
% Specifiy the full path to the results file.
%
% EXAMPLE:
% NiftiFilePath = "Z:\ActiveProjects\Yohay\AnalysisResults\classification\linear_ISC\voxels_above_ISC\ISC_SVM\Nifti\clustersMaps\corrected\Religious_Secular_SVM_ISC_acc_ClustersCorrected_hammetz_0_size_excluded_top99_3556_percentile.nii";
% atlasPath = "Z:\ActiveProjects\Yohay\AnalysisCode\Atlases_Parcellation\Brainnetome_246\NB_atlas_FSL\BNA_subregions_YZ.";
% atlasVecPath = "Z:\ActiveProjects\Yohay\AnalysisCode\Atlases_Parcellation\Brainnetome_246\BN_atlas_vector";
% outputName = "Z:\ActiveProjects\Yohay\AnalysisResults\classification\linear_ISC\voxels_above_ISC\ISC_SVM\Nifti\clustersMaps\corrected\metaData\exampleFile";
% YZ, June 2024

if nargin == 3
    atlasPath = "/mnt/backup2/ActiveProjects/Yohay/AnalysisCode/Atlases_Parcellation/Brainnetome_246/NB_atlas_FSL/BNA_subregions_YZ.";
    atlasVecPath = "/mnt/backup2/ActiveProjects/Yohay/AnalysisCode/Atlases_Parcellation/Brainnetome_246/BN_atlas_vector";
end

% load atlas
BN_t = load(atlasPath).BNAsubregionsYZ;
BN_v = double(load(atlasVecPath).BN_atlas_vec);
% load Nifti file
data = niftiread(NiftiFilePath); data = data(:); data = data ~= 0;
data = data.*BN_v;
data_values = niftiread(NiftiFilePath); data_values = data_values(:);

if only_grey_matter
    grey_matter = load('/mnt/backup2/Teams&Projects/Elections2019/SubsMatCrop/CutOff_3000/all_keptvox_ses01+03/unified_keptVox_grey_matter_only.mat');
    grey_matter = grey_matter.unified_keptVox_gray_matter_only;
    BN_v = BN_v.*grey_matter;
end

% Analyze
numRegions = height(BN_t);
voxelCountInData = zeros(numRegions, 1);
voxelCountInAtlas = zeros(numRegions, 1);
for i = 1:numRegions
    voxelCountInData(i) = sum(data == i);
    voxelCountInAtlas(i) = sum(BN_v == i);
end

% Add voxelCountInData to BN_t
BN_t.voxelCountInData = voxelCountInData;
BN_t.voxelCountInAtlas = voxelCountInAtlas;

% Get indices for each hemisphere
leftHemisphereInd = find(BN_t.Hemisphere=="Left");
rightHemisphereInd = find(BN_t.Hemisphere=="Right");

% Create summary table
uniqueGyrus = unique(BN_t.Gyrus_full);
summaryGyrus = cell(length(uniqueGyrus), 9);
for i = 1:length(uniqueGyrus)
    gyrus_ind = strfind(BN_t.Gyrus_full,uniqueGyrus(i));
    summaryGyrus{i, 1} = uniqueGyrus(i);

    % objective numbers:
    summaryGyrus{i, 2} = sum(BN_t.voxelCountInData(gyrus_ind));
    R_i = intersect(rightHemisphereInd,gyrus_ind);
    summaryGyrus{i, 3} = sum(BN_t.voxelCountInData(R_i));
    L_i = intersect(leftHemisphereInd, gyrus_ind);
    summaryGyrus{i, 4} = sum(BN_t.voxelCountInData(L_i));

    % percentages of gyri:
    summaryGyrus{i, 5} = 100*((sum(BN_t.voxelCountInData(gyrus_ind)))/(sum(BN_t.voxelCountInAtlas(gyrus_ind))));
    summaryGyrus{i, 6} = 100*((sum(BN_t.voxelCountInData(R_i)))/(sum(BN_t.voxelCountInAtlas(R_i))));
    summaryGyrus{i, 7} = 100*((sum(BN_t.voxelCountInData(L_i)))/(sum(BN_t.voxelCountInAtlas(L_i))));

    % maximum value
    data_values_in_gyri_R = data_values(ismember(BN_v, R_i));
    data_values_in_gyri_L = data_values(ismember(BN_v, L_i));
    data_values_in_gyri_R = data_values_in_gyri_R(data_values_in_gyri_R ~= 0);
    data_values_in_gyri_L = data_values_in_gyri_L(data_values_in_gyri_L ~= 0);
    summaryGyrus{i, 8} = max(data_values_in_gyri_R);
    summaryGyrus{i, 9} = max(data_values_in_gyri_L);
    summaryGyrus{i, 10} = mean(data_values_in_gyri_R);
    summaryGyrus{i, 11} = mean(data_values_in_gyri_L);
end
summaryGyrusTable = cell2table(summaryGyrus, 'VariableNames', {'Gyrus_full', 'VoxelCount', 'Right', 'Left', 'Voxel_%', 'Right_%', 'Left_%', 'max_right', 'max_left', 'mean_right', 'mean_left'});
% writetable(summaryGyrusTable, [outputName, '.csv']);

% Summarize by 7 networks
uniqueNetwork7 = unique(BN_t.networName_7);
summaryNetwork7 = cell(length(uniqueNetwork7), 4);
for i = 1:length(uniqueNetwork7)
    net_ind = strfind(BN_t.networName_7,uniqueNetwork7(i));
    summaryNetwork7{i, 1} = uniqueNetwork7(i);
    summaryNetwork7{i, 2} = sum(BN_t.voxelCountInData(net_ind));
    R_i = intersect(rightHemisphereInd,net_ind);
    summaryNetwork7{i, 3} = sum(BN_t.voxelCountInData(R_i));
    L_i = intersect(leftHemisphereInd, net_ind);
    summaryNetwork7{i, 4} = sum(BN_t.voxelCountInData(L_i));
end
summaryNetwork7Table = cell2table(summaryNetwork7, 'VariableNames', {'Network7', 'VoxelCount', 'Right', 'Left'});

% Summarize by 17 networks
uniqueNetwork17 = unique(BN_t.networName_17);
summaryNetwork17 = cell(length(uniqueNetwork17), 4);
for i = 1:length(uniqueNetwork17)
    net_ind = strfind(BN_t.networName_17,uniqueNetwork17(i));
    summaryNetwork17{i, 1} = uniqueNetwork17(i);
    summaryNetwork17{i, 2} = sum(BN_t.voxelCountInData(net_ind));
    R_i = intersect(rightHemisphereInd,net_ind);
    summaryNetwork17{i, 3} = sum(BN_t.voxelCountInData(R_i));
    L_i = intersect(leftHemisphereInd, net_ind);
    summaryNetwork17{i, 4} = sum(BN_t.voxelCountInData(L_i));
end
summaryNetwork17Table = cell2table(summaryNetwork17, 'VariableNames', {'Network7', 'VoxelCount', 'Right', 'Left'});

% % clusters:
% command = ['cluster --in=' NiftiFilePath ' --thresh=0.05'];
% [~, cluster_table] = system(command);
% 
% % Write to an Excel file
% mkdir([outputName]);
% writetable(BN_t, [outputName, '/numVoxPerRegion.csv']);
% writetable(summaryGyrusTable, [outputName, '/summaryGyri_with_percentiles_only_GM.csv']);
% writetable(summaryGyrusTable_onlyGM, [outputName, '/summaryGyri_with_percentiles_only_GM.csv']);
% writetable(summaryNetwork7Table, [outputName, '/summaryNetwork7.csv']);
% writetable(summaryNetwork17Table, [outputName, '/summaryNetwork17.csv']);
% writematrix(cluster_table,[outputName, '/cluster_table.csv'],'Delimiter',',');


end