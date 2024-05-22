function out = randsym(n,density,seed)
%% RANDSYM Random symmetric uniform matrix of specified size and density
%% Examples
%   randsym(10)
%   W = randsym(1000,0.3); nnz(tril(W,-1))*2/length(W)/(length(W)-1), issymmetric(W), figure; nexttile; imagesc(W); nexttile; histogram(nonzeros(W),0:0.1:1);   
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


if nargin < 2 || isempty(density); density = 0.5; end
if nargin > 2 && ~isempty(seed); rng(seed); end

out = rand(n);
out = out.*(out<density)/density; 
out = tril(out,-1) + tril(out,-1)';

end
