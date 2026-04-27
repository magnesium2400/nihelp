function out = sub2indnd(sz, inds)
%% Examples
%   sub2indn([3 3], ind2subn([3 3], (1:9)'))
%   sub2indn([3 3], ind2subn([3 3], (1:9)))
%   sub2indn([3 3 3], ind2subn([3 3 3], (1:27)'))
%
%   sub2indn([3 3 3 3], [1 1 1 1; 2 1 1 1])
%   sub2indn([3 3 3 3], [1 1 1 1])


% How to split up inds into the different components
Ds = arrayfun(@(x) ones(1,x), size(inds), 'UniformOutput', false);
dim = ndims(inds)-1;
Ds{dim} = size(inds, dim);
newinds = mat2cell(inds, Ds{:});

out = sub2ind(sz, newinds{:});

end
