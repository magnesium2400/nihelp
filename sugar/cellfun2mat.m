function out = cellfun2mat(func, C)
out = cell2mat(cellfun(func,C, 'UniformOutput', false));
end