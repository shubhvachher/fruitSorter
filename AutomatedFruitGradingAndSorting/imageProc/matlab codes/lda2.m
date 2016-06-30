%class a
a1 = imread('D:\matlab files\LDA\Oranges\11A.bmp');
a1 = fruitfilter(a1);
    hsva1 = rgb2hsv(a1);
    ha1 = hsva1(:,:,1);
    ha1 = ha1*255;
    ha1 = nonzeros(ha1);
    a1mean = mean(ha1);


a2 = imread('D:\matlab files\LDA\Oranges\11B.bmp');
a2 = fruitfilter(a2);
    hsva2 = rgb2hsv(a2);
    ha2 = hsva2(:,:,1);
    ha2 = ha2*255;
    ha2 = nonzeros(ha2);
    a2mean = mean(ha2);
   

a3 = imread('D:\matlab files\LDA\Oranges\11C.bmp');
a3 = fruitfilter(a3);
    hsva3 = rgb2hsv(a3);
    ha3 = hsva3(:,:,1);
    ha3 = ha3*255;
    ha3 = nonzeros(ha3);
    a3mean = mean(ha3);

a4 = imread('D:\matlab files\LDA\Oranges\11D.bmp');
a4 = fruitfilter(a4);
    hsva4 = rgb2hsv(a4);
    ha4 = hsva4(:,:,1);
    ha4 = ha4*255;
    ha4 = nonzeros(ha4);
    a4mean = mean(ha4);

a5 = imread('D:\matlab files\LDA\Oranges\11E.bmp');
a5 = fruitfilter(a5);
    hsva5 = rgb2hsv(a5);
    ha5 = hsva5(:,:,1);
    ha5 = ha5*255;
    ha5 = nonzeros(ha5);
    a5mean = mean(ha5);

a6 = imread('D:\matlab files\LDA\Oranges\2A.bmp');
a6 = fruitfilter(a6);
    hsva6 = rgb2hsv(a6);
    ha6 = hsva6(:,:,1);
    ha6 = ha6*255;
    ha6 = nonzeros(ha6);
    a6mean = mean(ha6);

a7 = imread('D:\matlab files\LDA\Oranges\2B.bmp');
a7 = fruitfilter(a7);
    hsva7 = rgb2hsv(a7);
    ha7 = hsva7(:,:,1);
    ha7 = ha7*255;
    ha7 = nonzeros(ha7);
    a7mean = mean(ha7);

a8 = imread('D:\matlab files\LDA\Oranges\2C.bmp');
a8 = fruitfilter(a8);
    hsva8 = rgb2hsv(a8);
    ha8 = hsva8(:,:,1);
    ha8 = ha8*255;
    ha8 = nonzeros(ha8);
    a8mean = mean(ha8);

a9 = imread('D:\matlab files\LDA\Oranges\2D.bmp');
a9 = fruitfilter(a9);
    hsva9 = rgb2hsv(a9);
    ha9 = hsva9(:,:,1);
    ha9 = ha9*255;
    ha9 = nonzeros(ha9);
    a9mean = mean(ha9);

a10 = imread('D:\matlab files\LDA\Oranges\2E.bmp');
a10 = fruitfilter(a10);
    hsva10 = rgb2hsv(a10);
    ha10 = hsva10(:,:,1);
    ha10 = ha10*255;
    ha10 = nonzeros(ha10);
    a10mean = mean(ha10);

a_mean = (a1mean+a2mean+a3mean+a4mean+a5mean+a6mean+a7mean+a8mean+a9mean+a10mean)/10;
[am,am2] = padcat2(ha1,ha2,ha3,ha4,ha5,ha6,ha7,ha8,ha9,ha10);
am2 = mean(am);


%class b
b1 = imread('D:\matlab files\LDA\Oranges\14A.bmp');
b1 = fruitfilter(b1);
    hsvb1 = rgb2hsv(b1);
    hb1 = hsvb1(:,:,1);
    hb1 = hb1*255;
    hb1 = nonzeros(hb1);
    b1mean = mean(hb1);


b2 = imread('D:\matlab files\LDA\Oranges\14B.bmp');
b2 = fruitfilter(b2);
    hsvb2 = rgb2hsv(b2);
    hb2 = hsvb2(:,:,1);
    hb2 = hb2*255;
    hb2 = nonzeros(hb2);
    b2mean = mean(hb2);


b3 = imread('D:\matlab files\LDA\Oranges\14C.bmp');
b3 = fruitfilter(b3);
    hsvb3 = rgb2hsv(b3);
    hb3 = hsvb3(:,:,1);
    hb3 = hb3*255;
    hb3 = nonzeros(hb3);
    b3mean = mean(hb3);

b4 = imread('D:\matlab files\LDA\Oranges\14D.bmp');
b4 = fruitfilter(b4);
    hsvb4 = rgb2hsv(b4);
    hb4 = hsvb4(:,:,1);
    hb4 = hb4*255;
    hb4 = nonzeros(hb4);
    b4mean = mean(hb4);

b5 = imread('D:\matlab files\LDA\Oranges\14E.bmp');
b5 = fruitfilter(b5);
    hsvb5 = rgb2hsv(b5);
    hb5 = hsvb5(:,:,1);
    hb5 = hb5*255;
    hb5 = nonzeros(hb5);
    b5mean = mean(hb5);

b6 = imread('D:\matlab files\LDA\Oranges\21A.bmp');
b6 = fruitfilter(b6);
    hsvb6 = rgb2hsv(b6);
    hb6 = hsvb6(:,:,1);
    hb6 = hb6*255;
    hb6 = nonzeros(hb6);
    b6mean = mean(hb6);

b7 = imread('D:\matlab files\LDA\Oranges\21B.bmp');
b7 = fruitfilter(b7);
    hsvb7 = rgb2hsv(b7);
    hb7 = hsvb7(:,:,1);
    hb7 = hb7*255;
    hb7 = nonzeros(hb7);
    b7mean = mean(hb7);

b8 = imread('D:\matlab files\LDA\Oranges\21C.bmp');
b8 = fruitfilter(b8);
    hsvb8 = rgb2hsv(b8);
    hb8 = hsvb8(:,:,1);
    hb8 = hb8*255;
    hb8 = nonzeros(hb8);
    b8mean = mean(hb8);

b9 = imread('D:\matlab files\LDA\Oranges\21D.bmp');
b9 = fruitfilter(b9);
    hsvb9 = rgb2hsv(b9);
    hb9 = hsvb9(:,:,1);
    hb9 = hb9*255;
    hb9 = nonzeros(hb9);
    b9mean = mean(hb9);

b10 = imread('D:\matlab files\LDA\Oranges\21E.bmp');
b10 = fruitfilter(b10);
    hsvb10 = rgb2hsv(b10);
    hb10 = hsvb10(:,:,1);
    hb10 = hb10*255;
    hb10 = nonzeros(hb10);
    b10mean = mean(hb10);

b_mean = (b1mean+b2mean+b3mean+b4mean+b5mean+b6mean+b7mean+b8mean+b9mean+b10mean)/10;
[bm,bm2] = padcat2(hb1,hb2,hb3,hb4,hb5,hb6,hb7,hb8,hb9,hb10);
bm2 = mean(bm);


%class c
c1 = imread('D:\matlab files\LDA\Oranges\15A.bmp');
c1 = fruitfilter(c1);
    hsvc1 = rgb2hsv(c1);
    hc1 = hsvc1(:,:,1);
    hc1 = hc1*255;
    hc1 = nonzeros(hc1);
    c1mean = mean(hc1);


c2 = imread('D:\matlab files\LDA\Oranges\15B.bmp');
c2 = fruitfilter(c2);
    hsvc2 = rgb2hsv(c2);
    hc2 = hsvc2(:,:,1);
    hc2 = hc2*255;
    hc2 = nonzeros(hc2);
    c2mean = mean(hc2);


c3 = imread('D:\matlab files\LDA\Oranges\15C.bmp');
c3 = fruitfilter(c3);
    hsvc3 = rgb2hsv(c3);
    hc3 = hsvc3(:,:,1);
    hc3 = hc3*255;
    hc3 = nonzeros(hc3);
    c3mean = mean(hc3);

c4 = imread('D:\matlab files\LDA\Oranges\15D.bmp');
c4 = fruitfilter(c4);
    hsvc4 = rgb2hsv(c4);
    hc4 = hsvc4(:,:,1);
    hc4 = hc4*255;
    hc4 = nonzeros(hc4);
    c4mean = mean(hc4);

c5 = imread('D:\matlab files\LDA\Oranges\15E.bmp');
c5 = fruitfilter(c5);
    hsvc5 = rgb2hsv(c5);
    hc5 = hsvc5(:,:,1);
    hc5 = hc5*255;
    hc5 = nonzeros(hc5);
    c5mean = mean(hc5);

c6 = imread('D:\matlab files\LDA\Oranges\18A.bmp');
c6 = fruitfilter(c6);
    hsvc6 = rgb2hsv(c6);
    hc6 = hsvc6(:,:,1);
    hc6 = hc6*255;
    hc6 = nonzeros(hc6);
    c6mean = mean(hc6);

c7 = imread('D:\matlab files\LDA\Oranges\18B.bmp');
c7 = fruitfilter(c7);
    hsvc7 = rgb2hsv(c7);
    hc7 = hsvc7(:,:,1);
    hc7 = hc7*255;
    hc7 = nonzeros(hc7);
    c7mean = mean(hc7);

c8 = imread('D:\matlab files\LDA\Oranges\18C.bmp');
c8 = fruitfilter(c8);
    hsvc8 = rgb2hsv(c8);
    hc8 = hsvc8(:,:,1);
    hc8 = hc8*255;
    hc8 = nonzeros(hc8);
    c8mean = mean(hc8);

c9 = imread('D:\matlab files\LDA\Oranges\18D.bmp');
c9 = fruitfilter(c9);
    hsvc9 = rgb2hsv(c9);
    hc9 = hsvc9(:,:,1);
    hc9 = hc9*255;
    hc9 = nonzeros(hc9);
    c9mean = mean(hc9);

c10 = imread('D:\matlab files\LDA\Oranges\18E.bmp');
c10 = fruitfilter(c10);
    hsvc10 = rgb2hsv(c10);
    hc10 = hsvc10(:,:,1);
    hc10 = hc10*255;
    hc10 = nonzeros(hc10);
    c10mean = mean(hc10);

c_mean = (c1mean+c2mean+c3mean+c4mean+c5mean+c6mean+c7mean+c8mean+c9mean+c10mean)/10;
[cm,cm2] = padcat2(hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10);
cm2 = mean(cm);

 
%class d
d1 = imread('D:\matlab files\LDA\Sathukudi\1A.bmp');
d1 = fruitfilter(d1);
    hsvd1 = rgb2hsv(d1);
    hd1 = hsvd1(:,:,1);
    hd1 = hd1*255;
    hd1 = nonzeros(hd1); 
    d1mean = mean(hd1);


d2 = imread('D:\matlab files\LDA\Sathukudi\1B.bmp');
d2 = fruitfilter(d2);
    hsvd2 = rgb2hsv(d2);
    hd2 = hsvd2(:,:,1);
    hd2 = hd2*255;
    hd2 = nonzeros(hd2); 
    d2mean = mean(hd2);


d3 = imread('D:\matlab files\LDA\Sathukudi\1C.bmp');
d3 = fruitfilter(d3);
    hsvd3 = rgb2hsv(d3);
    hd3 = hsvd3(:,:,1);
    hd3 = hd3*255;
    hd3 = nonzeros(hd3); 
    d3mean = mean(hd3);

d4 = imread('D:\matlab files\LDA\Sathukudi\1D.bmp');
d4 = fruitfilter(d4);
    hsvd4 = rgb2hsv(d4);
    hd4 = hsvd4(:,:,1);
    hd4 = hd4*255;
    hd4 = nonzeros(hd4); 
    d4mean = mean(hd4);

d5 = imread('D:\matlab files\LDA\Sathukudi\1E.bmp');
d5 = fruitfilter(d5);
    hsvd5 = rgb2hsv(d5);
    hd5 = hsvd5(:,:,1);
    hd5 = hd5*255;
    hd5 = nonzeros(hd5); 
    d5mean = mean(hd5);

d6 = imread('D:\matlab files\LDA\Sathukudi\2A.bmp');
d6 = fruitfilter(d6);
    hsvd6 = rgb2hsv(d6);
    hd6 = hsvd6(:,:,1);
    hd6 = hd6*255;
    hd6 = nonzeros(hd6); 
    d6mean = mean(hd6);

d7 = imread('D:\matlab files\LDA\Sathukudi\2B.bmp');
d7 = fruitfilter(d7);
    hsvd7 = rgb2hsv(d7);
    hd7 = hsvd7(:,:,1);
    hd7 = hd7*255;
    hd7 = nonzeros(hd7); 
    d7mean = mean(hd7);

d8 = imread('D:\matlab files\LDA\Sathukudi\2C.bmp');
d8 = fruitfilter(d8);
    hsvd8 = rgb2hsv(d8);
    hd8 = hsvd8(:,:,1);
    hd8 = hd8*255;
    hd8 = nonzeros(hd8); 
    d8mean = mean(hd8);

d9 = imread('D:\matlab files\LDA\Sathukudi\2D.bmp');
d9 = fruitfilter(d9);
    hsvd9 = rgb2hsv(d9);
    hd9 = hsvd9(:,:,1);
    hd9 = hd9*255;
    hd9 = nonzeros(hd9); 
    d9mean = mean(hd9);

d10 = imread('D:\matlab files\LDA\Sathukudi\2E.bmp');
d10 = fruitfilter(d10);
    hsvd10 = rgb2hsv(d10);
    hd10 = hsvd10(:,:,1);
    hd10 = hd10*255;
    hd10 = nonzeros(hd10); 
    d10mean = mean(hd10);

d_mean = (d1mean+d2mean+d3mean+d4mean+d5mean+d6mean+d7mean+d8mean+d9mean+d10mean)/10;
[dm,dm2] = padcat2(hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10);
dm2 = mean(dm);


%class e
e1 = imread('D:\matlab files\LDA\Lemon\1A.bmp');
e1 = fruitfilter(e1);
    hsve1 = rgb2hsv(e1);
    he1 = hsve1(:,:,1);
    he1 = he1*255;
    he1 = nonzeros(he1); 
    e1mean = mean(he1);


e2 = imread('D:\matlab files\LDA\Lemon\1B.bmp');
e2 = fruitfilter(e2);
    hsve2 = rgb2hsv(e2);
    he2 = hsve2(:,:,1);
    he2 = he2*255;
    he2 = nonzeros(he2);
    e2mean = mean(he2);


e3 = imread('D:\matlab files\LDA\Lemon\1C.bmp');
e3 = fruitfilter(e3);
    hsve3 = rgb2hsv(e3);
    he3 = hsve3(:,:,1);
    he3 = he3*255;
    he3 = nonzeros(he3);
    e3mean = mean(he3);

e4 = imread('D:\matlab files\LDA\Lemon\1D.bmp');
e4 = fruitfilter(e4);
    hsve4 = rgb2hsv(e4);
    he4 = hsve4(:,:,1);
    he4 = he4*255;
    he4 = nonzeros(he4);
    e4mean = mean(he4);

e5 = imread('D:\matlab files\LDA\Lemon\1E.bmp');
e5 = fruitfilter(e5);
    hsve5 = rgb2hsv(e5);
    he5 = hsve5(:,:,1);
    he5 = he5*255;
    he5 = nonzeros(he5);
    e5mean = mean(he5);

e6 = imread('D:\matlab files\LDA\Lemon\2A.bmp');
e6 = fruitfilter(e6);
    hsve6 = rgb2hsv(e6);
    he6 = hsve6(:,:,1);
    he6 = he6*255;
    he6 = nonzeros(he6);
    e6mean = mean(he6);

e7 = imread('D:\matlab files\LDA\Lemon\2B.bmp');
e7 = fruitfilter(e7);
    hsve7 = rgb2hsv(e7);
    he7 = hsve7(:,:,1);
    he7 = he7*255;
    he7 = nonzeros(he7);
    e7mean = mean(he7);

e8 = imread('D:\matlab files\LDA\Lemon\2C.bmp');
e8 = fruitfilter(e8);
    hsve8 = rgb2hsv(e8);
    he8 = hsve8(:,:,1);
    he8 = he8*255;
    he8 = nonzeros(he8);
    e8mean = mean(he8);

e9 = imread('D:\matlab files\LDA\Lemon\2D.bmp');
e9 = fruitfilter(e9);
    hsve9 = rgb2hsv(e9);
    he9 = hsve9(:,:,1);
    he9 = he9*255;
    he9 = nonzeros(he9);
    e9mean = mean(he9);

e10 = imread('D:\matlab files\LDA\Lemon\2E.bmp');
e10 = fruitfilter(e10);
    hsve10 = rgb2hsv(e10);
    he10 = hsve10(:,:,1);
    he10 = he10*255;
    he10 = nonzeros(he10);
    e10mean = mean(he10);

e_mean = (e1mean+e2mean+e3mean+e4mean+e5mean+e6mean+e7mean+e8mean+e9mean+e10mean)/10;
[em,em2] = padcat2(he1,he2,he3,he4,he5,he6,he7,he8,he9,he10);
em2 = mean(em);


am1 = mean(am);
bm1 = mean(bm);
cm1 = mean(cm);
dm1 = mean(dm);
em1 = mean(em);

I1 = imread('D:\Matlab files\LDA\Samples\39e.bmp');
c(1) = classifyfn2(I1,am1,bm1,cm1,dm1,em1);

I2 = imread('D:\Matlab files\LDA\Samples\10c.bmp');
c(2) = classifyfn2(I2,am1,bm1,cm1,dm1,em1);

I3 = imread('D:\Matlab files\LDA\Samples\23e.bmp');
c(3) = classifyfn2(I3,am1,bm1,cm1,dm1,em1);

I4 = imread('D:\Matlab files\LDA\Samples\19c.bmp');
c(4) = classifyfn2(I4,am1,bm1,cm1,dm1,em1);

I5 = imread('D:\Matlab files\LDA\Samples\14d.bmp');
c(5) = classifyfn2(I5,am1,bm1,cm1,dm1,em1);

I6 = imread('D:\Matlab files\LDA\Samples\9b.bmp');
c(6) = classifyfn2(I6,am1,bm1,cm1,dm1,em1);

I7 = imread('D:\Matlab files\LDA\Samples\12c.bmp');
c(7) = classifyfn2(I7,am1,bm1,cm1,dm1,em1);

I8 = imread('D:\Matlab files\LDA\Samples\4d.bmp');
c(8) = classifyfn2(I8,am1,bm1,cm1,dm1,em1);

I9 = imread('D:\Matlab files\LDA\Samples\20c.bmp');
c(9) = classifyfn2(I9,am1,bm1,cm1,dm1,em1);

I10 = imread('D:\Matlab files\LDA\Samples\42c.bmp');
c(10) = classifyfn2(I10,am1,bm1,cm1,dm1,em1);

I11 = imread('D:\Matlab files\LDA\Samples\1b.bmp');
c(11) = classifyfn2(I11,am1,bm1,cm1,dm1,em1);

I12 = imread('D:\Matlab files\LDA\Samples\22c.bmp');
c(12) = classifyfn2(I12,am1,bm1,cm1,dm1,em1);

I13 = imread('D:\Matlab files\LDA\Samples\23b.bmp');
c(13) = classifyfn2(I13,am1,bm1,cm1,dm1,em1);

I14 = imread('D:\Matlab files\LDA\Samples\7b.bmp');
c(14) = classifyfn2(I14,am1,bm1,cm1,dm1,em1);

I15 = imread('d:\matlab files\lda\samples\25c.bmp');
c(15) = classifyfn2(I15,am1,bm1,cm1,dm1,em1);
