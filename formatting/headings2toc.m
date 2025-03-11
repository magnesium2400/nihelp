function out = headings2toc(mfile, addToFile)
%%
%% Examples
%   
% 
% 
%% TODO
% * docs
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
out = arrayfun(@(x) sprintf("%% %2i. %s",x,extractAfter(S{m(x)},h{m(x)}-1)), ...
    (1:numel(m))');

%% Add to file if desired
if addToFile
    writelines([out;S], mfile); 
end


end

