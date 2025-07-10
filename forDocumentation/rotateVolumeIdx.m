function out = rotateVolumeIdx(srcV, srcOrientation, tgtOrientation)
%% ROTATEVOLUMEIDX Given a volume V in srcOrientation, find the permutation of voxels to get to tgtOrientation

% srcV = rotateVolume(+tgtV, tgtOrientation, srcOrientation); 
srcV = +srcV; 
srcV(logical(srcV)) = 1:nnz(srcV); 
out = nonzeros(rotateVolume(srcV, srcOrientation, tgtOrientation)); 

end
