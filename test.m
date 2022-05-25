%{
IRef = imread('img/floor-clean.jpg');
I1 = imread('img/floor-object1.jpg');
I2 = imread('img/floor-object2.jpg');
I3 = imread('img/floor-object3.jpg');
I4 = imread('img/floor-object4.jpg');

I = {I1, I2, I3, I4};
thresholds = {45, 45, 45, 45};
%}
IRef = imread('img/sofa2-clean.jpg');
I1 = imread('img/sofa2-human1.jpg');
I2 = imread('img/sofa2-human2.jpg');

I = {I1, I2};
thresholds = {45, 45};

out = composeimage(IRef, I, thresholds);

figure,
imshow(out);