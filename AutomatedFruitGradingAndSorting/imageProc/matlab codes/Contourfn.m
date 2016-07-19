function [ a ] = Contourfn ( bw )

%   To find the contour of a b/w image

for i = 1:size(bw,1)-1
    for j = 1:size(bw,2)-1
        if (bw(i,j)==1 && bw(i,j+1)==0)
                a1(i,j)=0;
        elseif (bw(i,j)==0 && bw(i,j+1)==1)
                a1(i,j)=0;
        else 
                a1(i,j)=1;
        end
    end
end
for i = 1:size(bw,1)-1
    for j = 1:size(bw,2)-1
        if (bw(i,j)==1 && bw(i+1,j)==0)
                a2(i,j)=0;
        elseif (bw(i,j)==0 && bw(i+1,j)==1)
                a2(i,j)=0;
        else 
                a2(i,j)=1;
        end
    end
end

for i = 1:size(bw,1)-1
    for j = 1:size(bw,2)-1
        if (a1(i,j)==0 || a2(i,j)==0)
                a(i,j)=0;
        else 
                a(i,j)=1;
        end
    end
end

a = ~a;
a = bwperim(a);
a = bwmorph(a,'thin',Inf);


end

