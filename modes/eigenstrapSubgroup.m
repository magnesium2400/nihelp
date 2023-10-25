function out = eigenstrapSubgroup(groupModeData)
%%EIGENSTRAPSUBGROUP applies eigenstrapping to the whole input, as if it is one group
% input:  nVerts * nModes matrix
% output: nVerts * nModes matrix
rot = makeRandomRotationMatrix(size(groupModeData, 2));
out = groupModeData * rot';
end