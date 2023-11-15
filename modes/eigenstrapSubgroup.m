function out = eigenstrapSubgroup(groupModeData)
%% EIGENSTRAPSUBGROUP applies eigenstrapping to the whole input, as if it is one group
% i.e. rotate n eigenmodes in n-dimensional space
% input:  nVerts * nModes matrix
% output: nVerts * nModes matrix
rot = makeRandomRotationMatrix(size(groupModeData, 2));
out = groupModeData * rot'; % (rot * groupModeData')'
end