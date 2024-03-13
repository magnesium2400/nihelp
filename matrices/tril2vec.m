function out = tril2vec(A,k,overrideWarning)
%% TRIL2VEC Extract lower triangular part and convert to column vector
%% Usage Notes
% Returns data from lower triangle of A, moving down the columns. If you want
% the same data, but in row-major order, use something like: 
% `flip(tril2vec(fliplr(flipud(A.'))))` or `triu2vec(A.')`.
%
%
%% Examples
%   tril2vec(magic(3))
%   tril2vec(magic(3),-1)
%   tril2vec(magic(3),1,true)
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


if nargin < 2 || isempty(k);                k = 0;                          end
if nargin < 3 || isempty(overrideWarning);  overrideWarning = false;        end
if k >= 0 && ~overrideWarning; warning('tril2vec includes main diagnonal'); end

out = reshape(A(tril(true(size(A)), k)), [], 1);

end
