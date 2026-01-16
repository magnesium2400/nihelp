function varargout = ndgridn(n, varargin)
%% NDGRIDN Gets the output of ndgrid in the nth dimension
%% Examples
%   v = {1:5}; a = ndgridn(1,v{:}); A = ndgrid(v{:}); assert(isequal(a,A));  
%   v = {1:5}; b = ndgridn(2,v{:}); [~,B] = ndgrid(v{:}); assert(isequal(b,B));  
%   v = {1:5}; [a,b] = ndgridn(1:2,v{:}); [A,B] = ndgrid(v{:}); assert(isequal(a,A) && isequal(b,B) && ~isequal(a,B));  
%   v = {1:5}; [a,b,c] = ndgridn(1:3,v{:}); [A,B,C] = ndgrid(v{:}); assert(isequal(a,A) && isequal(b,B) && isequal(c,C));  
%   v = {1:5}; [b,c] = ndgridn(2:3,v{:}); [A,B,C] = ndgrid(v{:}); assert(isequal(b,B) && isequal(c,C));  
%
%


temp = cell(1,max(n)); 
varargout = cell(1,numel(n)); 
[temp{:}] = ndgrid(varargin{:});
[varargout{:}] = temp{n}; 
end
