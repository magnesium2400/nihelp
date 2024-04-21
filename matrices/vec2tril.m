function out = vec2tril(data, k, symmetrise, overrideWarning)
%% VEC2TRIL Convert vectorised data to lower triangle of a matrix
%% Examples
%   vec2tril(1:6) % expected warning
%   vec2tril(1:10,-3)
%   vec2tril(1:15,0,true)
%   tril2vec(vec2tril(1:6,-5),-5)
%   vec2tril(tril2vec(magic(5),-2),-2)
%   vec2tril(tril2vec(magic(7),3,true),3,true)
%   tril2vec(vec2tril(1:22,2,1),2,1)
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
%% SEE ALSO
% SQUAREFORM
%
%


if nargin < 2 || isempty(k);                k = 0;                          end
if nargin < 3 || isempty(symmetrise);       symmetrise = false;             end
if nargin < 4 || isempty(overrideWarning);  overrideWarning = false;        end
if k >= 0 && ~overrideWarning; warning('vec2tril includes main diagnonal'); end


if k <= 0;  n = ( sqrt( 8*length(data)+1 )           - 1 ) / 2;
else;       n = ( sqrt( 8*length(data)+1+8*k*(k+1) ) - 1 ) / 2; end

idx = tril(true(n-k), k);
out = zeros(size(idx));
out(idx) = data;
if symmetrise
    if k <= 0; out = out + out.' - diag(diag(out)); 
    else; error('Unable to symmetrise tril with main diagonal included'); end
end

end
