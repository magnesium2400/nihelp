function [mi, num, denom] = getMatchingIndex_bin(A)
%% GETMATCHINGINDEX_BIN Get matching index of binary undirected graph
%% Examples
%   getMatchingIndex_bin((pascal(5)>1).*~eye(5))
% 
% 
%% Input Arguments
% `A - adjacency matrix (square symmetric matrix)`
%
%
%% Output Arguments
% `mi - matching index` Element-wise division of `num` and `denom`, with
% diagonal elements set to 0. 
% 
% `num - two step connections`
% 
% `denom - node degrees excluding self connections`
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


num = A * A; % get weights that connect to common neighbours
denom =  sum(A,1) + sum(A,2) - A - A.'; % IMPLICIT EXPANSION, get all degrees but don't include self connections
mi = 2 * ( num ./ (denom+~num) ) .* ~eye(size(A)) ;

end

