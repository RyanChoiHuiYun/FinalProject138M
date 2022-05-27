% unzip the images and store them in corresponding folders
mkdir("data\faces\neutral");
mkdir("data\faces\angry");
unzip("data\faces\neutral.zip", "data\faces\neutral");
unzip("data\faces\angry.zip", "data\faces\angry");

% remove and delete all images and folders created for the script
rmdir("data\faces\angry", 's');
rmdir("data\faces\neutral", 's');