function [a, m, n, d] = updateMatching(a, m, n, d, ii, jj)
%% UPDATEMATCHING Compute matching index by only making changes when edge added
%% Syntax
%  [~,m] = updateMatching(a)
%  [a,m,n,d] = updateMatching(a,m,n,d,ii,jj)
% 
% 
%% Description
% `[~,m] = updateMatching(a)` calculates the matching index for each pair of
% nodes in a network given by adjacency matrix `a`.
% 
% `[a,m,n,d] = updateMatching(a,m,n,d,ii,jj)` quickly calculates the matching
% index for each pair of nodes when the edge between node `ii` and node `jj` is
% added to the network given by adjacency matrix `a`. You should run `[a,m,n,d]
% = updateMatching(a);` to get the matrices `m`,`n` and `d` - which you can then
% provide as input into subsequent runs. 
% 
% 
%% Input Arguments
%  `a - (original) adjacency matrix (square symmetric unweighted numeric matrix)`
% 
%  `m - (original) matching index (square symmetric numeric matrix)`
% 
%  `n - (original) numerator matrix (square symmetric non-negative integer matrix)`
%  `n(ii,jj)` contains the total number of edges from node `ii` and node `jj`
%  that connect to the common neighbors between the two nodes. This is equal to
%  twice the number of neighbors that the two nodes share. 
% 
%  `d - (original) denominator matrix (square symmetric non-negative integer matrix)`
%  `d(ii,jj)` contains the total number of edges connected to node `ii` and node
%  `jj` (excluding any connection between them, if it exists, by convention). 
% 
%  `ii - endpoint of new edge being added (positive integer)`
% 
%  `jj - endpoint of new edge being added (positive integer)`
% 
% 
%% Examples
%   [~,m] = updateMatching(+(gallery('toeppd', 10)<0)) 
%   W = zeros(500); [a,m,n,d] = updateMatching(W); [x,y] = find(~W); [x,y] = deal(x(x>y), y(x>y)); newEdges = randsample(length(x), 100); for ii = 1:length(newEdges); [a,m,n,d] = updateMatching( a,m,n,d,x(newEdges(ii)),y(newEdges(ii)) ); end
% 
% 
%% Output Arguments
%  `a - (new) adjacency matrix (square symmetric unweighted numeric matrix)`
% 
%  `m - (new) matching index (square symmetric numeric matrix)`
% 
%  `n - (new) numerator matrix (square symmetric non-negative integer matrix)`
% 
%  `d - (new) denominator matrix (square symmetric non-negative integer matrix)` 
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See Also 
% `matching_ind`, `matching_ind_und` (Rick Betzel, Brain Connectivity Toolbox)
% `matching` (Stuart J Oldham, FasterMatchingIndex)
% 
% 


if nargin < 6
    assert(isequal(a', double(logical(a)))); % check that a is symmetric and the correct type
    n = 2*a*a; 
    n(1:(length(a)+1):end) = 0;
    temp = sum(a,1); 
    d = temp + temp' - 2*a;
    m = n ./ (d + ~n);
    return
end

% Suggest uncommenting this line when profiling
% As >80% of the runtime is just in allocating new memeory for output matrices
[a,m,n,d] = deal(a+1-1,m+1-1,n+1-1,d+1-1);

a(ii, jj) = 1;
a(jj, ii) = 1;

temp1 = n(:,ii) + a(:,jj)*2;
temp2 = n(:,jj) + a(:,ii)*2;
n(:,[ii,jj]) = [temp1, temp2];
n([ii,jj],:) = [temp1, temp2]';
n(ii,ii) = 0;
n(jj,jj) = 0;

temp = d(:,[ii,jj])+1;
d(:,[ii,jj]) = temp;
d([ii,jj],:) = temp';
d(ii,jj) = d(ii,jj) - 1;
d(jj,ii) = d(jj,ii) - 1;
d(ii,ii) = d(ii,ii) + 1;
d(jj,jj) = d(jj,jj) + 1;

m(:,[ii,jj]) = n(:,[ii,jj])./( d(:,[ii,jj]) + ~n(:,[ii,jj]) );
m([ii,jj],:) = n([ii,jj],:)./( d([ii,jj],:) + ~n([ii,jj],:) );

end
