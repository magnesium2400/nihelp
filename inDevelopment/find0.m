function varargout = find0(varargin)

varargout = cell(1,nargout); 
[varargout{:}] = find(varargin); 
varargout = cellfun(@emptymat2zero, varargout); 

end
