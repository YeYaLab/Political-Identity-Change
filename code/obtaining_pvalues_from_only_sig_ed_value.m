[pcrit_general_regular_p, sigvals_general_regular_p, sigindx_general_regular_p] = fdr_BH(pval_corr_general_vec_and_ED, 0.05)
[pcrit_general_no_neutral_regular_p, sigvals_general_no_neutral_regular_p, sigindx_general_no_neutral_regular_p] = fdr_BH(pval_corr_general_vec_and_ED_no_neutral, 0.05)
[pcrit_ideology_regular_p, sigvals_ideology_regular_p, sigindx_ideology_regular_p] = fdr_BH(pval_corr_ideology_vec_and_ED, 0.05)
[pcrit_ideology_no_neutral_regular_p, sigvals_ideology_no_neutral_regular_p, sigindx_ideology_no_neutral_regular_p] = fdr_BH(pval_corr_ideology_vec_and_ED_no_neutral, 0.05)
[pcrit_ingroup_regular_p, sigvals_ingroup_regular_p, sigindx_ingroup_regular_p] = fdr_BH(pval_corr_ingroup_vec_and_ED, 0.05)
[pcrit_ingroup_no_neutral_regular_p, sigvalst_ingroup_no_neutral_regular_p, sigindx_ingroup_no_neutral_regular_p] = fdr_BH(pval_corr_ingroup_vec_and_ED_no_neutral, 0.05)


[theoretic_pvalues_general] = theoretic_pvalues_better_version_two_tails(null_mat_sig, corr_general_vec_and_ED);

[pcrit_general_nullmat, sigvals_general_nullmat, sigindx_general_nullmat] = fdr_BH(theoretic_pvalues_general, 0.05);


[theoretic_pvalues_ideology] = theoretic_pvalues_better_version_two_tails(null_ideology_mat_sig, corr_ideology_vec_and_ED);

[pcrit_ideology_nullmat, sigvals_ideology_nullmat, sigindx_ideology_nullmat] = fdr_BH(theoretic_pvalues_ideology, 0.05);


[theoretic_pvalues_ingroup] = theoretic_pvalues_better_version_two_tails(null_ingroup_mat_sig, corr_ingroup_vec_and_ED);

[pcrit_ingroup_nullmat, sigvals_ingroup_nullmat, sigindx_ingroup_nullmat] = fdr_BH(theoretic_pvalues_ingroup, 0.05);





[theoretic_pvalues_general] = theoretic_pvalues_better_version_two_tails(null_mat_sig, corr_general_vec_and_ED);

[pcrit_general_nullmat, sigvals_general_nullmat, sigindx_general_nullmat] = fdr_BH(theoretic_pvalues_general, 0.05);


[theoretic_pvalues_ideology] = theoretic_pvalues_better_version_two_tails(null_ideology_mat_sig, corr_ideology_vec_and_ED);

[pcrit_ideology_nullmat, sigvals_ideology_nullmat, sigindx_ideology_nullmat] = fdr_BH(theoretic_pvalues_ideology, 0.05);


[theoretic_pvalues_ingroup] = theoretic_pvalues_better_version_two_tails(null_ingroup_mat_sig, corr_ingroup_vec_and_ED);

[pcrit_ingroup_nullmat, sigvals_ingroup_nullmat, sigindx_ingroup_nullmat] = fdr_BH(theoretic_pvalues_ingroup, 0.05);



[theoretic_pvalues_general_no_neutral] = theoretic_pvalues_better_version_two_tails(null_mat_sig, corr_general_vec_and_ED_no_neutral);

[pcrit_general_nullmat_no_neutral, sigvals_general_nullmat_no_neutral, sigindx_general_nullmat_no_neutral] = fdr_BH(theoretic_pvalues_general_no_neutral, 0.05);


[theoretic_pvalues_ideology_no_neutral] = theoretic_pvalues_better_version_two_tails(null_ideology_mat_sig, corr_ideology_and_ED_no_neutral);

[pcrit_ideology_nullmat_no_neutral, sigvals_ideology_nullmat_no_neutral, sigindx_ideology_nullmat_no_neutral] = fdr_BH(theoretic_pvalues_ideology_no_neutral, 0.05);


[theoretic_pvalues_ingroup_no_neutral] = theoretic_pvalues_better_version_two_tails(null_ingroup_mat_sig, corr_ingroup_and_ED_no_neutral);

[pcrit_ingroup_nullmat_no_neutral, sigvals_ingroup_nullmat_no_neutral, sigindx_ingroup_nullmat_no_neutral] = fdr_BH(theoretic_pvalues_ingroup_no_neutral, 0.05);




corr_general_vec_and_ED_no_neutral(sigindx_general_no_neutral_regular_p == 0) = 0;
corr_ingroup_and_ED_no_neutral(sigindx_ingroup_no_neutral_regular_p == 0) = 0;

corr_general_vec_and_ED_nullmat_pval(sigindx_general_nullmat == 0) = 0;
corr_ideology_and_ED_nullmat_pval(sigindx_ideology_nullmat == 0) = 0;
corr_ingroup_and_ED_nullmat_pval(sigindx_ingroup_nullmat == 0) = 0;

corr_general_vec_and_ED_no_neutral_nullmat_pval(sigindx_general_nullmat_no_neutral == 0) = 0;
corr_ideology_and_ED_no_neutral_nullmat_pval_final(sigindx_ideology_nullmat_no_neutral == 0) = 0;
corr_ingroup_and_ED_no_neutral_nullmat_pval(sigindx_ingroup_nullmat_no_neutral == 0) = 0;

