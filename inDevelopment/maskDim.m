function out = maskDim(V, dim, mask)

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
