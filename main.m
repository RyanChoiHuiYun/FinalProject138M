% Ryan Cai
% xcai30@ucsc.edu

% PSYC 138P Final Project: Lexical Decision Task with Primed Faces

% start of region
% ---------------
%%%%%%%%%%%%%%%
% Preparation % 
%%%%%%%%%%%%%%%
% STIMULI - images
% unzip the images and store them in corresponding folders
fprintf("Loading necessary stimuli and creating folders...\n");
mkdir("stimuli\faces\neutral");
addpath("stimuli\faces\neutral");
mkdir("stimuli\faces\angry");
addpath("stimuli\faces\angry");
unzip("stimuli\faces\neutral.zip", "stimuli\faces\neutral");
unzip("stimuli\faces\angry.zip", "stimuli\faces\angry");
fprintf("\nDone.\n");
pause(0.5);
% randomize choice from neutral or angry
s = 1:24;
s = s(randperm(length(s)));
% randomize neutral order
n = dir("stimuli\faces\neutral");
n(1) = [];
n(1) = [];
n = n(randperm(length(n)));
% randomize angry order
a = dir("stimuli\faces\angry");
a(1) = [];
a(1) = [];
a = a(randperm(length(a)));
scale = [400, 400];
% STIMULI - words
% load the words
load("stimuli\words\words.mat");
% randomize choice from words or non-words
k = 1:24;
k = k(randperm(length(k)));
% randomzie words and non-words list
wordlist_r = wordlist(randperm(12));
nonwordlist_r = nonwordlist(randperm(12));
% -------------
% end of region

% start of region
% ---------------
%%%%%%%%%%%%%%%% 
% Instructions %
%%%%%%%%%%%%%%%%
initials = input('Please enter your initials: ', 's'); 
output_file = ['lexical_data_' initials '.mat' ];
pause(0.5);
clc;
fprintf("Welcome to the lexical decision task with primed faces." + ...
    "\nIn each trial, a random neutral or angry face will be briefly shown " + ...
    "before prompting a word or a non-word for you to answer." + ...
    "\nPlease press F for words, J for non-words." + ...
    "\nPress C if you want to end the trial." + ...
    "\nMake your response as fast and as accurate as you can.\n" + ...
    "Good luck!\n");
pause(0.5);
input("Please press enter to start...");
% end of region
% -------------

% start of region
% ---------------
%%%%%%%%%%%%%
% MAIN LOOP %
%%%%%%%%%%%%%
% counter to loop through word list
word_counter = 1;
nonword_counter = 1;
% matrix to collect data
trial_matrix = zeros(24, 6);
column_names = {'trial_num', 'cond_face', 'cond_word', 'response', 'rt', 'accuracy'};
% 24 trials in total
for i = 1:24
    % neutral
    if s(i) <= 12
        cond_face = 0;
        figure;
        img = imread(n(1).name);
        img = imresize(img, scale);
        imshow(img);
        pause(0.25);
        close("all");
        n(1) = [];
        % words
        if k(i) <= 12
            cond_word = 1;
            str = wordlist_r{word_counter};
            word_counter = word_counter + 1;
        else
            cond_word = 0;
            str = nonwordlist_r{nonword_counter};
            nonword_counter = nonword_counter + 1;
        end
        figure(1); clf;
        axis([0 10 0 10]);
        t1 = text(5, 5, str, 'fontsize',24, 'HorizontalAlignment','center');
        tic;
        valid_key = 0;
        while valid_key == 0
            [x, y, b] = ginput(1);
            if b == 102
                resp = 1; % F = word = 1
                valid_key = 1;
            elseif b == 106 % J = nonword = 0
                resp = 0;
                valid_key = 1;
            elseif b == 99  % C = break
                resp = 2;
                valid_key = 1;
            end        
        end
        rt = toc;
        delete(t1);
    % angry
    else
        % displaying the face
        cond_face = 1;
        figure;
        img = imread(a(1).name);
        img = imresize(img, scale);
        imshow(img);
        pause(0.25);
        close("all");
        a(1) = [];
        % words
        if k(i) <= 12
            cond_word = 1;
            str = wordlist_r{word_counter};
            word_counter = word_counter + 1;
        else
            cond_word = 0;
            str = nonwordlist_r{nonword_counter};
            nonword_counter = nonword_counter + 1;
        end
        figure(1); clf;
        axis([0 10 0 10]);
        t1 = text(5, 5, str, 'fontsize',24, 'HorizontalAlignment','center');
        tic;
        valid_key = 0;
        while valid_key == 0
            [x, y, b] = ginput(1);
            if b == 102
                resp = 1; % F = word = 1
                valid_key = 1;
            elseif b == 106 % J = nonword = 0
                resp = 0;
                valid_key = 1;
            elseif b == 99  % C = break
                resp = 2;
                valid_key = 1;
            end        
        end
        rt = toc;
        delete(t1);
    end
    if resp == 2
        break
    end
    % Collect data and save them in trial_matrix
    trial_matrix(i, 1) = i;
    trial_matrix(i, 2) = cond_face;
    trial_matrix(i, 3) = cond_word;
    trial_matrix(i, 4) = resp;
    trial_matrix(i, 5) = rt;
    trial_matrix(i, 6) = cond_word == resp;
    % Save output to the file
    save("output/"+output_file, "trial_matrix", "column_names");
    pause(1);

end
close("all");
fprintf("Thank you for your participation.\nGoodbye!");
% end of region
% -------------

% start of region
% ---------------
%%%%%%%%%%%%%%
% Conclusion %
%%%%%%%%%%%%%%
% remove and delete all images and folders created for the script
fprintf("Deleting necessary stimuli and folders...\n");
rmdir("stimuli\faces\angry", 's');
rmdir("stimuli\faces\neutral", 's');
fprintf("\nDone.\n");
% end of region
% -------------

% start of region
% ---------------
%%%%%%%%%%%%
% Analysis %
%%%%%%%%%%%%
% load(output_file);
% TODO
% s = 01;
% 
% fnames = dir(['motion2_task_' num2str(s) '_*']);
% 
% TabA = table(); % TabA : table for all blocks
% 
% for b = 1:size(fnames)
% 
%     load(fnames(b).name);
%     %TabS : table for single block
%     TabS = table(repmat(dat.block,dat.ntrials,1),dat.motionCoh',dat. motionDir', dat.acc', dat.conf',dat.resp',dat.rtchoice', dat.rtconf','VariableNames', {'block','motionCoherence','motionDirection','accuracy','confidence','directionDetected','RTchoice','RTconfidence'}); %RT: reaction time
%     TabA = [TabA; TabS];
%     save(['motion2_task_' num2str(s) '.mat'],'TabA');
% end
%
%
% end of region
% -------------
