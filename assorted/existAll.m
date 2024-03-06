function out = existAll(cellOfNames, searchType)
%% EXISTALL Check if data exist in base workspace
%% Examples
%   a=1;b=2;existAll({'a', 'b'}, 'var')
%   a=1;clear b;existAll({'a', 'b'}, 'var')
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


out = all(cellfun(@(x) evalin("base", ['exist("',x,'", "',searchType,'")']), cellOfNames));
end
