function out = videofigs(n, varargin)
rd = @(ii) cellfun(@feval, varargin, repmat({ii}, 1, numel(varargin)), 'Uni', 0); 
out = cell(nargout, 1); 
[out{:}] = videofig(n, rd); 
end
