%References
%Class A
i1 = imread('d:\matlab files\lda\oranges\2a.bmp');
i1 = fruitfilter(i1);
hsv1 = rgb2hsv(i1);
h1 = hsv1(:,:,1);
s1 = hsv1(:,:,2);

%Class B
i2 = imread('d:\matlab files\lda\oranges\14a.bmp');
i2 = fruitfilter(i2);
hsv2 = rgb2hsv(i2);
h2 = hsv2(:,:,1);
s2 = hsv2(:,:,2);

%Class C
i3 = imread('d:\matlab files\lda\samples\19d.bmp');
i3 = fruitfilter(i3);
hsv3 = rgb2hsv(i3);
h3= hsv3(:,:,1);
s3 = hsv3(:,:,2);


%--------------------------------#

%Samples from each class

a1 = imread('D:\matlab files\LDA\Samples\1A.bmp');
a1 = fruitfilter(a1);
hsva1 = rgb2hsv(a1);
ha1 = hsva1(:,:,1);
sa1 = hsva1(:,:,2);

a2 = imread('D:\matlab files\LDA\Oranges\30e.bmp');
a2 = fruitfilter(a2);
hsva2 = rgb2hsv(a2);
ha2 = hsva2(:,:,1);
sa2 = hsva2(:,:,2);

a3 = imread('D:\matlab files\LDA\Oranges\30C.bmp');
a3 = fruitfilter(a3);
hsva3 = rgb2hsv(a3);
ha3 = hsva3(:,:,1);
sa3 = hsva3(:,:,2);

a4 = imread('D:\matlab files\LDA\Samples\4D.bmp');
a4 = fruitfilter(a4);
hsva4 = rgb2hsv(a4);
ha4 = hsva4(:,:,1);
sa4 = hsva4(:,:,2);

a5 = imread('D:\matlab files\LDA\Samples\42c.bmp');
a5 = fruitfilter(a5);
hsva5 = rgb2hsv(a5);
ha5 = hsva5(:,:,1);
sa5 = hsva5(:,:,2);


%class b
b1 = imread('D:\matlab files\LDA\Oranges\21A.bmp');
b1 = fruitfilter(b1);
hsvb1 = rgb2hsv(b1);
hb1 = hsvb1(:,:,1);
sb1 = hsvb1(:,:,2);

b2 = imread('D:\matlab files\LDA\Oranges\17B.bmp');
b2 = fruitfilter(b2);
hsvb2 = rgb2hsv(b2);
hb2 = hsvb2(:,:,1);
sb2 = hsvb2(:,:,2);

b3 = imread('D:\matlab files\LDA\Oranges\14C.bmp');
b3 = fruitfilter(b3);
hsvb3 = rgb2hsv(b3);
hb3 = hsvb3(:,:,1);
sb3 = hsvb3(:,:,2);

b4 = imread('D:\matlab files\LDA\oranges\14b.bmp');
b4 = fruitfilter(b4);
hsvb4 = rgb2hsv(b4);
hb4 = hsvb4(:,:,1);
sb4 = hsvb4(:,:,2);

b5 = imread('D:\matlab files\LDA\samples\22c.bmp');
b5 = fruitfilter(b5);
hsvb5 = rgb2hsv(b5);
hb5 = hsvb5(:,:,1);
sb5 = hsvb5(:,:,2);

%class c
c1 = imread('D:\matlab files\LDA\Oranges\18c.bmp');
c1 = fruitfilter(c1);
hsvc1 = rgb2hsv(c1);
hc1 = hsvc1(:,:,1);
sc1 = hsvc1(:,:,2);

c2 = imread('D:\matlab files\LDA\Oranges\18a.bmp');
c2 = fruitfilter(c2);
hsvc2 = rgb2hsv(c2);
hc2 = hsvc2(:,:,1);
sc2 = hsvc2(:,:,2);

c3 = imread('D:\matlab files\LDA\Samples\23b.bmp');
c3 = fruitfilter(c3);
hsvc3 = rgb2hsv(c3);
hc3 = hsvc3(:,:,1);
sc3 = hsvc3(:,:,2);

c4 = imread('D:\matlab files\LDA\oranges\19e.bmp');
c4 = fruitfilter(c4);
hsvc4 = rgb2hsv(c4);
hc4 = hsvc4(:,:,1);
sc4 = hsvc4(:,:,2);

c5 = imread('D:\matlab files\LDA\Samples\23e.bmp');
c5 = fruitfilter(c5);
hsvc5 = rgb2hsv(c5);
hc5 = hsvc5(:,:,1);
sc5 = hsvc5(:,:,2);

%------------------------------------%

d(1,1) = mean2(abs(h1 - ha1) + abs(s1 - sa1));
d(1,2) = mean2(abs(h2 - ha1) + abs(s2 - sa1));
d(1,3) = mean2(abs(h3 - ha1) + abs(s3 - sa1));

d(2,1) = mean2(abs(h1 - ha2) + abs(s1 - sa2));
d(2,2) = mean2(abs(h2 - ha2) + abs(s2 - sa2));
d(2,3) = mean2(abs(h3 - ha2) + abs(s3 - sa2));


d(3,1) = mean2(abs(h1 - ha3) + abs(s1 - sa3));
d(3,2) = mean2(abs(h2 - ha3) + abs(s2 - sa3));
d(3,3) = mean2(abs(h3 - ha3) + abs(s3 - sa3));


d(4,1) = mean2(abs(h1 - ha4) + abs(s1 - sa4));
d(4,2) = mean2(abs(h2 - ha4) + abs(s2 - sa4));
d(4,3) = mean2(abs(h3 - ha4) + abs(s3 - sa4));


d(5,1) = mean2(abs(h1 - ha5) + abs(s1 - sa5));
d(5,2) = mean2(abs(h2 - ha5) + abs(s2 - sa5));
d(5,3) = mean2(abs(h3 - ha5) + abs(s3 - sa5));

%-----
d(6,1) = mean2(abs(h1 - hb1) + abs(s1 - sb1));
d(6,2) = mean2(abs(h2 - hb1) + abs(s2 - sb1));
d(6,3) = mean2(abs(h3 - hb1) + abs(s3 - sb1));


d(7,1) = mean2(abs(h1 - hb2) + abs(s1 - sb2));
d(7,2) = mean2(abs(h2 - hb2) + abs(s2 - sb2));
d(7,3) = mean2(abs(h3 - hb2) + abs(s3 - sb2));

d(8,1) = mean2(abs(h1 - hb3) + abs(s1 - sb3));
d(8,2) = mean2(abs(h2 - hb3) + abs(s2 - sb3));
d(8,3) = mean2(abs(h3 - hb3) + abs(s3 - sb3));

d(9,1) = mean2(abs(h1 - hb4) + abs(s1 - sb4));
d(9,2) = mean2(abs(h2 - hb4) + abs(s2 - sb4));
d(9,3) = mean2(abs(h3 - hb4) + abs(s3 - sb4));

d(10,1) = mean2(abs(h1 - hb5) + abs(s1 - sb5));
d(10,2) = mean2(abs(h2 - hb5) + abs(s2 - sb5));
d(10,3) = mean2(abs(h3 - hb5) + abs(s3 - sb5));
%---
d(11,1) = mean2(abs(h1 - hc1) + abs(s1 - sc1));
d(11,2) = mean2(abs(h2 - hc1) + abs(s2 - sc1));
d(11,3) = mean2(abs(h3 - hc1) + abs(s3 - sc1));

d(12,1) = mean2(abs(h1 - hc2) + abs(s1 - sc2));
d(12,2) = mean2(abs(h2 - hc2) + abs(s2 - sc2));
d(12,3) = mean2(abs(h3 - hc2) + abs(s3 - sc2));

d(13,1) = mean2(abs(h1 - hc3) + abs(s1 - sc3));
d(13,2) = mean2(abs(h2 - hc3) + abs(s2 - sc3));
d(13,3) = mean2(abs(h3 - hc3) + abs(s3 - sc3));

d(14,1) = mean2(abs(h1 - hc4) + abs(s1 - sc4));
d(14,2) = mean2(abs(h2 - hc4) + abs(s2 - sc4));
d(14,3) = mean2(abs(h3 - hc4) + abs(s3 - sc4));

d(15,1) = mean2(abs(h1 - hc5) + abs(s1 - sc5));
d(15,2) = mean2(abs(h2 - hc5) + abs(s2 - sc5));
d(15,3) = mean2(abs(h3 - hc5) + abs(s3 - sc5));
%-----------------
