function out = nansz(mat)
%% NANSZ Creates a matrix of NaNs the size of the input matrix
%% Examples
%   a = nansz(loadmri);
out = nan(size(mat)); 
end
