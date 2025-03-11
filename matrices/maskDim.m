function out = maskDim(V, dim, mask)
%% MASKDIM Apply mask along a particular dimension of a matrix
%% Examples
%   maskDim(magic(6), 1, [0 0 1 0 0 1]')
%   maskDim(magic(6), 2, [0 0 1 0 0 1]')
%   v=ballMesh(6); V=xyz2vol(v+7,[],0); d=maskDim(V,1,diskMask(6)); 
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

sz = size(sliceDim(V,dim,1)); 
assert(all(sz == size(mask))); 

out = nan(nnz(mask), size(V,dim)); 

mask = logical(mask(:));  

for ii = 1:size(V,dim)
    temp = sliceDim(V, dim, ii); 
    out(:,ii) = temp(mask); 
end

% paren = @(a,b) a(b); 
% out = arrayfun2mat( @(ii) paren(sliceDim(V,dim,ii),mask) , 1:size(V,dim) ); 

end
