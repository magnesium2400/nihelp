function out = rowfunc(func, A)
%% ROWFUNC Evaluates function on each row in a matrix
%% Examples
%   rowfunc( @(x) [max(x), min(x)] , magic(3))
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

% out = colfunc(func, data.').';

try out = arrayfun( @(x) func(A(x,:)) , (1:size(A,1))' ); 
catch; out = cell2mat(arrayfun( @(x) func(A(x,:)) , (1:size(A,1))', 'UniformOutput', false)); end
% catch; out = cell2mat(arrayfun( @(x) reshape(func(A(x,:)), 1, []) , (1:size(A,1))', 'UniformOutput', false)); end

end
