function out = unrotateVolumeIdx(tgtV, srcOrientation, tgtOrientation, mask)
%% UNROTATEVOLUMEIDX Given a volume V in tgtOrientation, find the permutation of voxels to get there from srcOrientation

srcV = rotateVolume(double(tgtV), tgtOrientation, srcOrientation);
if nargin<4; mask = []; end; mask = processMask(srcV, mask);
srcV(mask) = 1:nnz(mask);
out = nonzeros(rotateVolume(srcV, srcOrientation, tgtOrientation));

end
