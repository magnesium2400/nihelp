function out = isRoiInMask(volumetricRois, volumetricMask)

out = zeros(max(volumetricRois, [], 'all'), 1);

while any(volumetricMask, 'all')
    idx = find(volumetricMask, 1);
    curr = volumetricRois == volumetricRois(idx);
    if volumetricRois(idx)
        out(volumetricRois(idx)) = sum(volumetricMask(curr))/nnz(curr);
    end
    volumetricMask(curr) = 0;
end

end