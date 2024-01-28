function [out, mask] = getHomotopicConnections(W)
%% GETHOMOTOPICCONNECTIONS Returns homotopic connections from connectome
%% Syntax
%  out = getHomotopicConnections(W)
%  [out, mask] = getHomotopicConnections(W)
%  
%  
%% Description
% `out = getHomotopicConnections(W)` returns the homotopic connections between
% the two hemispheres in a connectome i.e. the diagonal of the bottom left
% quadrant of the connectome matrix.
% 
% `[out, mask] = getHomotopicConnections(W)` also returns a binary mask of the
% positions in the connectome matrix that represent these homotopic connections.
% 
% 
%% Examples
%   out = getHomotopicConnections(magic(10) + magic(10).');
%   [out, mask] = getHomotopicConnections(magic(10) + magic(10).');
%   
%   
%% Input Arguments
%  W - connectome (symmetric matrix | vectorised lower triangle of matrix) 
%  The values in W represent the undirected connections between each region. If
%  W is a matrix, the bottom left quadrant should contain the connections
%  between hemispheres, with entries along the main diagonal of this quadrant
%  being the homotopic connections. Alternatively, W can be the vectorised lower
%  triangle of the connectome matrix e.g. the output from
%  `squareform(squareMatrix)`.
%  
%  
%% Output Arguments  
%  out - homotopic connections (numeric column vector)
%  
%  mask - mask of location of homotopic connections (logical matrix | logical vector)
%  A binary mask of the matrix entries from where the homotopic entries were
%  extracted. If the input is a square matrix, this will also be a square
%  matrix. If the input is a vector, this will be a row vector. 
%  
%  
%% See Also
% SQUAREFORM
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% TODO
% * add support/warnings for non-symmetric matrices
%
%
%% ENDPUBLISH


sqform = false;
if size(W, 1) == 1 || size(W, 2) == 1
    W = squareform(W);
    sqform = true;
end

assert(issymmetric(W));
out = diag(W( (end/2+1):end, 1:end/2 ));

if nargout < 2; return; end

n = length(W);
mask = false(n);
mask( sub2ind([n n], (n/2+1):n, 1:n/2) ) = true;
if sqform; mask = squareform(mask); end

end
