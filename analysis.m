%Computing the mean response time for each condition
meanRT_cond1 = mean(trial_matrix(trial_matrix(:,2)==1,3));
meanRT_cond0 = mean(trial_matrix(trial_matrix(:,2)==0,3));

%Runnning and outputting the results of a two-sample ttest
[h,p,ci,stat] = ttest(meanRT_cond1, meanRT_cond0)
