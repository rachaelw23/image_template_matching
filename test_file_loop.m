% this will end up being the wrapper code
clear; clc;
cd '/Users/Rachael/Documents/school/grad_school/first_year/adcock_rotation/memtest_score_test/data/testdir/'

files = dir('Env*.PNG');
cues = dir('./cues/*.png');

platform_coordinates = []; %same comment as below
cue_coordinates = []; %do we even need this if all the calculations are done in the loop?
distances = [];
cosine = [];

for i=1:length(files)
    I = imread(files(i).name);
    object = imread('./platform/platform.png'); %only need to find the platform once per environment
    
    coordinates1 = find_objects(I,object);
    platform_coordinates = [platform_coordinates; {files(i).name}, {coordinates1}];
    
    for ii=1:length(cues)
        object = imread(strcat(cues(ii).folder,'/',cues(ii).name));
        
        coordinates2 = find_objects(I,object);
        cue_coordinates = [cue_coordinates; {files(i).name}, {coordinates2}];
        
       
        dist = pdist2(coordinates1,coordinates2); %eucledian distance
        distances = [distances; {files{i}.name}, {dist}];
        
        cos = pdist2(coordinates1,coordinates2,'cosine'); %cosine distance ... need to check this further
        cosine = [cosine; {files{i}.name}, {cos}];
        
        %run scoring function (not written yet)
    
    end
end