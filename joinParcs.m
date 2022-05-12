function out = joinParcs(in, potentialRH)
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

if nargin < 2
    potentialRH = in(length(in)/2 + 1 : end, :);
    in(length(in)/2 + 1 : end, :) = [];
end

nrois = max(in(:));
potentialRH(~~potentialRH) = potentialRH(~~potentialRH) + nrois;
out = [in; potentialRH];

end

