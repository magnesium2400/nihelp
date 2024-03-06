function spinGif(f, outfile, nFrames, nRevs)
if nargin<3; nFrames = 20; end
if nargin<4; nRevs = 1; end

ax = f.Children;
v = ax.View;
az = v(1); el = v(2);

for ii = 1:(nFrames*nRevs)
    view(ax, az+(360/nFrames)*ii, el);
    exportgraphics(f, outfile, "Append", ii ~= 1);
end


end
