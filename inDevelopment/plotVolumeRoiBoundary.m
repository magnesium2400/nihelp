function out = plotVolumeRoiBoundary(V)


for ii = 1:max(V, [], 'all')

[x,y,z] = ind2sub(size(V), find(V==ii));
k = boundary(x,y,z,0.5);
out = trisurf(k, x, y, z, 'FaceAlpha', '0.1');
hold on;

end


end
