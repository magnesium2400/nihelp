function out = unrotateVolumeIdx(tgtV, srcOrientation, tgtOrientation, mask)
%% UNROTATEVOLUMEIDX Given a volume V in tgtOrientation, find the permutation of voxels to get there from srcOrientation

if nargin<4; mask = []; end; mask = processMask(tgtV, mask);
srcV = rotateVolume(double(tgtV), tgtOrientation, srcOrientation);
srcV(mask) = 1:nnz(mask);
out = nonzeros(rotateVolume(srcV, srcOrientation, tgtOrientation));

end
