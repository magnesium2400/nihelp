function out = unrotateVolumeIdx(tgtV, srcOrientation, tgtOrientation)
%% UNROTATEVOLUMEIDX Given a volume V in tgtOrientation, find the permutation of voxels to get there from srcOrientation

srcV = rotateVolume(+tgtV, tgtOrientation, srcOrientation); 
srcV(logical(srcV)) = 1:nnz(srcV); 
out = nonzeros(rotateVolume(srcV, srcOrientation, tgtOrientation)); 

end
