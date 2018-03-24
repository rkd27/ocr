function wordss(l,fid)
w=struct('word',[]);
k=1;
[x,no_lines]=size(l);
t=1;
currStr='';

%[a,b]=size(l(1).line);
spcp=1;
for g=1:no_lines
    last=1;
    f=0;
    b=sum((1-l(g).line).^2,3);
    st = regionprops( double( b > .5 ), 'BoundingBox' );
    if(st.BoundingBox)
        rect = st.BoundingBox;
        l(g).line=imcrop(l(g).line,rect);
    end
    [xmax,ymax]=size(l(g).line);
    mat=sum(l(g).line);
    words=find(mat==xmax);
    [p,q]=size(words);
   
    o=0;
    t=1;
    
    for j=1:q-1
        c=0;
        r=j;
            while words(r)+1==words(r+1) && r<q-1
                c=c+1;
                r=r+1;
            end
        o(t)=c;
        t=t+1;
        
    end
    
    a=[];
    for j=1:t-2
        if o(1)~=0 && j==1
            a=[a o(j)];
            
        
        elseif o(j)==0
            a=[a o(j+1)];
            
        end
    end
    
    a=sort(a,'desc');
    
    [x,no]=size(a);
    for j=1:no-1
        for d=j:no-1
        while a(j)==a(d+1) && a(j)~=0
          a=[a(1:d) a(d+2:end)];
          a(end+1)=0;
        end
        end
        
    end
    [x,no]=size(a);
    if no==1
       d=a(1);
    elseif no>=2
        d=a(2);
    else
        d=1500;
    end
    if j>=4
    j=3;
    [y,x]=size(a);
    
    while (a(j)>=(floor((a(j-2)+a(j+2))/2))) && j<(x-3)
        d=a(j);
        
        j=j+1;
    end
    
    spc=d;
    else
        spc=d;
    end
    c=0;

    
   if g>=1 && max(o)>=spcp
        
    
    
    spc1=uint16(spc-1);
     for j=spc:q-1
        if words(j)-words(j-spc1)==spc1
            rect=[last 0 (words(j-spc1)-last) xmax];
            c=words(j-spc1);
            if c-last>=1
                last=words(j);
                w(k).word=imcrop(l(g).line,rect);
                  
                r=result(w(k).word);
             %   r=num2str(r);
                if f==0
                     currStr=[currStr r];
                     f=1;
                else
                currStr=[currStr ' ' r];
                end
                k=k+1;
            end
        end
        if j==q-1
            rect=[last 0 ymax-last xmax];
            w(k).word=imcrop(l(g).line,rect);
            r=result(w(k).word);
            %r=num2str(r);
            
            
            currStr=[currStr ' ' r];
            
            k=k+1;
        end
     end
    else
        w(k).word=l(g).line;
        r=result(w(k).word);
        %r=num2str(r);
        if f==0
            currStr=[currStr r];
            f=1;
        else
        currStr=[currStr ' ' r];
        end
        k=k+1;
   end
    fprintf(fid,currStr);
    fprintf(fid,'\n');
    currStr='';
   if spcp==1 
    spcp=spc;
   elseif spcp>spc
       spcp=spc;
   end
 
end
end