function out = eigenstrap(modeData, mask)

if nargin < 2; mask = true(size(modeData,1), 1); else; mask = logical(mask); end

nModes = size(modeData, 2);
nGroups = ceil(sqrt(nModes));

out = modeData;
% out = nan(size(modeData));
out(mask, 1) = modeData(mask, 1);

for ii = 2:(nGroups)
    currIdx = getEigengroupIdx(ii);
    if ii == nGroups; currIdx = currIdx(currIdx <= nModes); end
    out(mask, currIdx) = eigenstrapSubgroup(modeData(mask, currIdx));
end

% ii = nGroups;
% currIdx = getEigengroupIdx(ii);
% rot = makeRandomRotationMatrix(2*ii-1);
% out(:, currIdx(currIdx<=nModes)) = ...
%     modeData(:, currIdx(currIdx<=nModes)) * rot(:,currIdx<=nModes)';

end
