function s=border_detect_resize_32_20(i)
%i=im2double(i);
b=sum((1-i).^2,3);
st = regionprops( double( b > .5 ), 'BoundingBox' );
if(st.BoundingBox)
rect = st.BoundingBox;
s=imcrop(i,rect);
end
s=imresize(s,[32 20]);
end