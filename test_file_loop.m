%% setup
clear; clc;
tic; %start timer

data_dir = '/Volumes/experiments2/Siobhan/L&R_StressReward_Update/MemTest/MemTest_Data/SetA/';
cues_dir = '/Users/Rachael/Documents/school/grad_school/first_year/adcock_rotation/memtest_score_test/data/testdir/cues/';

cd(data_dir);
subjects = dir(strcat(data_dir,'tes*'));
plat = imread(strcat(cues_dir,'platform.png')); %load platform template
center = imread(strcat(cues_dir,'maze3.png')); %load center of environment template (working: maze.png)

data = []; 

%%
for i=1:(length(subjects))
    
    disp(subjects(i).name);
    cd(strcat(subjects(i).name));
    files = dir('Env*.PNG');

    for ii=1:length(files)
        I = imread(files(ii).name);
        center_coordinates = find_objects(I,center);
        
        plat_coordinates = find_objects(I,plat);
        plat_coordinates(1) = plat_coordinates(1) - center_coordinates(1); %shift coordinates relative to center of environment
        plat_coordinates(2) = plat_coordinates(2) - center_coordinates(2);
        
        j = strsplit(files(ii).name, '.');
        env = j{1};

        cues = dir(strcat(cues_dir,env,'/','c*.png'));

        for iii=1:length(cues)
            object = imread(strcat(cues(iii).folder,'/',cues(iii).name));

            cue_coordinates = find_objects(I,object);
            cue_coordinates(1) = cue_coordinates(1) - center_coordinates(1); %shift coordinates relative to center of environment
            cue_coordinates(2) = cue_coordinates(2) - center_coordinates(2);

            dist = pdist2(plat_coordinates,cue_coordinates, 'euclidean'); %euclidean distance
            %cos = 1 - (pdist2(plat_coordinates,cue_coordinates,'cosine')); %pdist2 outputs cosine distance; 1-cosine_similarity = cosine distance
            a = atan2d(plat_coordinates(1)*cue_coordinates(2)-plat_coordinates(2)*cue_coordinates(1),plat_coordinates(1)*cue_coordinates(1)+plat_coordinates(2)*cue_coordinates(2));
           
            k = strsplit(cues(iii).name, '.');
            cue_name = k{1};

            data = [data; {files(ii).name} {subjects(i).name}, {env}, {cue_name}, {cue_coordinates}, {plat_coordinates}, {dist}, {a}];

            %run scoring function (not written yet)

        end
end

cd('..');

end

toc; %stop timer