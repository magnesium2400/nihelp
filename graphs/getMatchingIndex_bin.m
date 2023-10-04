function [mi, num, denom] = getMatchingIndex_bin(A)
%GETMATCHINGINDEX Summary of this function goes here
%   input: adjacency matrix (N x N)
%   output: matching index, numerator, denominator
%           num = intersection of neighbours of u and v
%           denom = union
%           matching index = pairwise division

num = 2 * A * A; % get weights that connect to common neighbours
denom =  sum(A,1) + sum(A,2) - A - A'; % IMPLICIT EXPANSION, get all degrees but don't include self connections
mi = (num ./ (denom+~num) ) .* ~eye(size(A)) ;


end

