function r=result(i)
load 'C:\Users\Rajat\Desktop\fnt data\covnetBin'
let=struct('letter',[]);
r=[];
k=1;
[xmax,ymax]=size(i);
mat=sum(i);
letters=find(mat==xmax);
[p,q]=size(letters);

for j=1:q-1
    if letters(j)+1~=letters(j+1)
        rect=[letters(j) 0 letters(j+1)-letters(j) xmax];
        let(k).letter=imcrop(i,rect);
        
        k=k+1;
    end
    if letters(1)~=1&&j==1
        rect=[0 0 letters(1) xmax];
        let(k).letter=imcrop(i,rect);
        k=k+1;
    end
end

for j=1:k
try
    x1=classify(covnetBin,uint8(border_detect_resize_32_20(let(j).letter)));
    r(j)=x1;
    if r(j)<=10
        r(j)=char(r(j)+47);
    elseif r(j)<=36
        r(j)=char(r(j)+54);
    elseif r(j)<=62
        r(j)=char(r(j)+60);
    end
catch
end

end
end
