% load all .mat files from output
fnames = dir("output/*.mat");
for i = 1:length(fnames)
    name = fnames(i).name;
    load("output/"+name);
    scatter_name = name(end-5:end-4);

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
    title("Lexical Data from "+scatter_name);
    xlabel("Trial Number");
    ylabel("Response Time");
end


%Computing the mean response time for each condition
total_neutral_avg = mean(meanRT_cond0);
total_angry_avg = mean(meanRT_cond1);
x = categorical({'neutral', 'angry'});
y = [total_neutral_avg; total_angry_avg];
figure;
b = bar(x,y);
b.FaceColor = 'flat';
b.CData(2,:) = [0 0 1];
b.CData(1,:) = [1 0 0];
title("average response time per condition");
xlabel("condition");
ylabel("response time (s)");

%Runnning and outputting the results of a two-sample ttest
[h,p,ci,stat] = ttest(meanRT_cond1, meanRT_cond0)
