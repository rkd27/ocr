function f=Noise(i)

if size(i,3)==3
f=rgb2gray(i);
else 
    f=i;
end

%i=imadjust(i,stretchlim(i),[]);

%f=imgaussfilt(i);

f=imbinarize(f,graythresh(f));
f=medfilt2(f);

f=imcomplement(imclearborder(imcomplement(f),8));
f=imerode(f,strel('disk',1));
f=imdilate(f,strel('disk',1));



end

