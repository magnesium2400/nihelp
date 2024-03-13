function out = vec2triu(data, k, overrideWarning)
%% VEC2TRIU Convert vectorised data to upper triangle of a matrix
%% Examples
%   vec2triu(1:6) % expected warning
%   vec2triu(1:10,3)
%   vec2triu(1:15,0,true)
%   triu2vec(vec2triu(1:6,5),5)
%   vec2triu(triu2vec(magic(5),2),2)
%   vec2triu(triu2vec(magic(7),-3,true),-3,true)
%   triu2vec(vec2triu(1:22,-2,1),-2,1)
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
if nargin < 3 || isempty(overrideWarning);  overrideWarning = false;        end
if k <= 0 && ~overrideWarning; warning('vec2triu includes main diagnonal'); end


if k >= 0;  n = ( sqrt( 8*length(data)+1 )           - 1 ) / 2;
else;       n = ( sqrt( 8*length(data)+1+8*k*(k-1) ) - 1 ) / 2; end

idx = triu(true(n+k), k);
out = zeros(size(idx));
out(idx) = data;

end
