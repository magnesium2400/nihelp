function climitation(varargin)
if exist('clim');   limitation(varargin{:}, 'func', @clim); %#ok<EXIST> 
else;               limitation(varargin{:}, 'func', @caxis); end %#ok<CAXIS> 
end