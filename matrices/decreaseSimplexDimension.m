function out = decreaseSimplexDimension(faces)
%% DECREASESIMPLEXDIMENSION Decrease dimensionality of e.g. surface triangulation
%% Examples
%   v = rand(100,2); f = delaunay(v); e = decreaseSimplexDimension(f); 
%   v = rand(100,3); f = delaunay(v); e = decreaseSimplexDimension(f); 
%   v = rand(100,2); f = delaunay(v); e = decreaseSimplexDimension(f); figure; plotLines(v(e(:,1),:),v(e(:,2),:)); 
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


[m,n] = size(faces);
out = nan(m*n, n-1);

for ii = 1:n
    xidx = (1:m)+(ii-1)*m;
    yidx = setdiff(1:n, n+1-ii);
    out(xidx,:) = faces(:, yidx);
end



end
