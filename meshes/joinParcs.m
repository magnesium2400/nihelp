function out = joinParcs(in, potentialRH, nroisL)
%% JOINPARCS Re-indexes ROI allocations from two surfaces/hemispheres into 1
%% Examples
%   l = randi(11,[100,1])-1; r = randi(11,[100,1])-1; lr = joinParcs(l, r); figure; nexttile; plot(l); nexttile; plot(r); nexttile([1,2]); plot(lr);       
%   lAndr = randi(11,[400,1])-1; figure; nexttile; plot(lAndr); nexttile; plot(joinParcs(lAndr));
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




%JOINPARCS Joins LH and RH parcellations
%   Inputs:
%   in:             vector of ROI allocations (0 is vertices excluded)
%                   can be LH and RH already concatenated, or LH only
%   potentialRH:    if in represents only the LH, this is the allocations 
%                   of the RH
%
%   Outputs:
%   out:            a vector where the second half is reindexed s.t. it is
%                   added onto (rather than overlaps) the first half; note
%                   that vertices labelled 0 are maintained



if nargin < 2 || isempty(potentialRH)
    potentialRH = in(length(in)/2 + 1 : end, :);
    in(length(in)/2 + 1 : end, :) = [];
end
if nargin < 3
    nroisL = max(in(:)); 
end


potentialRH = potentialRH + nroisL*logical(potentialRH);
out = [in; potentialRH]; % out = [in; potentialRH + max(in(:))*logical(potentialRH)];

end

