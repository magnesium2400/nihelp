function [out,m] = getRowsContaining(X,v)
%% GETROWSCONTAINING Gets rows in from matrix containing specified values
%% Examples
%   X = (0:6)' + (1:3); getRowsContaining(X,5)
%   X = (0:6)' + (1:3); getRowsContaining(X,[5,6,7])
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

m = any(ismember(X,v),2);
out = X(m,:);
end