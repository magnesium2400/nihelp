function out = minmax(varargin)
%% MINMAX Return the minimum and maximum of the data input
%% Examples
%   minmax(magic(3))
%   minmax(magic(3), [], 2)
%   minmax(magic(3), [], 'all')
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



a = min(varargin{:});
b = max(varargin{:});
d = find([size(a),1] == 1,1);
out = cat(d,a,b);
end