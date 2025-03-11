function [out, nIncorrect, incorrectMask] = isRegionConnected(verts, faces, rois, tgt)
maskIn          = rois==tgt;
[~,~,~,maskOut] = trimExcludedRois(verts, faces, maskIn, 'removeUnconnected', true, 'overrideAssertions', true);
incorrectMask   = maskIn ~= maskOut;
nIncorrect      = nnz(incorrectMask);
out             = ~nIncorrect; 
end
