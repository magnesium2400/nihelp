function spinGif(f, outfile, nFrames, nRevs, delayTime)

if nargin<3; nFrames = 20;     end
if nargin<4; nRevs = 1;        end
if nargin<5; delayTime = 0.04; end

ax = findobj(gcf().Children, 'type', 'axes'); 
assert(numel(ax)==1, 'Figures with multiple axes not supported'); 

cvam = get(ax, 'CameraViewAngleMode');
set(ax, 'CameraViewAngleMode', 'Manual');
v = ax.View;
az = v(1); el = v(2);

for ii = 1:(nFrames*nRevs)
    
    view(ax, az+(360/nFrames)*ii, el);
    frame = getframe(f); 
    [cdata, map] = rgb2ind(frame2im(frame),256);

    if ii == 1
        imwrite(cdata, map, outfile, 'gif', 'LoopCount', Inf, 'DelayTime', delayTime);
    else
        imwrite(cdata, map, outfile, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
    end

end

set(ax, 'CameraViewAngleMode', cvam);

end
