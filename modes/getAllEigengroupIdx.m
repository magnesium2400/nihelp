function out = getAllEigengroupIdx(inp)
%% GETALLEIGENGROUPIDX Return cell array of the indices making up each eigengroup in input
% input: either (i) number of modes; or (ii) nVerts * nModes matrix (nModes is dimension 2)
% output: cell array of indices making up each group, with the last element 
% truncated if the number of modes is not a perfect square 
% NOTE: THE FIRST ELEMENT IS [1], NEXT IS [2 3 4] etc. i.e. this function is
% 1-indexed and includes the first (constant) mode

if numel(inp) == 1; nModes = inp; 
else; nModes = size(inp, 2); end

nGroups = ceil(sqrt(nModes));
out = arrayfun(@(x) getEigengroupIdx(x, nModes), 1:nGroups, 'UniformOutput', 0);

end
