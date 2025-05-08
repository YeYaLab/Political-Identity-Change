%% This function combines the subject data to a single matrix
% It is meant to be used following the CutAsKeptVox script, but can be
% adapted for use following the ZnormHrLockCutoff_Batch script, depending
% on memory capacities of the matlab.
% Parameters
% inputPath - path to the folder with all the functional files
% outputPath - path for the output to go
% outputName - the name to save the file as
% task - the specific task
% subNums - a vector of all subject's numbers
% taskTR - the TR of each task, corresponding to the task parameter
% numVox - the number of voxels in the data files

% Run example:
% generateCombinedMat('/path/to/func/files','output/goes/here','thisismyname','task',1:17,310,50000)

function generateCombinedMat(inputPath,outputPath,outputName,task,subNums,taskTR,numVox)
%dataMat_combined = zeros(numVox,taskTR,length(subNums));
  dataMat_combined = zeros(numVox,length(subNums),taskTR);
%generate funcnames
funcnames=cell(length(subNums),1);
    for subNum = 1:length(subNums)
        funcnames{subNum} = strcat(inputPath,'/sub_',num2str(subNums(subNum)),'_task_',task);
    end
    
%generate combined mat 
 for sid = 1:length(funcnames)
     load([funcnames{sid}]);
      data_lockedCut(data_lockedCut==0)=nan;
%      data_lockedCut = zscore(data_lockedCut,0,2);
%     dataMat_combined (:,:,sid) =  data_lockedCut;
    dataMat_combined (:,sid,:) =  data_lockedCut;
 end

 %zscore the data
%dataMat_all_nozero = dataMat_combined;
 dataMat_combined(dataMat_combined == 0)=nan; %replaced 0 with nan
% dataMat_combined_z_09 = zscore(dataMat_combined,0,3);
output = strcat(outputPath,'/',outputName,'_task_',task,'.mat');
save (output,'dataMat_combined','-v7.3'); %dataMat_combined_z_nameoftask_group'
%  dataMat_combined_z_09 = dataMat_combined_z(keptVox_both==1,:,:);
%  save ('dataMat_combined_z_bibiindictment_left_09','dataMat_combined_z_09','-v7.3'); %dataMat_combined_z_nameoftask_group_09'
% save ('dataMat_combined_z_neutral_right_09','dataMat_combined_z_09','-v7.3');




