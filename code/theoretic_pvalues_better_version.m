% this function calculates the theoretic p-value based on the normal
% distribution, that is based on the null distribution.
% recomended to follow the function 'ABC_RSA_for_cluster'.


function [theoretic_pvalues] = theoretic_pvalues_better_version(nulldist, real_values)

    if size(nulldist, 1) ~= size(real_values)
        error('The number of voxels must be the same in both the nulldist matrix (in the first dimention) and the real_values.');
    end
   
    theoretic_pvalues = zeros(size(nulldist, 1), 1);
        
    for vox = 1:size(nulldist,1)
        [mu,sigma] = normfit(nulldist(vox, :));
        p = normcdf(real_values(vox),mu,sigma);
        theoretic_pvalues(vox) = p;
    end
    
    theoretic_pvalues = (1 - theoretic_pvalues);

end