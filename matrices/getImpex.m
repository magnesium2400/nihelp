function out = getImpex(fromA, toB, idx)
%% GETIMPEX Gets data from A as if it had been implicitly expanded to size of B
%% Examples
%   a=reshape(1:6,3,2); b=randn(1,2,3); getImpex(a,b,[2,1,1])
%   a=reshape(1:6,3,2); b=randn(1,2,3); getImpex(a,b,[2,1,3])
%   
%   a=reshape(1:6,3,2); b=randn(1,2,3); getImpex(a,b,{2,1,1:3})
%   a=reshape(1:6,3,2); b=randn(1,2,3); getImpex(a,b,{1:3,1,2})
%   a=reshape(1:6,3,2); b=randn(1,2,3); getImpex(a,b,{2,1,':'})
%   
%   
%% See Also
%   https://au.mathworks.com/help/matlab/matlab_prog/compatible-array-sizes-for-basic-operations.html
%   https://blogs.mathworks.com/loren/2006/08/09/essence-of-indexing/
%   https://au.mathworks.com/matlabcentral/answers/2015866-why-does-accessing-a-multi-dimensional-array-with-fewer-indices-than-its-total-dimensions-not-result
%   areCompatible, impex
%
%
%% TODO
% * docs
%
%
%% Authors
% Mehul Gajwani, Monash University, 2025
%
%


% fromA=reshape(1:6,3,2); 
% toB=randn(1,2,3);
% idx = {2,1,1:3}; 


%%


[c, nd, sza, szb] = areCompatible(fromA, toB); 
assert(c, 'Arrays are not compatible sizes'); 
assert(length(idx)==nd, 'Must specify index for each dimension of the matrices'); 

if ismatrix(idx) & ~iscell(idx); idx = num2cell(idx); end
idx(end+1:nd) = {1}; 

szout = max(sza, szb);
for ii = 1:nd
    if strcmp(idx{ii},':'); idx{ii} = 1:szout(ii); end
    assert(all( idx{ii} <= szout(ii) ));

    % if looking for an index greater than the size of the current
    % dimension, default to 1 in that dimension
    idx{ii}(idx{ii}>sza(ii)) = 1;
end

out = fromA(idx{:});


end

