clear; clc;
cd '/Users/Rachael/Documents/school/grad_school/first_year/adcock_rotation/memtest_score_test/data/'

%for each environment in list, get platform coordinates, loop through cues
%get cue coordinates, compare to platform calculate distance and cos
%similarity
% files = ('Env*.pptx*.png');
% for file = files;
    I = imread('Env5.pptx_fullslide_cropped.png');
    object = imread('Picture6_new.png');

    c = normxcorr2(object(:,:,1),I(:,:,1)); %2d cross-correlation between template and image, all color layers
    figure, surf(c), shading flat; %plot cross-correlation

    [ypeak, xpeak] = find(c==max(c(:)));

%%
    if max(c(:)) > 0.8 %correlation threshold

        yoffSet = ypeak-size(object,1); %necessary to account for translational differences
        xoffSet = xpeak-size(object,2);

        figure
        imshowpair(I,object,'montage');

        figure
        imshow(I);
        hold on; axis on;
        %imrect(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);
        imellipse(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);

        %calculate center of object and plot
        x1 = xoffSet+1;
        y1 = yoffSet+1;

        x2 = xoffSet+1 + size(object,2);
        y2 = yoffSet+1 + size(object,1);

        xCenter = (x1 +x2)/2; %midpoint formula to find center
        yCenter = (y1 + y2)/2;

        plot(xCenter,yCenter,'*r');

        coordinates = [xCenter,yCenter];

    else
         disp('object not found');
     end
     %%

%end
