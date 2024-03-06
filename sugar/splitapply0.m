function out = splitapply0(func, X, G, nGroups)
%% SPLITAPPLY0 Uses splitapply even if groups are indexed 0 or are absent
%% Examples
%   splitapply0(@(x) x, (1:3), (1:3))
%   splitapply0(@(x) x, (1:3), (1:3).^2)
%   splitapply0(@(x) x, (1:4), (0:3))
%   splitapply0(@(x) x, (1:3), (1:3), 6)
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


% nans in missing values
% TODO: add support for func to return multiple outputs

if nargin<4; nGroups = max(G); end
out = nan(nGroups, 1);

[G2, Gid] = findgroups(G);
temp = splitapply(func, X, G2);
out(Gid(logical(Gid))) = temp(logical(Gid));

end