function [coordinates] = find_objects(I,object)
%I = image to search in (memory test trial)
%object = what you are searching for (cues or platform)
%coordinates = center point (x,y) for object, units = pixels

    angles = [ 90, 180, 270 ];

    c = normxcorr2(object(:,:,1),I(:,:,1)); %2d cross-correlation between template and image, all color layers
    
    xCenter = NaN; %defaults to NaN if no object detected
    yCenter = NaN;
 
    if max(c(:)) > 0.8 %correlation threshold
        
        [ypeak, xpeak] = find(c==max(c(:))); %index location of peak correlation

        yoffSet = ypeak-size(object,1); %necessary to account for translational differences
        xoffSet = xpeak-size(object,2);
        
        %calculate center of object (midpoint formula)
        x1 = xoffSet+1;
        y1 = yoffSet+1;
        x2 = xoffSet+1 + size(object,2);
        y2 = yoffSet+1 + size(object,1);
        
        xCenter = (x1 +x2)/2;
        yCenter = (y1 + y2)/2;
        
%       %plotting (optional)
%         figure
%         imshowpair(I,object,'montage');
% 
%         figure, surf(c), shading flat; %plot cross-correlation
% 
%         figure
%         imshow(I);
%         hold on; axis on;
%         imrect(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);
%         %imellipse(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);
%         plot(xCenter_pix,yCenter_pix,'*r'); %plot center

elseif max(c(:)) < 0.8 %if image not found, check different rotations
        for i=1:length(angles)
            object_rot = imrotate(object,angles(i));
            
            c = normxcorr2(object_rot(:,:,1),I(:,:,1)); 
 
            if max(c(:)) > 0.8 %correlation threshold for this rotation
        
                [ypeak, xpeak] = find(c==max(c(:))); 

                yoffSet = ypeak-size(object_rot,1); 
                xoffSet = xpeak-size(object_rot,2);
        
                %calculate center of object (midpoint formula)
                x1 = xoffSet+1;
                y1 = yoffSet+1;
                x2 = xoffSet+1 + size(object_rot,2);
                y2 = yoffSet+1 + size(object_rot,1);
                
                xCenter = (x1 +x2)/2;
                yCenter = (y1 + y2)/2;

                % plotting (optional)
%                 figure
%                 imshowpair(I,object_rot,'montage');
% 
%                 figure, surf(c), shading flat; %plot cross-correlation
% 
%                 figure
%                 imshow(I);
%                 hold on; axis on;
%                 imrect(gca, [xoffSet+1, yoffSet+1, size(object_rot,2), size(object_rot,1)]);
%                 %imellipse(gca, [xoffSet+1, yoffSet+1, size(object,2), size(object,1)]);
%                 plot(xCenter_pix,yCenter_pix,'*r'); %plot center
            end
        end  
    end
    coordinates = [xCenter,yCenter];
end
