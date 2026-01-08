function out = zerosz(mat, varargin)
%% ZEROSZ Creates a matrix of zeroes the size of the input matrix
%% Examples
%   a = zerosz(loadmri);
out = zeros(size(mat), varargin{:}); 
end
