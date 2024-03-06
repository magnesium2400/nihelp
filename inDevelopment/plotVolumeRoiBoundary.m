function out = plotVolumeRoiBoundary(V, data)

if nargin < 2; data = 1:max(V, [], 'all'); end

r = nonzeros(unique(V));
out = gobjects(max(r), 1);

for ii = 1:length(r)

    [x,y,z] = ind2sub(size(V), find(V==r(ii)));

    if numel(x) == 1 % plot small sphere
        [a,b,c] = sphere;
        out(r(ii)) = surf(0.1*a+x, 0.1*b+y, 0.1*c+z, ...
            'EdgeColor', 'none',  'CData', data(ii), 'FaceColor', 'texturemap', 'FaceAlpha', 0.1);
        hold on;
        continue;
    elseif numel(x) == 2 % plot line
        out(r(ii)) = patch(x, y, z, data(ii)*[1 1], ...
            'EdgeColor', 'flat', 'FaceColor', 'none');
        hold on;
        continue;
    end

    if numel(x) == 3 % triangle - always in a plane
        k = [1 2 3];
    else
        k = boundary(x,y,z,0.5);
        while isempty(k) % if in a  plane or line - add jitter to get faces
            addrandn = @(A) A+randn(size(A));
            k = boundary(addrandn(x), addrandn(y), addrandn(z), 0.5);
        end
    end

    % plot mesh
    out(r(ii)) = trisurf(k, x, y, z, ...
        'CData', data(ii)*ones(numel(x),1), 'FaceAlpha', '0.1', 'EdgeColor', 'flat');
    hold on;

end

axis('equal', 'tight');
xlabel('x'); ylabel('y'); zlabel('z');

end
