function out = scaffoldSort(x, scaffold)
%% SCAFFOLDSORT Reorder data according to a provided scaffold
%% Examples
%   scaffoldSort([10 50 30 20], [6 8 7 9])
%   scaffoldSort([10 50 30 20], [4 3 2 1])
%   scaffoldSort([4 3 2 1], [10 50 30 20])
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


x = sort(x); 
out = x(invsort(scaffold)); 
end
