% this will end up being the wrapper code
clear; clc;
cd '/Users/Rachael/Documents/school/grad_school/first_year/adcock_rotation/memtest_score_test/data/'

files = dir('Env*.jpg');
cues = dir(%cue templates go here)
for file = files'
    I = imread(file.name);
    platform = imread(%platform template goes here);
    
    %find_objects but just for platform 
    
    for cue = cues'
        object = imread(cue.name);
        
        %run find_objects function
        
        %run scoring function (not written yet)
    
end
