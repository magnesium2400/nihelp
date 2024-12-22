function surface = nifti2surface(filename, isParcellation, alphaRadius)
%% NIFTI2SURFACE Converts a NIfTI mask/parcellation to an alphaShape and surface
%% Input Arguments
% `filename - name of NIfTI file (string scalar | character vector)`
%
% `isParcellation - flag to indiciate whether NIfTI is a mask/parcellation
% or not (true (default) | false)` If the mask contains boolean or integer
% values, set this to true; otherwise set to false.
%
% `alphaRadius - radius to use for alphaShape (nonnegative scalar)` By
% default, the default parameters are used when `alphaShape` is called.
% Supplying a value to this argument allows for a different radius to be
% used when the alphaShape is generated. Higher values result in more
% smoothing.
%
%
%% Output Arguments
% `surface - structure with vertices, faces, and NIfTI data`
%
%
%% TODO
% * docs
% * consider adding more options to alphaRadius e.g. smooth per ROI, or
% make a multiple of the criticial alpha
%
%
%% See Also
% `alphaShape`
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%


%% Prelims
a = niftiread(filename);
ainfo = niftiinfo(filename);

if nargin < 2 || isempty(isParcellation); isParcellation = true; end
if ~isParcellation; a = +logical(a); end


%% alphaShape and surface for each ROI
for ii = nonzeros(unique(a))'
    % vertices in current ROI
    b = a==ii;
    v = affineVerts(vol2xyz(b,b), ainfo.Transform.T, 1);

    % alpha shape
    c = alphaShape(v);
    if nargin > 2 && ~isempty(alphaRadius); c.Alpha = alphaRadius; end
    d = c.alphaTriangulation;

    % get surface of alpha shape
    e = triangulation(d, c.Points);
    f = freeBoundary(e);

    % concatenate for outputting
    if ii == 1; F = f; V = v; R = a(b);
    else; [V,F] = joinPatches(V,F,v,f); R = [R; a(b)]; end %#ok<AGROW>
end

% output
surface.vertices = V;
surface.faces = F;
surface.cdata = R;


%% Comment/uncomment for visualisation
% figure;
% nexttile;
% plotVolume(a);
% colorbar; axis image; view(3);
% 
% nexttile;
% patch('Vertices', V, 'Faces', F, 'CData', R, 'FaceColor', 'flat', 'EdgeColor', 'none');
% colorbar; axis image; view(3);


end

