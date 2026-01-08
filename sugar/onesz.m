function out = onesz(mat, varargin)
%% ONESZ Creates a matrix of ones the size of the input matrix
%% Examples
%   a = onesz(rand(5,6,7));
out = ones(size(mat), varargin{:}); 
end
