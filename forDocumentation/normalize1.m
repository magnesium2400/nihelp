function [N,C,S] = normalize1(A,dim)
%% NORMALIZE1 Normalises so that POPULATION (not SAMPLE) variance/standard deviation is 1
%% Examples
%   data = normalize1(randn(100,3));
%   data = normalize1(randn(100,3),1);
%   data = normalize1(randn(100,3),2);
%   var(normalize1(randn(100,3),1),1,1)
%   
%   var(normalize(randn(100,3),1),0,1)
%   var(normalize(randn(100,3),1),1,1)
%   var(normalize1(randn(100,3),1),0,1)
%   var(normalize1(randn(100,3),1),1,1)
%   
%   


if nargin < 2 || isempty(dim); dim = firstdim(A); end
C = mean(A,dim); 
S = std(A,1,dim); 
N = (A - C) ./ S; 
end
