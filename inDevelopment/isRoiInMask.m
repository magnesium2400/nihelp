function out = isRoiInMask(volumetricRois, volumetricMask)

volumetricMask = logical(volumetricMask);
out = zeros(max(volumetricRois, [], 'all'), 1);

while any(volumetricMask, 'all')
    idx = find(volumetricMask, 1);
    roiId = volumetricRois(idx);
        curr = volumetricRois == roiId;
    if roiId
        out(roiId) = sum(volumetricMask(curr), 'all')/nnz(curr);
    end
    volumetricMask(curr) = false;
end

end