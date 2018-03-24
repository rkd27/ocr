function [ im, theta ] = imdeskew( src, max_angle , resolution) 
if nargin <= 1
    max_angle   = 50;  
    resolution  = 1;
elseif nargin <= 2
    resolution  = 1;
else
    %error('unsupported input format')
end
% input settings
if size( src, 3 ) > 1 
    
    gray = rgb2gray( src );
    src  = gray > graythresh( gray ) * 255;
else
    if ~islogical( src )
        
        src = src > graythresh( src ) * 255;
    end
end
% 1. extract black text pixels for analysis
[ h, w ]    = size( src );
[ text_x, text_y ] = ind2sub(  [ h,w ], find( src(:) == 0 ) );
% 2. compute the information entroy of a projection profile
angles = -max_angle : resolution : max_angle;
cx  = h/2;
cy  = w/2;
len = size( text_x, 1 );
hist_to_prob = @( h ) ( h( h ~= 0 ) / len );
score = [];
for a = angles
    sin_a = sin( a / 180 * pi );
    cos_a = cos( a / 180 * pi );
    sx    = round( ( text_x - cx ) * cos_a + ( text_y -cy ) * sin_a + cx );
    freq  = hist( sx, unique(sx) );
    prob  = hist_to_prob( freq );
    entropy = -prob .* log( prob );
    score(end+1) = sum( entropy(:) );
end
% 3. generate output
[ val, min_idx ] = min( score );
theta = -angles( min_idx );
im = not( imrotate( not( src ), theta, 'loose' ) );
b=sum((1-im).^2,3);
st = regionprops( double( b > .5 ), 'BoundingBox' );
if(st.BoundingBox)
rect = st.BoundingBox;
im=imcrop(im,rect);
end
im(1,:)=255;
end
