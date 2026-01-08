function out = unmask(mask, data, fillVal, dim)
%% UNMASK Adds empty rows/cols to data (which may have been removed previously)
%% Examples
%   unmask([1 0 1 0 1 0 0 0] , (1:3) )
%   unmask([1 0 1 0 1 0 0 0] , (1:3)')
%   unmask([1 0 1 0 1 0 0 0]', (1:3) )
%   unmask([1 0 1 0 1 0 0 0]', (1:3)')
%
%   unmask([1 0 1 1 0 0 1 0], magic(4), 0)
%   unmask([1 0 1 1 0 0 1 0], magic(4), 0, 1)
%   unmask([1 0 1 1 0 0 1 0], magic(4), 0, 2)
%
%   unmask([1 0 1 0 1 1], rand(2,3,4), [], 3)
%
%   unmask([1 0 1 0 0], [1 2 3; 4 5 6])
%   unmask([1 0 1 0 1], [1 2 3; 4 5 6])
%   unmask([1 0 0 0 0], [1 2 3])
%
%
%% Usage notes
% If `dim` is not input, this functions unmasks in the first 'correct'
% dimension i.e. the first dimension where the size of that dimension is
% equal to the number of non-zero elements in `mask`.
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
assert(isvector(mask), 'mask must be a vector');

if nargin < 3 || isempty(fillVal);  fillVal = nan(class(data));  end

if nargin < 4 || isempty(dim)
    dim = find(nnz(mask)==size(data), 1, 'first'); 
    assert(~isempty(dim), sprintf(...
        'No correct dimension found for number of unmasked elements (%i)', nnz(mask)));
else
    assert(nnz(mask) == size(data, dim), sprintf(...
        'Number of unmasked elements (%i) must match size of data matrix (%i) in dimension %i', ...
        nnz(mask), size(data, dim), dim));
end


%% Allocate output
sz = size(data);
sz(dim) = numel(mask);
out = repmat(fillVal, sz); 


%% Populate output
colons = repmat({':'}, 1, ndims(data));
colons{dim} = logical(mask);
out(colons{:}) = data;


end
