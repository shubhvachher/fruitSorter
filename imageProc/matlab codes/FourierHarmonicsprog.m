I = imread('D:\matlab files\img\Shape\2.bmp');
gray = rgb2gray(I);
bw = im2bw(gray, 0.77);
cont = Contourfn(bw);
imshow(cont);

[a b]= find(cont==1);
cont2 = [b a];

N = 256;
x = length(cont2);
n = linspace(1,x,256);
n = floor(n);
conn1 = zeros(N,2);
for i = 1:N
    conn1(i,:) = cont2(n(i),:);
end

centroid = regionprops(cont,'centroid');
centroid = centroid.Centroid;
r1 = zeros(size(conn1,1),1);
for i = 1:size(conn1,1)
    xk = conn1(i,1);
    yk = conn1(i,2);
    r1(i,1) = hypot((xk - centroid(1)),(yk - centroid(2)));
end
 
f = zeros(11,1);

%heuristic shape separator
for u = 1:11, 
    xy = 0;
    for k = 1:N
        xy = xy + r1(k)*exp(-2*pi*(u-1)*k/N);
    end
    f(u) = 1/N *xy;
end

S1 = 0; S2=0; S3=0;
m = 1;
for l = 1:10
    S1 = S1 + f(l)*l^m;
end

m = 2;
for l = 1:10
    S2 = S2 + f(l)*l^m;
end

m = 3;
for l = 1:10
    S3 = S3 + f(l)*l^m;
end

S=[S1;S2;S3];

