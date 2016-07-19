function [ c ] = pdfclassifyfn( t1,fa,fb,fc,fd,fe )
%Classifies using PDA a sample image into one of the 5 classes

t1 = fruitfilter(t1);
hsvt1 = rgb2hsv(t1);
ht1 = hsvt1(:,:,1);
ht1= ht1*255;
ht1 = nonzeros(ht1);
[ft bt] = hist(ht1,100);
ft = ft./sum(ft);

x(1) = corr(fa',ft');
x(2) = corr(fb',ft');
x(3) = corr(fc',ft');
x(4) = corr(fd',ft');
x(5) = corr(fe',ft');

l = max(x);
    
if l == x(1)
    disp('sample belongs to class A of oranges');
    cls = 1;
elseif l == x(2)
    disp('sample belongs to class B of oranges');
    cls = 2;
elseif l == x(3)
    cls = 3;
    disp('sample belongs to class C of oranges');
elseif l == x(4)
    cls = 4;
    disp('sample belongs to class of Sathukudi');
elseif l == x(5)
    disp('sample belongs to class of Lemon');
    cls = 5;
end


end

