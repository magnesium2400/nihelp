function s = nifti2surface(filename, isParcellation)

a = niftiread(filename);
ainfo = niftiinfo(filename);

if nargin < 2 || isempty(isParcellation); isParcellation = true; end
if ~isParcellation; a = +logical(a); end

for ii = nonzeros(unique(a))'
    b = a==ii;
    v = affineVerts(vol2xyz(b,b), ainfo.Transform.T, 1);
    c = alphaShape(v);
    d = c.alphaTriangulation;
    % [d,c.Points] = cuboidDelaunay(+b);
    e = triangulation(d, c.Points);
    f = freeBoundary(e);

    if ii == 1; F = f; V = v; R = ones(height(v),1)*ii;
    else; [V,F] = joinPatches(V,F,v,f); R = [R; ones(height(v),1)*ii]; end %#ok<AGROW>
end

s.vertices = V; 
s.faces = F; 
s.cdata = R; 

%% Comment/uncomment for visualisation
figure; 
nexttile; 
plotVolume(a); 
colorbar; axis image; view(3);

nexttile;
patch('Vertices', V, 'Faces', F, 'CData', R, 'FaceColor', 'flat', 'EdgeColor', 'none');
colorbar; axis image; view(3);

end
