function [ centroid ] = Centroidfn( cont )

% to find centroid of a contour image
[a b]= find(cont ==1);
contpoints = [b a];
%input is contour points matrix

x = size(contpoints,1);
for i = 2:x
    xk = contpoints(i,1);
    xk1 = contpoints(i-1,1);
    yk = contpoints(i,2);
    yk1 = contpoints(i-1,2);
    
    xc1 = yk*(xk^2 -xk1^2) - (xk^2)*(yk - yk1);
    xyc2 = yk*(xk - xk1) - xk*(yk - yk1);
    yc1 = (yk^2)*(xk - xk1) - xk*(yk^2 - yk1^2);
    
end
xc = xc1 / (2*xyc2);
yc = yc1 / (2*xyc2);
%centroid
centroid = [xc yc];
end

