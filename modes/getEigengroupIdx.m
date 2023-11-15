function out = getEigengroupIdx(groupNumber, nMax)
%% GETEIDENGROUPIDX Gets position IDs for the eigengroup number specified
% first constant mode is group 1, next three modes are group 2 (1-indexed)
out = (1:(2*groupNumber-1)) + (groupNumber-1)^2;
if nargin > 1; out = out(out <= nMax); end
end

