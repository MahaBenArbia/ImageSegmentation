function J=otsu(img)
%imshow(img);
x=im2double(img);
T=graythresh(x);
J=im2bw(img,T);
%figure;
%imshow(y)