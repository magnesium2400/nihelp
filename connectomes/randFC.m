function out = randFC(n,mu,sigma,seed)
%% RANDFC Generates random FC matrix with specified size, mean, and standard deviation
%% Examples
%   randFC(5)
%   randFC(6,0.5)
%   randFC(7,0.5,0.01)
%   randFC(4,[],[],1)
%   randFC(4,[],[],1)
%   randFC(4,[],[],2)
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

if nargin < 2 || isempty(mu);       mu = 0;         end
if nargin < 3 || isempty(sigma);    sigma = 1/3;    end
if nargin > 3 && ~isempty(seed);    rng(seed);      end

out = randn(n)*sigma + mu;
out = out-tril(out,0)+triu(out,1)'+eye(n);
out(out>1) = 1; out(out<-1) = -1;

end
