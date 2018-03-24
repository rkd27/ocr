function l=liness(i)
l=struct('line',[]);
k=1;
[xmax,ymax]=size(i);
mat=sum(i,2);
lines=find(mat==ymax);
for j=1:size(lines)-1
    
    if lines(j)+1~=lines(j+1)
        rect=[0 lines(j) ymax (lines(j+1)-lines(j))];
        l(k).line=imcrop(i,rect);
        l(k).line=imresize(l(k).line,[1350 4500]);
        
        k=k+1;
    end
   
    
end

end
