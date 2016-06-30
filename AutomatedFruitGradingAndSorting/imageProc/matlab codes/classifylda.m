%class a
a1 = imread('D:\matlab files\LDA\Oranges\11A.bmp');
a1 = fruitfilter(a1);
    hsva1 = rgb2hsv(a1);
    ha1 = hsva1(:,:,1);
    ha1 = ha1*255;
    a1mean = mean(ha1);


a2 = imread('D:\matlab files\LDA\Oranges\11B.bmp');
a2 = fruitfilter(a2);
    hsva2 = rgb2hsv(a2);
    ha2 = hsva2(:,:,1);
    ha2 = ha2*255;
    a2mean = mean(ha2);


a3 = imread('D:\matlab files\LDA\Oranges\11C.bmp');
a3 = fruitfilter(a3);
    hsva3 = rgb2hsv(a3);
    ha3 = hsva3(:,:,1);
    ha3 = ha3*255;
    a3mean = mean(ha3);

a4 = imread('D:\matlab files\LDA\Oranges\11D.bmp');
a4 = fruitfilter(a4);
    hsva4 = rgb2hsv(a4);
    ha4 = hsva4(:,:,1);
    ha4 = ha4*255;
    a4mean = mean(ha4);

a5 = imread('D:\matlab files\LDA\Oranges\11E.bmp');
a5 = fruitfilter(a5);
    hsva5 = rgb2hsv(a5);
    ha5 = hsva5(:,:,1);
    ha5 = ha5*255;
    a5mean = mean(ha5);

a6 = imread('D:\matlab files\LDA\Oranges\2A.bmp');
a6 = fruitfilter(a6);
    hsva6 = rgb2hsv(a6);
    ha6 = hsva6(:,:,1);
    ha6 = ha6*255;
    a6mean = mean(ha6);

a7 = imread('D:\matlab files\LDA\Oranges\2B.bmp');
a7 = fruitfilter(a7);
    hsva7 = rgb2hsv(a7);
    ha7 = hsva7(:,:,1);
    ha7 = ha7*255;
    a7mean = mean(ha7);

a8 = imread('D:\matlab files\LDA\Oranges\2C.bmp');
a8 = fruitfilter(a8);
    hsva8 = rgb2hsv(a8);
    ha8 = hsva8(:,:,1);
    ha8 = ha8*255;
    a8mean = mean(ha8);

a9 = imread('D:\matlab files\LDA\Oranges\2D.bmp');
a9 = fruitfilter(a9);
    hsva9 = rgb2hsv(a9);
    ha9 = hsva9(:,:,1);
    ha9 = ha9*255;
    a9mean = mean(ha9);

a10 = imread('D:\matlab files\LDA\Oranges\2E.bmp');
a10 = fruitfilter(a10);
    hsva10 = rgb2hsv(a10);
    ha10 = hsva10(:,:,1);
    ha10 = ha10*255;
    a10mean = mean(ha10);

a_mean = (a1mean+a2mean+a3mean+a4mean+a5mean+a6mean+a7mean+a8mean+a9mean+a10mean)/10;
amean = a_mean';

%class b 
b1 = imread('D:\matlab files\LDA\Oranges\15A.bmp');
b1 = fruitfilter(b1);
    hsvb1 = rgb2hsv(b1);
    hb1 = hsvb1(:,:,1);
    hb1 = hb1*255;
    b1mean = mean(hb1);
    
b2 = imread('D:\matlab files\LDA\Oranges\15B.bmp');
b3 = fruitfilter(b2);
    hsvb2 = rgb2hsv(b2);
    hb2 = hsvb2(:,:,1);
    hb2 = hb2*255;
    b2mean = mean(hb2);
    
b3 = imread('D:\matlab files\LDA\Oranges\15C.bmp');
b3 = fruitfilter(b3);
    hsvb3 = rgb2hsv(b3);
    hb3 = hsvb3(:,:,1);
    hb3 = hb3*255;
    b3mean = mean(hb3);
    
b4 = imread('D:\matlab files\LDA\Oranges\15D.bmp');
b4 = fruitfilter(b4);
    hsvb4 = rgb2hsv(b4);
    hb4 = hsvb4(:,:,1);
    hb4 = hb4*255;
    b4mean = mean(hb4);
    
b5 = imread('D:\matlab files\LDA\Oranges\15E.bmp');
b5 = fruitfilter(b5);
    hsvb5 = rgb2hsv(b5);
    hb5 = hsvb5(:,:,1);
    hb5 = hb5*255;
    b5mean = mean(hb5);
    
b6 = imread('D:\matlab files\LDA\Oranges\18A.bmp');
b6 = fruitfilter(b6);
    hsvb6 = rgb2hsv(b6);
    hb6 = hsvb6(:,:,1);
    hb6 = hb6*255;
    b6mean = mean(hb6);
    
b7 = imread('D:\matlab files\LDA\Oranges\18B.bmp');
b7 = fruitfilter(b7);
    hsvb7 = rgb2hsv(b7);
    hb7 = hsvb7(:,:,1);
    hb7 = hb7*255;
    b7mean = mean(hb7);
    
b8 = imread('D:\matlab files\LDA\Oranges\18C.bmp');
b8 = fruitfilter(b8);
    hsvb8 = rgb2hsv(b8);
    hb8 = hsvb8(:,:,1);
    hb8 = hb8*255;
    b8mean = mean(hb8);
    
b9 = imread('D:\matlab files\LDA\Oranges\18D.bmp');
b9 = fruitfilter(b9);
    hsvb9 = rgb2hsv(b9);
    hb9 = hsvb9(:,:,1);
    hb9 = hb9*255;
    b9mean = mean(hb9);
    
b10 = imread('D:\matlab files\LDA\Oranges\18E.bmp');
b10 = fruitfilter(b10);
    hsvb10 = rgb2hsv(b10);
    hb10 = hsvb10(:,:,1);
    hb10 = hb10*255;
    b10mean = mean(hb10);

b_mean = (b1mean+b2mean+b3mean+b4mean+b5mean+b6mean+b7mean+b8mean+b9mean+b10mean)/10; 
bmean = b_mean';

%class c
c1 = imread('D:\matlab files\LDA\Oranges\21A.bmp');
c1 = fruitfilter(c1);
    hsvc1 = rgb2hsv(c1);
    hc1 = hsvc1(:,:,1);
    hc1 = hc1*255;
    c1mean = mean(hc1);


c2 = imread('D:\matlab files\LDA\Oranges\21B.bmp');
c2 = fruitfilter(c2);
    hsvc2 = rgb2hsv(c2);
    hc2 = hsvc2(:,:,1);
    hc2 = hc2*255;
    c2mean = mean(hc2);


c3 = imread('D:\matlab files\LDA\Oranges\21C.bmp');
c3 = fruitfilter(c3);
    hsvc3 = rgb2hsv(c3);
    hc3 = hsvc3(:,:,1);
    hc3 = hc3*255;
    c3mean = mean(hc3);

c4 = imread('D:\matlab files\LDA\Oranges\21D.bmp');
c4 = fruitfilter(c4);
    hsvc4 = rgb2hsv(c4);
    hc4 = hsvc4(:,:,1);
    hc4 = hc4*255;
    c4mean = mean(hc4);

c5 = imread('D:\matlab files\LDA\Oranges\21E.bmp');
c5 = fruitfilter(c5);
    hsvc5 = rgb2hsv(c5);
    hc5 = hsvc5(:,:,1);
    hc5 = hc5*255;
    c5mean = mean(hc5);

c6 = imread('D:\matlab files\LDA\Oranges\14A.bmp');
c6 = fruitfilter(c6);
    hsvc6 = rgb2hsv(c6);
    hc6 = hsvc6(:,:,1);
    hc6 = hc6*255;
    c6mean = mean(hc6);

c7 = imread('D:\matlab files\LDA\Oranges\14B.bmp');
c7 = fruitfilter(c7);
    hsvc7 = rgb2hsv(c7);
    hc7 = hsvc7(:,:,1);
    hc7 = hc7*255;
    c7mean = mean(hc7);

c8 = imread('D:\matlab files\LDA\Oranges\14C.bmp');
c8 = fruitfilter(c8);
    hsvc8 = rgb2hsv(c8);
    hc8 = hsvc8(:,:,1);
    hc8 = hc8*255;
    c8mean = mean(hc8);

c9 = imread('D:\matlab files\LDA\Oranges\14D.bmp');
c9 = fruitfilter(c9);
    hsvc9 = rgb2hsv(c9);
    hc9 = hsvc9(:,:,1);
    hc9 = hc9*255;
    c9mean = mean(hc9);

c10 = imread('D:\matlab files\LDA\Oranges\14E.bmp');
c10 = fruitfilter(c10);
    hsvc10 = rgb2hsv(c10);
    hc10 = hsvc10(:,:,1);
    hc10 = hc10*255;
    c10mean = mean(hc10);

c_mean = (c1mean+c2mean+c3mean+c4mean+c5mean+c6mean+c7mean+c8mean+c9mean+c10mean)/10;
cmean = c_mean';
 
%class d
d1 = imread('D:\matlab files\LDA\Sathukudi\1A.bmp');
d1 = fruitfilter(d1);
    hsvd1 = rgb2hsv(d1);
    hd1 = hsvd1(:,:,1);
    hd1 = hd1*255;
    d1mean = mean(hd1);


d2 = imread('D:\matlab files\LDA\Sathukudi\1B.bmp');
d2 = fruitfilter(d2);
    hsvd2 = rgb2hsv(d2);
    hd2 = hsvd2(:,:,1);
    hd2 = hd2*255;
    d2mean = mean(hd2);


d3 = imread('D:\matlab files\LDA\Sathukudi\1C.bmp');
d3 = fruitfilter(d3);
    hsvd3 = rgb2hsv(d3);
    hd3 = hsvd3(:,:,1);
    hd3 = hd3*255;
    d3mean = mean(hd3);

d4 = imread('D:\matlab files\LDA\Sathukudi\1D.bmp');
d4 = fruitfilter(d4);
    hsvd4 = rgb2hsv(d4);
    hd4 = hsvd4(:,:,1);
    hd4 = hd4*255;
    d4mean = mean(hd4);

d5 = imread('D:\matlab files\LDA\Sathukudi\1E.bmp');
d5 = fruitfilter(d5);
    hsvd5 = rgb2hsv(d5);
    hd5 = hsvd5(:,:,1);
    hd5 = hd5*255;
    d5mean = mean(hd5);

d6 = imread('D:\matlab files\LDA\Sathukudi\2A.bmp');
d6 = fruitfilter(d6);
    hsvd6 = rgb2hsv(d6);
    hd6 = hsvd6(:,:,1);
    hd6 = hd6*255;
    d6mean = mean(hd6);

d7 = imread('D:\matlab files\LDA\Sathukudi\2B.bmp');
d7 = fruitfilter(d7);
    hsvd7 = rgb2hsv(d7);
    hd7 = hsvd7(:,:,1);
    hd7 = hd7*255;
    d7mean = mean(hd7);

d8 = imread('D:\matlab files\LDA\Sathukudi\2C.bmp');
d8 = fruitfilter(d8);
    hsvd8 = rgb2hsv(d8);
    hd8 = hsvd8(:,:,1);
    hd8 = hd8*255;
    d8mean = mean(hd8);

d9 = imread('D:\matlab files\LDA\Sathukudi\2D.bmp');
d9 = fruitfilter(d9);
    hsvd9 = rgb2hsv(d9);
    hd9 = hsvd9(:,:,1);
    hd9 = hd9*255;
    d9mean = mean(hd9);

d10 = imread('D:\matlab files\LDA\Sathukudi\2E.bmp');
d10 = fruitfilter(d10);
    hsvd10 = rgb2hsv(d10);
    hd10 = hsvd10(:,:,1);
    hd10 = hd10*255;
    d10mean = mean(hd10);

d_mean = (d1mean+d2mean+d3mean+d4mean+d5mean+d6mean+d7mean+d8mean+d9mean+d10mean)/10;
dmean = d_mean';

%class e
e1 = imread('D:\matlab files\LDA\Lemon\1A.bmp');
e1 = fruitfilter(e1);
    hsve1 = rgb2hsv(e1);
    he1 = hsve1(:,:,1);
    he1 = he1*255;
    e1mean = mean(he1);


e2 = imread('D:\matlab files\LDA\Lemon\1B.bmp');
e2 = fruitfilter(e2);
    hsve2 = rgb2hsv(e2);
    he2 = hsve2(:,:,1);
    he2 = he2*255;
    e2mean = mean(he2);


e3 = imread('D:\matlab files\LDA\Lemon\1C.bmp');
e3 = fruitfilter(e3);
    hsve3 = rgb2hsv(e3);
    he3 = hsve3(:,:,1);
    he3 = he3*255;
    e3mean = mean(he3);

e4 = imread('D:\matlab files\LDA\Lemon\1D.bmp');
e4 = fruitfilter(e4);
    hsve4 = rgb2hsv(e4);
    he4 = hsve4(:,:,1);
    he4 = he4*255;
    e4mean = mean(he4);

e5 = imread('D:\matlab files\LDA\Lemon\1E.bmp');
e5 = fruitfilter(e5);
    hsve5 = rgb2hsv(e5);
    he5 = hsve5(:,:,1);
    he5 = he5*255;
    e5mean = mean(he5);

e6 = imread('D:\matlab files\LDA\Lemon\2A.bmp');
e6 = fruitfilter(e6);
    hsve6 = rgb2hsv(e6);
    he6 = hsve6(:,:,1);
    he6 = he6*255;
    e6mean = mean(he6);

e7 = imread('D:\matlab files\LDA\Lemon\2B.bmp');
e7 = fruitfilter(e7);
    hsve7 = rgb2hsv(e7);
    he7 = hsve7(:,:,1);
    he7 = he7*255;
    e7mean = mean(he7);

e8 = imread('D:\matlab files\LDA\Lemon\2C.bmp');
e8 = fruitfilter(e8);
    hsve8 = rgb2hsv(e8);
    he8 = hsve8(:,:,1);
    he8 = he8*255;
    e8mean = mean(he8);

e9 = imread('D:\matlab files\LDA\Lemon\2D.bmp');
e9 = fruitfilter(e9);
    hsve9 = rgb2hsv(e9);
    he9 = hsve9(:,:,1);
    he9 = he9*255;
    e9mean = mean(he9);

e10 = imread('D:\matlab files\LDA\Lemon\2E.bmp');
e10 = fruitfilter(e10);
    hsve10 = rgb2hsv(e10);
    he10 = hsve10(:,:,1);
    he10 = he10*255;
    e10mean = mean(he10);

e_mean = (e1mean+e2mean+e3mean+e4mean+e5mean+e6mean+e7mean+e8mean+e9mean+e10mean)/10;
emean = e_mean';

%test sample
% i = fruitfilter(i);
% hsvt = rgb2hsv(i);
% ht = hsvt(:,:,1);
% ht = ht*255;
% t_mean = mean(ht);
% %tmean1
% tmean = mean2(t_mean);
% 
% 
% group = [ones(length(amean),1); (ones(length(bmean),1)*2); (ones(length(bmean),1)*3);(ones(length(bmean),1)*4);(ones(length(bmean),1)*5)];
% index = classify(tmean,[amean; bmean; cmean; dmean; emean],group);
%  
% % index = mode(class);
% 
% if index == 1
%     disp('Sample belongs to class A of oranges');
% elseif index == 3
%     disp('Sample belongs to class B of oranges');
% elseif index == 2
%     disp('Sample belongs to class C of oranges');
% elseif index == 4
%     disp('Sample belongs to class of Sweet Lime');
% elseif index == 5
%     disp('Sample belongs to class of Lemon');
% end
% 
% 
% 


I1 = imread('D:\Matlab files\LDA\Samples\39e.bmp');
c(1) = classifyfn(I1,amean,bmean,cmean,dmean,emean);

I2 = imread('D:\Matlab files\LDA\Samples\42a.bmp');
c(2) = classifyfn(I2,amean,bmean,cmean,dmean,emean);

I3 = imread('D:\Matlab files\LDA\Samples\23e.bmp');
c(3) = classifyfn(I3,amean,bmean,cmean,dmean,emean);

I4 = imread('D:\Matlab files\LDA\Samples\7d.bmp');
c(4) = classifyfn(I4,amean,bmean,cmean,dmean,emean);

I5 = imread('D:\Matlab files\LDA\Samples\14e.bmp');
c(5) = classifyfn(I5,amean,bmean,cmean,dmean,emean);

I6 = imread('D:\Matlab files\LDA\Samples\37c.bmp');
c(6) = classifyfn(I6,amean,bmean,cmean,dmean,emean);

I7 = imread('D:\Matlab files\LDA\Samples\13b.bmp');
c(7) = classifyfn(I7,amean,bmean,cmean,dmean,emean);

I8 = imread('D:\Matlab files\LDA\Samples\4d.bmp');
c(8) = classifyfn(I8,amean,bmean,cmean,dmean,emean);

I9 = imread('D:\Matlab files\LDA\Samples\20c.bmp');
c(9) = classifyfn(I9,amean,bmean,cmean,dmean,emean);

I10 = imread('D:\Matlab files\LDA\Samples\42c.bmp');
c(10) = classifyfn(I10,amean,bmean,cmean,dmean,emean);

I11 = imread('D:\Matlab files\LDA\Samples\1b.bmp');
c(11) = classifyfn(I11,amean,bmean,cmean,dmean,emean);

I12 = imread('D:\Matlab files\LDA\Samples\22c.bmp');
c(12) = classifyfn(I12,amean,bmean,cmean,dmean,emean);

I13 = imread('D:\Matlab files\LDA\Samples\23b.bmp');
c(13) = classifyfn(I13,amean,bmean,cmean,dmean,emean);

I14 = imread('D:\Matlab files\LDA\Samples\7b.bmp');
c(14) = classifyfn(I14,amean,bmean,cmean,dmean,emean);