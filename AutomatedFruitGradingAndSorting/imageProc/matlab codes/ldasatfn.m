function [ index ] = ldasatfn(I, am1,bm1,cm1,dm1,em1 )
% Function to classify into one of the classes using LDA

%test sample
i = fruitfilter(I);
hsvt = rgb2hsv(i);
ht = hsvt(:,:,2);
ht = ht*255;
ht = nonzeros(ht);
%tmean1
t = mean2(ht);

group = [ones(length(am1),1); (ones(length(bm1),1)*2); (ones(length(cm1),1)*3);(ones(length(dm1),1)*4);(ones(length(em1),1)*5)];
index = classify(t ,[am1'; bm1'; cm1'; dm1'; em1'],group);
 
% index = mode(class);

if index == 1
    disp('Sample belongs to class A of oranges');
elseif index == 2
    disp('Sample belongs to class B of oranges');
elseif index == 3
    disp('Sample belongs to class C of oranges');
elseif index == 4
    disp('Sample belongs to class of Sweet Lime');
elseif index == 5
    disp('Sample belongs to class of Lemon');
end


end

% I = imread('D:\Matlab files\LDA\Samples\39e.bmp');
% classifyfn(I,am1,bm1,cm1,dm1,em1);