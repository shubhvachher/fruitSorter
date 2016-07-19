function [ diameter ] = DiamShapefn(cont1,centroid)

% finding diameter given centroid and image contour

[a b]= find(cont1 ==1);
cont = [b a];       %contour points

% x = size(cont);
% n = linspace(1,x,500);

for i = 1:size(cont,1)
    xk = cont(i,1);
    yk = cont(i,2);
    Rk(i,1) = hypot((xk - centroid(1)),(yk - centroid(2)));
end

diameter = R*2;

end

