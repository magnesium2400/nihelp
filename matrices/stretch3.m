function output = stretch3(inp)
%% STRETCH3 Converts 4-d volumetric time series data to 2-d vectorised time series
%% Examples
%   V = magic(3)+permute([0 0 0],[1 3 2])+permute(1:10,[1 4 3 2]); out = stretch3(V);
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

output = reshape(inp,[],size(inp,4));
end
