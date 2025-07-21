function out = size0(X, treatRowAndColEquivalently)
%% Examples
%   assert( size0(20) == 1 )
%   assert( size0(20000) == 1 )
%   assert( size0([1;2]) == 2 )
%   assert( size0([1,2]) == 2 )
%   assert( size0([1:9]) == 9 )
%   assert(all( size0([1:9]',0) == [9]    ))
%   assert(all( size0([1:9]',1) == [9]    ))
%   assert(all( size0([1:99],0) == [1,99] ))
%   assert(all( size0([1:99],1) == [99]   ))
%   assert(all( size0(eye(9))   == [9,9]  ))
%
%


if nargin<2; treatRowAndColEquivalently = 1; end

if      isscalar(X); out = 1;
elseif  iscolumn(X); out = numel(X); 
elseif  isrow(X)
    if  treatRowAndColEquivalently; out = numel(X); 
    else;                           out = size(X);  end
else;   out = size(X); 
end


end
