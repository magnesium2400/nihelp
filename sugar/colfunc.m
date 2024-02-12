function out = colfunc(func, A)
%% COLFUNC Evaluates function on each column in a matrix
%% Examples
%   colfunc( @(x) [max(x), min(x)] , magic(3))
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

try out = arrayfun( @(x) func(A(:,x)) , 1:size(A,2) ); 
catch; out = cell2mat(arrayfun( @(x) reshape(func(A(:,x)), [], 1) , 1:size(A,2), 'UniformOutput', false)); end
end
