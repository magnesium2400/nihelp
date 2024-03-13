function out = triu2vec(A,k,overrideWarning)
%% TRIU2VEC Extract upper triangular part and convert to column vector
%% Usage Notes
% Returns data from upper triangle of A, moving down the columns. If you want
% the same data, but in row-major order, use something like: 
% `flip(triu2vec(fliplr(flipud(A.'))))` or `tril2vec(A.')`.
%
%
%% Examples
%   triu2vec(magic(3))
%   triu2vec(magic(3),1)
%   triu2vec(magic(3),-1,true)
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
if k <= 0 && ~overrideWarning; warning('triu2vec includes main diagnonal'); end

out = reshape(A(triu(true(size(A)), k)), [], 1);

end
