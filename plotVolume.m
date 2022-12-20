function plotVolume(vol, varargin)

[x,y,z] = ind2sub(size(vol), find(vol));
scatter3(x, y, z, varargin{:});

axis equal

xlabel('x'); ylabel('y'); zlabel('z');
xlim([1, size(vol, 1)]); ylim([1, size(vol, 2)]); zlim([1, size(vol, 3)]);

end




