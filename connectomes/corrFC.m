function out = corrFC(varargin)
%% CORRFC Applies r-to-z transform then calculates Pearson correlations between FC matrices
%% Examples
%   corrFC(randFC(5,[],[],1), randFC(5,[],[],2))
%   corrFC(randFC(5,[],[],1), randFC(5,[],[],2), randFC(5,[],[],3))
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


[m,n] = size(varargin{1}); 
assert(m==n, 'Inputs should be square FC matrices'); 
assert(all( m==cellfun(@(x) size(x,1), varargin) ), 'Inputs should all be the same size')
assert(all( m==cellfun(@(x) size(x,2), varargin) ), 'Inputs should all be the same size')
if ~all(cellfun(@issymmetric, varargin)); warning('Some inputs are not symmetric'); end

out = corr(cellfun2mat(@(x) atanh(1-squareform(1-x)'), varargin), ...
    'Rows', 'pairwise'); 

end