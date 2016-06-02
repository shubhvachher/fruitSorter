function [ I ] = fruitfilter( I1 )
%UNTITLED2 Summary of this function goes here
%   To filter background

I = I1;
for i = 1:350
    for j = 1:1024
        if I(i,j,3) > 170
            I(i,j,1)=255;
            I(i,j,2)=255;
            I(i,j,3)=255;
        end
    end
end

end

