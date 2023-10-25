function out = eigenstrap(modeData)

nModes = size(modeData, 2);
nGroups = ceil(sqrt(nModes));

out = nan(size(modeData));
out(:, 1) = modeData(:, 1);

for ii = 2:(nGroups)
    currIdx = getEigengroupIdx(ii);
    currIdx = currIdx(currIdx <= nModes);
    out(:, currIdx) = eigenstrapSubgroup(modeData(:, currIdx));
end

% ii = nGroups;
% currIdx = getEigengroupIdx(ii);
% rot = makeRandomRotationMatrix(2*ii-1);
% out(:, currIdx(currIdx<=nModes)) = ...
%     modeData(:, currIdx(currIdx<=nModes)) * rot(:,currIdx<=nModes)';

end
