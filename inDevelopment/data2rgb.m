function rgb = data2rgb(inp, cmap, clims, nanColor)
%% Examples
%   rgb = data2rgb(1:100);
%   rgb = data2rgb(rand(1000, 1));
%   rgb = data2rgb(randn(100,1), parula); 
%   rgb = data2rgb(randn(100,1), parula, [0 1]); 
%   
%   rgb = data2rgb(ones(10,1)); 
%   data = randn(100,1); data(randn(100,1)>0.5) = nan; rgb = data2rgb(data); 
%   
%   figure; a = rand(10, 1); scatter(1:10, a, 100, data2rgb(a), 'filled'); colorbar;
%   figure; a = rand(10, 1); b = bar(a); b.FaceColor = 'flat'; b.CData = data2rgb(a,'parula',[0 1]); 
%   figure; a = rand(100, 1); b = bar(a); b.FaceColor = 'flat'; b.CData = data2rgb(1:numel(a)); 
%   
%   data = double(im2gray(imread('peppers.png'))); figure; image(data2rgb(data, hot));  
%   rgb = data2rgb(randn(10,20,30));
%   
%   


%% Inputs
if isvector(inp);                 inp = inp(:); end
if nargin<2 || isempty(cmap);     cmap = parula; end
if nargin<3 || isempty(clims);    clims = minmax(inp,[],'all'); end
if nargin<4 || isempty(nanColor); nanColor = [0.5 0.5 0.5]; end

if isStringScalar(cmap) || ischar(cmap); cmap = colormap(cmap); 
elseif isa(cmap, 'function_handle');     cmap = cmap(); 
else;          assert(isnumeric(cmap) && width(cmap)==3); 
end

assert(numel(clims) == 2 && clims(1)<=clims(2)); 


%% Main
% remap data to [0,1]
data = (inp(:) - clims(1))/(clims(2)-clims(1)++~diff(clims)); 
data = min(1, max(0, data)); 

% convert to indices and get data
idx = round(data * (height(cmap)-1))+1; 
rgb = cmap(idx,:);  
rgb(isnan(inp(:)),:) = repmat(nanColor, nnz(isnan(inp(:))), 1);
rgb = reshape(rgb, [size0(inp), 3]);


end
