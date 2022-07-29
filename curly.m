function out = curly(data, varargin)
%CURLY return value of unassigned cell
out = data{varargin{:}};
end