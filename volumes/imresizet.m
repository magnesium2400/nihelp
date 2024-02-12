function out = imresizet(V, scale, varargin)
%% IMRESIZE Resize all but the last (time) dimension of a 3D or 4D matrix
%% Examples
%   figure; nexttile; plotVolume(loadmri); nexttile; plotVolume(imresizet(loadmri, 2));
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 





%% Prelims
nd = ndims(V); nt = size(V, nd); % nTimepoints
if nd == 3; f = @imresize; elseif nd == 4; f = @imresize3; end


%% Do first slice and get size
colons = repmat({':'}, 1, nd);
colons{nd} = 1;

slice = f(V(colons{:}), scale, varargin{:});
sz = size(slice);
out = nan([sz, nt]);
out(colons{:}) = slice;


%% Loop over remaining slices (faster than arrayfun)
for ii = 2:nt
    colons{nd} = ii;
    out(colons{:}) = f(V(colons{:}), scale, varargin{:});
end


end
