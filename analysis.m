% load all .mat files from output
fnames = dir("output/*.mat");
for i = 1:length(fnames)
    load("output/"+fnames(i).name);

    %Computing the mean response time for each condition
    meanRT_cond1(i) = mean(trial_matrix(trial_matrix(:,2)==1,3));
    meanRT_cond0(i) = mean(trial_matrix(trial_matrix(:,2)==0,3));
end

%Runnning and outputting the results of a two-sample ttest
[h,p,ci,stat] = ttest(meanRT_cond1, meanRT_cond0)
