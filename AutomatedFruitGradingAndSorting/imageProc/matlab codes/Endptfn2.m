function [ endpt1 , endpt2 ] = Endptfn2( fp,centroid )
% finding endpoints using centroid and contour image
[a b] = find(fp == 1);
cp2 = [a b];

x = [1 455];
y = [455 455];
for i = 1:455
    a= linspace(x(1),x(2),500);
    b= linspace(y(1),y(2),500);
    c = [a; b];
    endpt1 = InterX(cp2',c);
    if numel(endpt1)>0
        break
    end
    y(1) = y(1)-1;
end


x = [455 455];
y = [1 455];
for i = 1:455
    a= linspace(x(1),x(2),500);
    b= linspace(y(1),y(2),500);
    c = [a' b'];
    c= round(c);   % points on the line
    endpt2 = intersect(cp2, c,'rows');
    if numel(endpt2)>0
        break
    end
    x(1) = x(1)-1;
end

figure,imshow(fp);
hold on;

x = [endpt1(1) endpt2(1)];
y = [endpt1(2) endpt2(2)];
line(x,y);

x = [endpt1(1) centroid(1)];
y = [endpt1(2) centroid(2)];
line(x,y);


x = [endpt2(1) centroid(1)];
y = [endpt2(2) centroid(2)];
line(x,y);

end

