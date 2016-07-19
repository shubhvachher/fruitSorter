%class a
a1 = imread('D:\matlab files\LDA\Oranges\11A.bmp');
a1 = fruitfilter(a1);
hsva1 = rgb2hsv(a1);
ha1 = hsva1(:,:,1);
ha1 = ha1*255;
ha1 = nonzeros(ha1);
[fa1 ba1] = hist(ha1,100); 
fa1 = fa1./sum(fa1);

a2 = imread('D:\matlab files\LDA\Oranges\11B.bmp');
a2 = fruitfilter(a2);
hsva2 = rgb2hsv(a2);
ha2 = hsva2(:,:,1);
ha2 = ha2*255;
ha2 = nonzeros(ha2);
[fa2 ba2] = hist(ha2,100); 
fa2 = fa2./sum(fa2);

a3 = imread('D:\matlab files\LDA\Oranges\11C.bmp');
a3 = fruitfilter(a3);
hsva3 = rgb2hsv(a3);
ha3 = hsva3(:,:,1);
ha3 = ha3*255;
ha3 = nonzeros(ha3);
[fa3 ba3] = hist(ha3,100); 
fa3 = fa3./sum(fa3);

a4 = imread('D:\matlab files\LDA\Oranges\11D.bmp');
a4 = fruitfilter(a4);
hsva4 = rgb2hsv(a4);
ha4 = hsva4(:,:,1);
ha4 = ha4*255;
ha4 = nonzeros(ha4);
[fa4 ba4] = hist(ha4,100); 
fa4 = fa4./sum(fa4);

a5 = imread('D:\matlab files\LDA\Oranges\11E.bmp');
a5 = fruitfilter(a5);
hsva5 = rgb2hsv(a5);
ha5 = hsva5(:,:,1);
ha5 = ha5*255;
ha5 = nonzeros(ha5);
[fa5 ba5] = hist(ha5,100); 
fa5 = fa5./sum(fa5);

a6 = imread('D:\matlab files\LDA\Oranges\2A.bmp');
a6 = fruitfilter(a6);
hsva6 = rgb2hsv(a6);
ha6 = hsva6(:,:,1);
ha6 = ha6*255;
ha6 = nonzeros(ha6);
[fa6 ba6] = hist(ha6,100); 
fa6 = fa6./sum(fa6);

a7 = imread('D:\matlab files\LDA\Oranges\2B.bmp');
a7 = fruitfilter(a7);
hsva7 = rgb2hsv(a7);
ha7 = hsva7(:,:,1);
ha7 = ha7*255;
ha7 = nonzeros(ha7);
[fa7 ba7] = hist(ha7,100); 
fa7 = fa7./sum(fa7);

a8 = imread('D:\matlab files\LDA\Oranges\2C.bmp');
a8 = fruitfilter(a8);
hsva8 = rgb2hsv(a8);
ha8 = hsva8(:,:,1);
ha8 = ha8*255;
ha8 = nonzeros(ha8);
[fa8 ba8] = hist(ha8,100); 
fa8 = fa8./sum(fa8);

a9 = imread('D:\matlab files\LDA\Oranges\2D.bmp');
a9 = fruitfilter(a9);
hsva9 = rgb2hsv(a9);
ha9 = hsva9(:,:,1);
ha9 = ha9*255;
ha9 = nonzeros(ha9);
[fa9 ba9] = hist(ha9,100); 
fa9 = fa9./sum(fa9);

a10 = imread('D:\matlab files\LDA\Oranges\2E.bmp');
a10 = fruitfilter(a10);
hsva10 = rgb2hsv(a10);
ha10 = hsva10(:,:,1);
ha10 = ha10*255;
ha10 = nonzeros(ha10);
[fa10 ba10] = hist(ha10,100); 
fa10 = fa10./sum(fa10);

fa = (fa1+fa2+fa3+fa4+fa5+fa6+fa7+fa8+fa9+fa10)/10;
ba = (ba1+ba2+ba3+ba4+ba5+ba6+ba7+ba8+ba9+ba10)/10;

%class b
b1 = imread('D:\matlab files\LDA\Oranges\14A.bmp');
b1 = fruitfilter(b1);
hsvb1 = rgb2hsv(b1);
hb1 = hsvb1(:,:,1);
hb1 = hb1*255;
hb1 = nonzeros(hb1);
[fb1 bb1] = hist(hb1,100); 
fb1 = fb1./sum(fb1);

b2 = imread('D:\matlab files\LDA\Oranges\14B.bmp');
b2 = fruitfilter(b2);
hsvb2 = rgb2hsv(b2);
hb2 = hsvb2(:,:,1);
hb2 = hb2*255;
hb2 = nonzeros(hb2);
[fb2 bb2] = hist(hb2,100); 
fb2 = fb2./sum(fb2);

b3 = imread('D:\matlab files\LDA\Oranges\14C.bmp');
b3 = fruitfilter(b3);
hsvb3 = rgb2hsv(b3);
hb3 = hsvb3(:,:,1);
hb3 = hb3*255;
hb3 = nonzeros(hb3);
[fb3 bb3] = hist(hb3,100); 
fb3 = fb3./sum(fb3);

b4 = imread('D:\matlab files\LDA\Oranges\14D.bmp');
b4 = fruitfilter(b4);
hsvb4 = rgb2hsv(b4);
hb4 = hsvb4(:,:,1);
hb4 = hb4*255;
hb4 = nonzeros(hb4);
[fb4 bb4] = hist(hb4,100); 
fb4 = fb4./sum(fb4);

b5 = imread('D:\matlab files\LDA\Oranges\14E.bmp');
b5 = fruitfilter(b5);
hsvb5 = rgb2hsv(b5);
hb5 = hsvb5(:,:,1);
hb5 = hb5*255;
hb5 = nonzeros(hb5);
[fb5 bb5] = hist(hb5,100); 
fb5 = fb5./sum(fb5);

b6 = imread('D:\matlab files\LDA\Oranges\21A.bmp');
b6 = fruitfilter(b6);
hsvb6 = rgb2hsv(b6);
hb6 = hsvb6(:,:,1);
hb6 = hb6*255;
hb6 = nonzeros(hb6);
[fb6 bb6] = hist(hb6,100); 
fb6 = fb6./sum(fb6);

b7 = imread('D:\matlab files\LDA\Oranges\21B.bmp');
b7 = fruitfilter(b7);
hsvb7 = rgb2hsv(b7);
hb7 = hsvb7(:,:,1);
hb7 = hb7*255;
hb7 = nonzeros(hb7);
[fb7 bb7] = hist(hb7,100); 
fb7 = fb7./sum(fb7);

b8 = imread('D:\matlab files\LDA\Oranges\21C.bmp');
b8 = fruitfilter(b8);
hsvb8 = rgb2hsv(b8);
hb8 = hsvb8(:,:,1);
hb8 = hb8*255;
hb8 = nonzeros(hb8);
[fb8 bb8] = hist(hb8,100); 
fb8 = fb8./sum(fb8);

b9 = imread('D:\matlab files\LDA\Oranges\21D.bmp');
b9 = fruitfilter(b9);
hsvb9 = rgb2hsv(b9);
hb9 = hsvb9(:,:,1);
hb9 = hb9*255;
hb9 = nonzeros(hb9);
[fb9 bb9] = hist(hb9,100); 
fb9 = fb9./sum(fb9);

b10 = imread('D:\matlab files\LDA\Oranges\21E.bmp');
b10 = fruitfilter(b10);
hsvb10 = rgb2hsv(b10);
hb10 = hsvb10(:,:,1);
hb10 = hb10*255;
hb10 = nonzeros(hb10);
[fb10 bb10] = hist(hb10,100); 
fb10 = fb10./sum(fb10);

fb = (fb1+fb2+fb3+fb4+fb5+fb6+fb7+fb8+fb9+fb10)/10;
bb = (bb1+bb2+bb3+bb4+bb5+bb6+bb7+bb8+bb9+bb10)/10;



%class c
c1 = imread('D:\matlab files\LDA\Oranges\15A.bmp');
c1 = fruitfilter(c1);
hsvc1 = rgb2hsv(c1);
hc1 = hsvc1(:,:,1);
hc1 = hc1*255;
hc1 = nonzeros(hc1);
[fc1 bc1] = hist(hc1,100); 
fc1 = fc1./sum(fc1);

c2 = imread('D:\matlab files\LDA\Oranges\15B.bmp');
c2 = fruitfilter(c2);
hsvc2 = rgb2hsv(c2);
hc2 = hsvc2(:,:,1);
hc2 = hc2*255;
hc2 = nonzeros(hc2);
[fc2 bc2] = hist(hc2,100); 
fc2 = fc2./sum(fc2);


c3 = imread('D:\matlab files\LDA\Oranges\15C.bmp');
c3 = fruitfilter(c3);
hsvc3 = rgb2hsv(c3);
hc3 = hsvc3(:,:,1);
hc3 = hc3*255;
hc3 = nonzeros(hc3);
[fc3 bc3] = hist(hc3,100); 
fc3 = fc3./sum(fc3);

c4 = imread('D:\matlab files\LDA\Oranges\15D.bmp');
c4 = fruitfilter(c4);
hsvc4 = rgb2hsv(c4);
hc4 = hsvc4(:,:,1);
hc4 = hc4*255;
hc4 = nonzeros(hc4);
[fc4 bc4] = hist(hc4,100); 
fc4 = fc4./sum(fc4);

c5 = imread('D:\matlab files\LDA\Oranges\15E.bmp');
c5 = fruitfilter(c5);
hsvc5 = rgb2hsv(c5);
hc5 = hsvc5(:,:,1);
hc5 = hc5*255;
hc5 = nonzeros(hc5);
[fc5 bc5] = hist(hc5,100); 
fc5 = fc5./sum(fc5);

c6 = imread('D:\matlab files\LDA\Oranges\18A.bmp');
c6 = fruitfilter(c6);
hsvc6 = rgb2hsv(c6);
hc6 = hsvc6(:,:,1);
hc6 = hc6*255;
hc6 = nonzeros(hc6);
[fc6 bc6] = hist(hc6,100); 
fc6 = fc6./sum(fc6);

c7 = imread('D:\matlab files\LDA\Oranges\18B.bmp');
c7 = fruitfilter(c7);
hsvc7 = rgb2hsv(c7);
hc7 = hsvc7(:,:,1);
hc7 = hc7*255;
hc7 = nonzeros(hc7);
[fc7 bc7] = hist(hc7,100); 
fc7 = fc7./sum(fc7);

c8 = imread('D:\matlab files\LDA\Oranges\18C.bmp');
c8 = fruitfilter(c8);
hsvc8 = rgb2hsv(c8);
hc8 = hsvc8(:,:,1);
hc8 = hc8*255;
hc8 = nonzeros(hc8);
[fc8 bc8] = hist(hc8,100); 
fc8 = fc8./sum(fc8);

c9 = imread('D:\matlab files\LDA\Oranges\18D.bmp');
c9 = fruitfilter(c9);
hsvc9 = rgb2hsv(c9);
hc9 = hsvc9(:,:,1);
hc9 = hc9*255;
hc9 = nonzeros(hc9);
[fc9 bc9] = hist(hc9,100); 
fc9 = fc9./sum(fc9);

c10 = imread('D:\matlab files\LDA\Oranges\18E.bmp');
c10 = fruitfilter(c10);
hsvc10 = rgb2hsv(c10);
hc10 = hsvc10(:,:,1);
hc10 = hc10*255;
hc10 = nonzeros(hc10);
[fc10 bc10] = hist(hc10,100); 
fc10 = fc10./sum(fc10);

fc = (fc1+fc2+fc3+fc4+fc5+fc6+fc7+fc8+fc9+fc10)/10;
bc = (bc1+bc2+bc3+bc4+bc5+bc6+bc7+bc8+bc9+bc10)/10;

%class d
d1 = imread('D:\matlab files\LDA\Sathukudi\1A.bmp');
d1 = fruitfilter(d1);
hsvd1 = rgb2hsv(d1);
hd1 = hsvd1(:,:,1);
hd1 = hd1*255;
hd1 = nonzeros(hd1);
[fd1 bd1] = hist(hd1,100); 
fd1 = fd1./sum(fd1);

d2 = imread('D:\matlab files\LDA\Sathukudi\1B.bmp');
d2 = fruitfilter(d2);
hsvd2 = rgb2hsv(d2);
hd2 = hsvd2(:,:,1);
hd2 = hd2*255;
hd2 = nonzeros(hd2);
[fd2 bd2] = hist(hd2,100); 
fd2 = fd2./sum(fd2);

d3 = imread('D:\matlab files\LDA\Sathukudi\1C.bmp');
d3 = fruitfilter(d3);
hsvd3 = rgb2hsv(d3);
hd3 = hsvd3(:,:,1);
hd3 = hd3*255;
hd3 = nonzeros(hd3);
[fd3 bd3] = hist(hd3,100); 
fd3 = fd3./sum(fd3);

d4 = imread('D:\matlab files\LDA\Sathukudi\1D.bmp');
d4 = fruitfilter(d4);
hsvd4 = rgb2hsv(d4);
hd4 = hsvd4(:,:,1);
hd4 = hd4*255;
hd4 = nonzeros(hd4);
[fd4 bd4] = hist(hd4,100); 
fd4 = fd4./sum(fd4);

d5 = imread('D:\matlab files\LDA\Sathukudi\1E.bmp');
d5 = fruitfilter(d5);
hsvd5 = rgb2hsv(d5);
hd5 = hsvd5(:,:,1);
hd5 = hd5*255;
hd5 = nonzeros(hd5);
[fd5 bd5] = hist(hd5,100); 
fd5 = fd5./sum(fd5);

d6 = imread('D:\matlab files\LDA\Sathukudi\2A.bmp');
d6 = fruitfilter(d6);
hsvd6 = rgb2hsv(d6);
hd6 = hsvd6(:,:,1);
hd6 = hd6*255;
hd6 = nonzeros(hd6);
[fd6 bd6] = hist(hd6,100); 
fd6 = fd6./sum(fd6);

d7 = imread('D:\matlab files\LDA\Sathukudi\2B.bmp');
d7 = fruitfilter(d7);
hsvd7 = rgb2hsv(d7);
hd7 = hsvd7(:,:,1);
hd7 = hd7*255;
hd7 = nonzeros(hd7);
[fd7 bd7] = hist(hd7,100); 
fd7 = fd7./sum(fd7);

d8 = imread('D:\matlab files\LDA\Sathukudi\2C.bmp');
d8 = fruitfilter(d8);
hsvd8 = rgb2hsv(d8);
hd8 = hsvd8(:,:,1);
hd8 = hd8*255;
hd8 = nonzeros(hd8);
[fd8 bd8] = hist(hd8,100); 
fd8 = fd8./sum(fd8);

d9 = imread('D:\matlab files\LDA\Sathukudi\2D.bmp');
d9 = fruitfilter(d9);
hsvd9 = rgb2hsv(d9);
hd9 = hsvd9(:,:,1);
hd9 = hd9*255;
hd9 = nonzeros(hd9);
[fd9 bd9] = hist(hd9,100); 
fd9 = fd9./sum(fd9);

d10 = imread('D:\matlab files\LDA\Sathukudi\2E.bmp');
d10 = fruitfilter(d10);
hsvd10 = rgb2hsv(d10);
hd10 = hsvd10(:,:,1);
hd10 = hd10*255;
hd10 = nonzeros(hd10);
[fd10 bd10] = hist(hd10,100); 
fd10 = fd10./sum(fd10);

fd = (fd1+fd2+fd3+fd4+fd5+fd6+fd7+fd8+fd9+fd10)/10;
bd = (bd1+bd2+bd3+bd4+bd5+bd6+bd7+bd8+bd9+bd10)/10;

%class e
e1 = imread('D:\matlab files\LDA\Lemon\1A.bmp');
e1 = fruitfilter(e1);
hsve1 = rgb2hsv(e1);
he1 = hsve1(:,:,1);
he1 = he1*255;
he1 = nonzeros(he1);
[fe1 be1] = hist(he1,100); 
fe1 = fe1./sum(fe1);

e2 = imread('D:\matlab files\LDA\Lemon\1B.bmp');
e2 = fruitfilter(e2);
hsve2 = rgb2hsv(e2);
he2 = hsve2(:,:,1);
he2 = he2*255;
he2 = nonzeros(he2);
[fe2 be2] = hist(he2,100); 
fe2 = fe2./sum(fe2);

e3 = imread('D:\matlab files\LDA\Lemon\1C.bmp');
e3 = fruitfilter(e3);
hsve3 = rgb2hsv(e3);
he3 = hsve3(:,:,1);
he3 = he3*255;
he3 = nonzeros(he3);
[fe3 be3] = hist(he3,100); 
fe3 = fe3./sum(fe3);

e4 = imread('D:\matlab files\LDA\Lemon\1D.bmp');
e4 = fruitfilter(e4);
hsve4 = rgb2hsv(e4);
he4 = hsve4(:,:,1);
he4 = he4*255;
he4 = nonzeros(he4);
[fe4 be4] = hist(he4,100); 
fe4 = fe4./sum(fe4);

e5 = imread('D:\matlab files\LDA\Lemon\1E.bmp');
e5 = fruitfilter(e5);
hsve5 = rgb2hsv(e5);
he5 = hsve5(:,:,1);
he5 = he5*255;
he5 = nonzeros(he5);
[fe5 be5] = hist(he5,100); 
fe5 = fe5./sum(fe5);

e6 = imread('D:\matlab files\LDA\Lemon\2A.bmp');
e6 = fruitfilter(e6);
hsve6 = rgb2hsv(e6);
he6 = hsve6(:,:,1);
he6 = he6*255;
he6 = nonzeros(he6);
[fe6 be6] = hist(he6,100); 
fe6 = fe6./sum(fe6);

e7 = imread('D:\matlab files\LDA\Lemon\2B.bmp');
e7 = fruitfilter(e7);
hsve7 = rgb2hsv(e7);
he7 = hsve7(:,:,1);
he7 = he7*255;
he7 = nonzeros(he7);
[fe7 be7] = hist(he7,100); 
fe7 = fe7./sum(fe7);

e8 = imread('D:\matlab files\LDA\Lemon\2C.bmp');
e8 = fruitfilter(e8);
hsve8 = rgb2hsv(e8);
he8 = hsve8(:,:,1);
he8 = he8*255;
he8 = nonzeros(he8);
[fe8 be8] = hist(he8,100); 
fe8 = fe8./sum(fe8);

e9 = imread('D:\matlab files\LDA\Lemon\2D.bmp');
e9 = fruitfilter(e9);
hsve9 = rgb2hsv(e9);
he9 = hsve9(:,:,1);
he9 = he9*255;
he9 = nonzeros(he9);
[fe9 be9] = hist(he9,100); 
fe9 = fe9./sum(fe9);

e10 = imread('D:\matlab files\LDA\Lemon\2E.bmp');
e10 = fruitfilter(e10);
hsve10 = rgb2hsv(e10);
he10 = hsve10(:,:,1);
he10 = he10*255;
he10 = nonzeros(he10);
[fe10 be10] = hist(he10,100);
fe10 = fe10./sum(fe10);


fe = (fe1+fe2+fe3+fe4+fe5+fe6+fe7+fe8+fe9+fe10)/10;
be = (be1+be2+be3+be4+be5+be6+be7+be8+be9+be10)/10;


%fruit sample


I1 = imread('D:\Matlab files\LDA\Samples\39e.bmp');
c(1) = pdfclassifyfn(I1,fa,fb,fc,fd,fe);

I2 = imread('D:\Matlab files\LDA\Samples\10c.bmp');
c(2) = pdfclassifyfn(I2,fa,fb,fc,fd,fe);

I3 = imread('D:\Matlab files\LDA\Samples\23e.bmp');
c(3) = pdfclassifyfn(I3,fa,fb,fc,fd,fe);

I4 = imread('D:\Matlab files\LDA\Samples\19c.bmp');
c(4) = pdfclassifyfn(I4,fa,fb,fc,fd,fe);

I5 = imread('D:\Matlab files\LDA\Samples\14d.bmp');
c(5) = pdfclassifyfn(I5,fa,fb,fc,fd,fe);

I6 = imread('D:\Matlab files\LDA\Samples\9b.bmp');
c(6) = pdfclassifyfn(I6,fa,fb,fc,fd,fe);

I7 = imread('D:\Matlab files\LDA\Samples\12c.bmp');
c(7) = pdfclassifyfn(I7,fa,fb,fc,fd,fe);

I8 = imread('D:\Matlab files\LDA\Samples\4d.bmp');
c(8) = pdfclassifyfn(I8,fa,fb,fc,fd,fe);

I9 = imread('D:\Matlab files\LDA\Samples\20c.bmp');
c(9) = pdfclassifyfn(I9,fa,fb,fc,fd,fe);

I10 = imread('D:\Matlab files\LDA\Samples\42c.bmp');
c(10) = pdfclassifyfn(I10,fa,fb,fc,fd,fe);

I11 = imread('D:\Matlab files\LDA\Samples\1b.bmp');
c(11) = pdfclassifyfn(I11,fa,fb,fc,fd,fe);

I12 = imread('D:\Matlab files\LDA\Samples\22c.bmp');
c(12) = pdfclassifyfn(I12,fa,fb,fc,fd,fe);

I13 = imread('D:\Matlab files\LDA\Samples\23b.bmp');
c(13) = pdfclassifyfn(I13,fa,fb,fc,fd,fe);

I14 = imread('D:\Matlab files\LDA\Samples\7b.bmp');
c(14) = pdfclassifyfn(I14,fa,fb,fc,fd,fe);

I15 = imread('d:\matlab files\lda\samples\25c.bmp');
c(15) = pdfclassifyfn(I15,fa,fb,fc,fd,fe);

% %sample plot
% plot(ba,fa,'linewidth',1.3);
% hold on;
% plot(bb,fb,'color','m','linewidth',1.3);
% plot(bc,fc,'color','g','linewidth',1.3);
% plot(bd,fd,'color','c','linewidth',1.3);
% plot(be,fe,'color','k','linewidth',1.3);
% plot(bt,ft,'color','r','linewidth',2);