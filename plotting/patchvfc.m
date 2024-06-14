function p = patchvfc(verts, faces, cdata, varargin)
%% PATCHVFC Wrapper to plot vertices, faces, and color
%% Examples
%   [v,f] = squareMesh; figure; patchvfc(v,f); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,[],'EdgeColor','r'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(v))'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(v))', 'FaceColor', 'flat'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(f))', 'EdgeColor', 'k'); 
%   [v,f] = squareMesh; figure; [d,r] = pdist2(eye(3,2)*10, v, 'euclidean','Smallest',1); patchvfc(v,f,r','EdgeColor','r','LineWidth',2); 
%   [v,f] = sphereMesh; figure; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); patchvfc(v,f,r'); colormap autumn; 
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

a = varargin; 

if nargin < 3 || isempty(cdata)
    a = [{'FaceColor', 'none', 'EdgeColor', 'k'}, a{:}];
elseif height(cdata) == height(verts)
    a = [{'FaceColor', 'interp', 'FaceVertexCData', cdata, 'EdgeColor', 'none'}, a{:}];
elseif height(cdata) == height(faces)
    a = [{'FaceColor', 'flat', 'FaceVertexCData', cdata, 'EdgeColor', 'none'}, a{:}];
end

p = patch('Vertices', verts, 'Faces', faces, a{:});

end
