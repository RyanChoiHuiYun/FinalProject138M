% unzip the images and store them in corresponding folders
mkdir("neutral");
mkdir("angry");
unzip("neutral.zip", "neutral");
unzip("angry.zip", "angry");

% remove and delete all images and folders created for the script
rmdir("angry", 's');
rmdir("neutral", 's');