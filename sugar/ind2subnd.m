function out = ind2subnd(sz, ind)
%% Examples
%   ind2subn([3 3], (1:9)')
%   ind2subn([3 3], (1:2:9))
%   ind2subn([3 3 3], (1:27)')
tmp = cell(1,numel(sz)); 
[tmp{:}] = ind2sub(sz,ind); 
out = cat(ndims1(ind)+1, tmp{:}); 
end
