function mat = emptymat2zero(mat)
if iscell(mat);  mat = cellfun(@emptymat2zero, mat, 'uni', 0); return; end
if isempty(mat); mat = 0; end
end