function [out, unconnRegions, nIncorrect, incorrectMask] = isParcellationConnected(verts, faces, rois)
out = true; unconnRegions = []; nIncorrect = []; incorrectMask = false(height(verts),1); 
for ii = unique(rois(:))'
    [a,b,c] = isRegionConnected(verts, faces, rois, ii); 
    if ~a
        out = false; 
        unconnRegions(end+1) = ii; %#ok<AGROW>
        nIncorrect(end+1) = b; %#ok<AGROW>
        incorrectMask = incorrectMask | c; 
    end
end
end
