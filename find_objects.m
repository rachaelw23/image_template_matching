function [coordinates] = find_objects(I,object)
%I = image to search (memory test trial)
%object = what you are searching for (cues or platform)

    c = normxcorr2(object(:,:,1),I(:,:,1)); %2d cross-correlation between template and image, all color layers
    figure, surf(c), shading flat; %plot cross-correlation
    
%%
    if max(c(:)) > 0.8 %correlation threshold
        
        [ypeak, xpeak] = find(c==max(c(:))); %index location of peak correlation

        yoffSet = ypeak-size(object,1); %necessary to account for translational differences
        xoffSet = xpeak-size(object,2);

        figure
        imshowpair(I,object,'montage');

        figure
        imshow(I);
        hold on; axis on;
        imrect(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);
        %imellipse(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);

        %calculate center of object and plot
        x1 = xoffSet+1;
        y1 = yoffSet+1;

        x2 = xoffSet+1 + size(object,2);
        y2 = yoffSet+1 + size(object,1);

        xCenter = (x1 +x2)/2; %midpoint formula to find center
        yCenter = (y1 + y2)/2;

        plot(xCenter,yCenter,'*r');

    else
         xCenter = NaN;
         yCenter = NaN;
         
    end
     
    coordinates = [xCenter,yCenter];

end
