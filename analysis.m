% load all .mat files from output
fnames = dir("output/*.mat");
for i = 1:length(fnames)
    load("output/"+fnames(i).name);
    name = fnames(i).name

    matrix(:,:,i) = trial_matrix;
    %Computing the mean response time for each condition
    meanRT_cond1(i) = mean(trial_matrix(trial_matrix(:,2)==1,3));
    meanRT_cond0(i) = mean(trial_matrix(trial_matrix(:,2)==0,3));

    cmap = zeros(24,3);
    for x = 1:length(trial_matrix)
        if trial_matrix(x,2) == 0
            cmap(x,:) = [0 0 1];
        else
            cmap(x,:) = [1 0 0];
        end
    end

    figure; 
    scatter(trial_matrix(:,1),trial_matrix(:,5), [], cmap)
    title(name);
    xlabel("Trial Number");
    ylabel("Response Time");
end


%Computing the mean response time for each condition

%Runnning and outputting the results of a two-sample ttest
[h,p,ci,stat] = ttest(meanRT_cond1, meanRT_cond0)
