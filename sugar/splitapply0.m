function out = splitapply0(func, X, G, nGroups)
%% SPLITAPPLY0 uses splitapply even if groups are indexed 0 or are absent
% nans in missing values

if nargin<4; nGroups = max(G); end
out = nan(nGroups, 1);

[G2, Gid] = findgroups(G);
temp = splitapply(func, X, G2);
out(Gid(logical(Gid))) = temp(logical(Gid));

end