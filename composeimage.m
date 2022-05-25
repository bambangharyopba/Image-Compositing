function I = composeimage(IRef, Is, thresholds)
    [~, N] = size(Is);
    
    segments = cell(N);
    bbs = cell(N);
    
    for i=1:N
        [segments{i}, bbs{i}] = imsegment(IRef, Is{i}, thresholds{i});
    end
    
    I = IRef;
    
    for i=1:N
        shsv = rgb2hsv(segments{i});
        mask = shsv(:,:,3).*(1-shsv(:,:,2))>0.9;
        mask = imadjust(imgaussfilt(im2double(mask),3),[0 0.5]);
        
        s = size(segments{i});
        xrange = ceil(bbs{i}(1)) + (1:s(2)) - 1;
        yrange = ceil(bbs{i}(2)) + (1:s(1)) - 1;
        I(yrange,xrange,:) = im2uint8(im2double(segments{i}).*(1-mask) + im2double(I(yrange,xrange,:)).*mask);
    end
end