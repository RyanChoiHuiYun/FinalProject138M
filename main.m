
% start of region
% ---------------
%%%%%%%%%%%%%%%
% Preparation % 
%%%%%%%%%%%%%%%
% STIMULI - images
% unzip the images and store them in corresponding folders
mkdir("stimuli\faces\neutral");
addpath("stimuli\faces\neutral");
mkdir("stimuli\faces\angry");
addpath("stimuli\faces\angry");
unzip("stimuli\faces\neutral.zip", "stimuli\faces\neutral");
unzip("stimuli\faces\angry.zip", "stimuli\faces\angry");
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
% TODO
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
trial_matrix = [];
column_names = {'trial_num', 'cond_face', 'cond_word', 'response', 'rt', 'accuracy'};
% 24 trials in total
for i = 1:24
    % neutral
    if s(i) <= 12
        disp("displaying face...");
        figure;
        img = imread(n(1).name);
        imshow(img);
        pause(0.5);
        close("all");
        n(1) = [];
        % words
        if k(i) <= 12
            str = wordlist_r{word_counter};
            word_counter = word_counter + 1;
        else
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
                resp = 1; %F = word = 1
                valid_key = 1;
            elseif b == 106 %J = nonword = 0
                resp = 0;
                valid_key = 1;
            end        
        end
        rt = toc;
        delete(t1);
    % angry
    else
        % displaying the face
        disp("displaying face...");
        figure;
        img = imread(a(1).name);
        imshow(img);
        pause(0.5);
        close("all");
        a(1) = [];
        % words
        if k(i) <= 12
            str = wordlist_r{word_counter};
            word_counter = word_counter + 1;
        else
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
                resp = 1; %F = word = 1
                valid_key = 1;
            elseif b == 106 %J = nonword = 0
                resp = 0;
                valid_key = 1;
            end        
        end
        rt = toc;
        delete(t1);
    end
    % Collect data and save them in trial_matrix
    % TODO
end


% remove and delete all images and folders created for the script
rmdir("stimuli\faces\angry", 's');
rmdir("stimuli\faces\neutral", 's');