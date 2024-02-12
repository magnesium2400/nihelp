function out = dir2(path)
%% DIR2 Removes `.` and `..` from `dir`
%% Examples
%   dir2('.')
%   dir2(pwd)
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


if nargin == 0; path = "."; end
d = dir(path);
out = d(~ismember({d.name}, {'.','..'}));
end
