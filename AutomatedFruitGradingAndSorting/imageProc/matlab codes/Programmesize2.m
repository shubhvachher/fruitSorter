I = imread('D:\matlab files\images\2B.bmp');
gray = rgb2gray(I);
bw = im2bw(gray, 0.13);
%bw = im2bw(gray, graythresh(gray));
cont = Contourfn(bw);
%centroid using inbuilt function
c1 = regionprops(cont,'centroid');
c1 = c1.Centroid;
%centroid using formula
c2 = Centroidfn(cont);
%diameter using formula with both centroids as input
d1 = Diameterfn(cont,c1);
d2 = Diameterfn(cont,c2);
%contour points
[a b]= find(a1 ==1);
contpoints = [b a];
%diameter through total area
totarea = 0;
for i = 1:size(bw)
    for j = 1:size(bw)
        if(bw(i,j)==1)
            totarea = totarea + 1;
        end
    end
end
diamarea = totarea*4 /pi
diamarea = nthroot(diamarea,2);
%diameter through perimeter
perimeter = regionprops(cont, 'perimeter');
diamperi = perimeter.Perimeter(1)/pi;



