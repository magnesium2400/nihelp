function [out, mask] = getUnrepeatedRows(data)
%% GETUNREPEATEDROWS Gets rows which occur exactly once in a matrix
%% Examples
%   getUnrepeatedRows([1 2 3; 4 5 6; 1 2 3])
%   [a,m] = getUnrepeatedRows([1 2 3; 4 5 6; 1 2 3])
%   [a,m] = getUnrepeatedRows([1 2 3; 7 8 9; 4 5 6; 1 2 3])
%   getUnrepeatedRows([1 2 3; 1 2 3; 4 5 6; 4 5 6])
%   getUnrepeatedRows(kron([1;1;2],eye(3)))
%   v = rand(100,2); f = delaunay(v); e = getUnrepeatedRows(sort(decreaseSimplexDimension(f),2)); figure; plotLines(v(e(:,1),:),v(e(:,2),:)); 
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

[dataSorted,idx] = sortrows(data);

diffs = diff(dataSorted,1,1);
diffToAdjacent = any(diffs,2);
mask = [1;diffToAdjacent] & [diffToAdjacent;1]; % diffToPrev and diffToNext

tmp = sort(idx(mask)); 
out = data(tmp,:); 
mask = full(sparse(tmp,1,true,length(idx),1)); 

end
