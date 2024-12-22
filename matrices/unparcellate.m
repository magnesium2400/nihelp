function out = unparcellate(rois, data, fillVal)
%% UNPARCELLATE Converts data from parcel/ROI level to vertex level
%% Examples
%    unparcellate([0 1 1 0 2 2 0 3 3 0]', [1 4 5]')
%    unparcellate([0 1 1 0 2 2 0 4 4 0]', [1 4 3 5]')
%    unparcellate([0 1 1 0 2 2 0 4 4 0]', [1 4 3 5]', 0)
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


if nargin < 3 || isempty(fillVal); fillVal = nan; end

assert(max(rois) <= height(data)); 
if max(rois) ~= height(data); warning('Excess data provided'); end

out = ones(length(rois), width(data)) * fillVal; 

out(logical(rois),:) = data(nonzeros(rois),:); 

end
