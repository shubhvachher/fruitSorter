
t1 = imread('d:\matlab files\lda\samples\1d.bmp');
t1 = fruitfilter(t1);
hsvt1 = rgb2hsv(t1);
ht1 = hsvt1(:,:,1);
ht1= ht1*255;
ht1 = nonzeros(ht1);

plot(ba,fa);
hold on;
plot(bb,fb,'color','r');
hold on;
plot(bc,fc,'color','g');
hold on;
plot(bd,fd,'color','m');
hold on;
plot(be,fe,'color','c');

%sample plot
plot(ba,fa,'linewidth',1.3);
hold on;
plot(bb,fb,'color','m','linewidth',1.3);
plot(bc,fc,'color','g','linewidth',1.3);
plot(bd,fd,'color','y','linewidth',1.3);
plot(be,fe,'color','c','linewidth',1.3);
plot(bt,ft,'color','r','linewidth',2);



plot(ba,fa,'linewidth',1.3)
figure,plot(bb,fb,'linewidth',1.3)
figure,plot(bc,fc,'linewidth',1.3)
figure,plot(bd,fd,'linewidth',1.3)
figure,plot(be,fe,'linewidth',1.3)



c7 = imread('D:\matlab files\LDA\Oranges\19b.bmp');
c7 = fruitfilter(c7);
hsvc7 = rgb2hsv(c7);
hc7 = hsvc7(:,:,1);
hc7 = hc7*255;
hc7 = nonzeros(hc7);
[fc7 bc7] = hist(hc7,100); 
fc7 = fc7./sum(fc7);