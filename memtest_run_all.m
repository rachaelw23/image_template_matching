%% setup
clear; clc;
tic; %start timer

data_dir = '/Volumes/experiments2/Siobhan/L&R_StressReward_Update/MemTest/MemTest_Data/SetA/';
cues_dir = '/Users/Rachael/Documents/school/grad_school/first_year/adcock_rotation/memtest_score_test/data/testdir/cues/';

cd(data_dir);
subjects = dir(strcat(data_dir,'tes*'));
plat = imread(strcat(cues_dir,'platform.png')); %load platform template
center = imread(strcat(cues_dir,'maze.png')); %load maze template

data = []; 

%%
for i=1:(length(subjects))
    
    disp(subjects(i).name);
    cd(strcat(subjects(i).name));
    files = dir('Env*.PNG');

    for ii=1:length(files)
        j = strsplit(files(ii).name, '.');
        env = j{1};
        
        I = imread(files(ii).name);
        center_coordinates = find_objects(I,center);
        
        plat_coordinates = find_objects(I,plat);
        plat_coordinates(1) = plat_coordinates(1) - center_coordinates(1); %shift coordinates relative to center of maze
        plat_coordinates(2) = plat_coordinates(2) - center_coordinates(2);
        
        cues = dir(strcat(cues_dir,env,'/','c*.png'));
        for iii=1:length(cues)
            k = strsplit(cues(iii).name, '.');
            cue_name = k{1};
            
            object = imread(strcat(cues(iii).folder,'/',cues(iii).name));

            cue_coordinates = find_objects(I,object);
            cue_coordinates(1) = cue_coordinates(1) - center_coordinates(1); %shift coordinates relative to center of environment
            cue_coordinates(2) = cue_coordinates(2) - center_coordinates(2);

            dist = pdist2(plat_coordinates,cue_coordinates, 'euclidean'); %euclidean distance
            angle = atan2d(plat_coordinates(1)*cue_coordinates(2)-plat_coordinates(2)*cue_coordinates(1),plat_coordinates(1)*cue_coordinates(1)+plat_coordinates(2)*cue_coordinates(2)); %relative angle between platform and cue, atan2d(x1*y2-y1*x2,x1*x2+y1*y2)
           
            data = [data; {subjects(i).name}, {env}, {cue_name}, {cue_coordinates}, {plat_coordinates}, {dist}, {angle}];

            %run scoring function (not written yet)

        end
    end
cd('..');
end
toc; %stop timer