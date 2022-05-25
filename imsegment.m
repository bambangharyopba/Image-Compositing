function [segment, bb] = imsegment(IRef, I, threshold)
    imdiff = abs(double(I) - double(IRef));
    mask = imdiff > threshold;
    mask = any(mask, 3);
    mask = all(mask, 3);

    props = regionprops(mask,'Area','BoundingBox');
    [~, idx] = sort([props.Area], 'descend');
    props = props(idx);

    bb = props(1).BoundingBox;
    cI = imcrop(I, bb);
    e = edge(imgaussfilt(rgb2gray(cI),5), 'canny');
    e = bwmorph(e, 'bridge');
    
    se = strel('disk', 8);
    e = imdilate(e, se);
    e = imfill(e, 'holes');

    figure, imshow(e);

    segment = cI;
    mask = cat(3, e, e, e);
    segment(~mask) = 255;
    figure,imshow(segment);
end