function out = headings2toc(mfile, addToFile)
%% HEADINGS2TOC Takes first-level headings and generates table of contents, optionally adding to file
%% Examples
%   h = headings2toc('headings2toc.m')
%   h = headings2toc('headings2toc.m', false)
% 
% 
%% TODO
% * docs
% * add support for nested headings?
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 


%% Prelims
if nargin < 2 || isempty(addToFile); addToFile = false; end

%% Get headings and format output
% currently only supports first level headings
mfile = which(mfile); 
S = readlines(mfile); 
h = regexp(S, '(?<=^\s*%%\s+)\w*');
m = find(~cellfun(@isempty, h)); 
n = strlength(string(numel(m))); 
out = arrayfun(@(x) sprintf("%% %"+n+"i. %s",x,extractAfter(S{m(x)},h{m(x)}-1)), ...
    (1:numel(m))');

%% Add to file if desired
if addToFile
    writelines([out;S], mfile); 
end

%% 
if nargout == 0
    tmp = mat2cell(out, onesz(out))';
    tmp(2,:) = repmat({"\n"}, 1, numel(tmp)); 
    fprintf(strrep(append(tmp{:}), '%', '%%')); 
end


end

