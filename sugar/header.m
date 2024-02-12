function out = header(A,k)
%% HEADER Adds functionality from `head` to more data types
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if nargin < 2; k = 8; end
try out = head(A,k);
catch; out = A(1:min(k,size(A,1)),:); end
end