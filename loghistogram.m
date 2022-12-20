function varargout = loghistogram(varargin)
%LOGHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
varargout{:} = histogram(varargin{:}); 
set(gca, 'YScale', 'log');
end

