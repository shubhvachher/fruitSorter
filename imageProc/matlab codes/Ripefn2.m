function [ rr, rg  ] = Ripefn2( i )
% Function to find if a fruit is ripe or not
r = i(:,:,1);
g = i(:,:,2);
b = i(:,:,3);
tr = sum(sum(r));
tb = sum(sum(b));
tg = sum(sum(g));
rg = tr/tg;
rr = tr*100/(tr+tg+tb);
gg = tg*100/(tr+tg+tb);
bb = tb*100/(tr+tg+tb);

k1 = 0.95;
k2 = 0.85;

if(rg>k1)
    disp('Ripe');
elseif(k2<rg && rg<k1)
    disp('Moderately ripe');
elseif(rg<k2)
    disp('Unripe');
end

end

