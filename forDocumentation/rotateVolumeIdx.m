function out = rotateVolumeIdx(srcV, srcOrientation, tgtOrientation, mask)
%% ROTATEVOLUMEIDX Given a volume V in srcOrientation, find the permutation of voxels to get to tgtOrientation

if nargin<4; mask = []; end; mask = processMask(srcV, mask);
srcV = double(srcV);
srcV(mask) = 1:nnz(mask);
out = nonzeros(rotateVolume(srcV, srcOrientation, tgtOrientation));

end
