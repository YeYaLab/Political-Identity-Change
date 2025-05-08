function [nullDist_ED, nullDist_TR] = generate_nullDist_of_euc_dist(data_scrambled,data_real,number_of_scrambles, save_name)
%data_scrambled and data_real should be two 3d size matrices in this order:
%voxXsubXTR
%now i'm going to permute the one matrix i chose to scramble, and it is
%going to be trxsubxvox
tic
data_scrambled = permute(data_scrambled, [3 2 1]); %notice it's trsxsubxvox
%this is where i create a zeros matrix in the size of one the matrices (voxXsubXnumber of scrambles):
nullDist_ED = zeros(size(data_real,1),size(data_real,2),number_of_scrambles);
nullDist_TR = zeros(size(data_real,1),size(data_real,2),number_of_scrambles);
% nullDist_nasa = zeros(size(data_real,1),size(data_real,2),number_of_scrambles);

%the code is scrambling the data as many times as we told him:
for it = 1:number_of_scrambles
    disp(it);
    %first it is scrambling, then it is permute the matrix to the original
    %dimenstions (voxXsubXtrs), and then it is performing a euclidean
    %distance on the new permute data).
      randNIfft_mat = real(phase_shuf_group_data(data_scrambled));
      randNIfft_mat = permute(randNIfft_mat, [3 2 1]); 
      
      nullDist_ED(:,:,it) = find_euc_dis(randNIfft_mat,data_real);
      nullDist_TR(:, :, it) = find_TR_corr(randNIfft_mat,data_real);

      
end

outputPath = 'C:\Users\User\Desktop\elections2019\Analysis\null dist';
fileNameED = fullfile(outputPath,['nulldistED', save_name]);
save(fileNameED,'nullDist_ED');
fileNameTR = fullfile(outputPath,['nulldistTR', save_name]);
save(fileNameTR,'nullDist_TR');

toc
end

