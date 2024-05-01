function [leafOrder, links, dists] = ...
    reorderMatrix(W, pdistOptions, linkageOptions, orderOptions)
%% REORDERCONNECTOME Find permutation of similar rows to aid visualisations
%% Examples
%   tmp = magic(32)+magic(32)'; r=randperm(32); tmp=tmp(r,r); figure; nexttile; imagesc(tmp); nexttile; imagesc(corr(tmp)); idx = reorderConnectome(tmp); tmp2 = tmp(idx,idx); nexttile; imagesc(tmp2); nexttile; imagesc(corr(tmp2)); 
%   tmp = randperm(30)'+randperm(50); figure; nexttile; imagesc(tmp); idx = reorderConnectome(tmp); tmp2 = tmp(idx,:); nexttile; imagesc(tmp2); nexttile; imagesc(tmp2(:,reorderConnectome(tmp2'))); 
%   tmp = cell2mat(arrayfun(@(x) randperm(4), (1:500)', 'Uni', 0)); idx = reorderConnectome(tmp); c = corr(tmp.'); figure; nexttile; imagesc(c); nexttile; imagesc(c(idx,idx));   
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


if nargin < 2; pdistOptions = {};   end
if nargin < 3; linkageOptions = {}; end
if nargin < 4; orderOptions = {};   end

dists       = pdist(W,                        pdistOptions{:});
links       = linkage(dists,                  linkageOptions{:});
leafOrder   = optimalleaforder(links, dists,  orderOptions{:});

end