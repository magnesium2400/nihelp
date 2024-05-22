function out = isElementsEqual(faces1, faces2)
%% ISELEMENTSEQUAL Compare if faces/cells/cliques in a (triangular/tetrahedral) mesh are equal
%% Examples
%   [x,y]=meshgrid(1:10); d=delaunay(x(:),y(:)); isElementsEqual(d,flipud(d)) 
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


f = @(x) sortrows(sort(x,2));
out = isequal(f(faces1), f(faces2));
end
