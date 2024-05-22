function out = strnow(format)
%% STRNOW Returns current time as string (by default, up to seconds)
%% Examples
%   strnow
%   strnow('ddMMyyyy')
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

if nargin < 1; format = 'yyMMddHHmmss'; end
out = string(datetime('now','Format', format));
end
