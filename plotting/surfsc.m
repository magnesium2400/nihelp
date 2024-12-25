function s = surfsc(varargin)
%% SURFSC Similar to `imagesc`, but with true and scaled colour
%% Examples
% Simple
%   figure; surfsc(magic(5)); 
%   figure; nexttile; surfsc(magic(5)); axis('tight'); nexttile; imagesc(magic(5));
%
% Shift position
%   figure; surfsc(magic(5), 'XData', 3); 
%   figure; surfsc(magic(5), 'XData', [3,7]); 
%   figure; surfsc(magic(5), 'XData', [3,9]); 
%   figure; surfsc(magic(5), 'XData', [3,11]); 
%   figure; surfsc(magic(5), 'XData', [3,11], 'YData', [40,-40]);
%   
% Mask
%   figure; surfsc(magic(5), 'mask', tril(true(5))    ); 
%   figure; surfsc(magic(5), 'mask', tril(true(5),-1) ); 
%   figure; surfsc(magic(5), 'mask', @(x) x>15); 
%   figure; surfsc(magic(5), 'mask', magic(5)>15); 
%   figure; surfsc(magic(5), 'mask', magic(5)>15); clim([1, 25]); 
%
% Recolor
%   figure; surfsc(magic(5), 'c', [0.5 0.5 0.5]); 
%   figure; surfsc(magic(5), 'c', [0.5 0.5 0.5], 'mask', @(x) x<=15); 
%   figure; surfsc(magic(5), 'c', ((0:2)+(0:24)')/26); 
%   figure; surfsc(magic(5), 'c', (1:15)', 'mask', @(x) x<=15); 
%   figure; surfsc(magic(5), 'c', (1:3)', 'mask', @(x) x<=15); 
%   figure; surfsc(magic(5), 'c', (1:3)', 'mask', @(x) mod(x,2)==0); 
%
% Series of examples that start bad and get better
%   n=50; [x,y]=meshgrid(-n:n); d=vecnorm(cat(3,x,y),2,3); figure; surfsc(d<n);                                hold on; surfsc(d,'mask',d<n/2); colormap(flip(hot)); colorbar;
%   n=50; [x,y]=meshgrid(-n:n); d=vecnorm(cat(3,x,y),2,3); figure; surfsc(d<n,'mask',@logical);                hold on; surfsc(d,'mask',d<n/2); colormap(flip(hot)); colorbar;
%   n=50; [x,y]=meshgrid(-n:n); d=vecnorm(cat(3,x,y),2,3); figure; surfsc(d<n,'mask',@logical,'c',[.5 .5 .5]); hold on; surfsc(d,'mask',d<n/2); colormap(flip(hot)); colorbar;
%
% Complex good examples
%   n=50; [x,y]=meshgrid(-n:n); d=vecnorm(cat(3,x,y),2,3); figure; surfsc(d<n,'mask',@logical,'c',[.5 .5 .5]); hold on; surfsc(d,'mask',d<n/2); colormap(flip(hot)); colorbar; axis('image');
%   d=magic(5); m=d>15; figure; surfsc(d, 'mask', m); hold on; surfsc(d, 'mask', ~m, 'c', [.5 .5 .5]);   
%   n=5; figure; surfsc(1./pascal(n), 'mask', tril(true(n),-1)); hold on; surfsc(hilb(n), 'mask', triu(true(n),1)); 
%   n=5; figure; surfsc(1./pascal(n), 'mask', tril(true(n),-1), 'XData', 0); hold on; surfsc(hilb(n), 'mask', triu(true(n),1), 'YData', 0);  
%
%


%% InputParser
[ax, args, ~] = axescheck(varargin{:}); 
if isempty(ax); ax = gca(); end

ip = inputParser(); 
ip.addRequired('CData', @(C) isnumeric(C) || islogical(C)); 

ip.addParameter('XData', 1, @(X) isnumeric(X) && numel(X)<3);
ip.addParameter('YData', 1, @(Y) isnumeric(Y) && numel(Y)<3);
ip.addParameter('ZData', @(x,y) zeros(size(x)), @(Z) isnumeric(Z) || isa(Z, 'function_handle'));

ip.addParameter('c', []); 

ip.addParameter('mask', @(x) true(size(x)), @(x) islogical(x) || isnumeric(x) || isa(x, 'function_handle')); 

ip.addParameter('surfOptions', {'EdgeColor', 'none'});

ip.parse(args{:}); 


%% Prelims
C = ip.Results.CData; 
[h,w] = size(C,1:2); 

X = ip.Results.XData; 
Y = ip.Results.YData; 
Z = ip.Results.ZData; 
if numel(X) == 1; X = X + [0, w-1]; end; dx = diff(X)/(w-1)/2;
if numel(Y) == 1; Y = Y + [0, h-1]; end; dy = diff(Y)/(h-1)/2;
[x,y] = meshgrid(linspace(X(1)-dx,X(2)+dx,w+1), ...
                 linspace(Y(1)-dy,Y(2)+dy,h+1));
if isnumeric(Z); z = Z; 
else; z = ip.Results.ZData(x,y); end
assert(all( size(z)==size(x) )); 
clear X Y Z dx dy

mask = ip.Results.mask; 
if isa(mask, 'function_handle'); mask = mask(C); 
elseif isnumeric(mask);          mask = logical(mask); end

c = ip.Results.c; 


%% Create color matrix (true or scaled) and plot

if isempty(c)
    cToPlot = nan(size(C)); 
    cToPlot(mask) = C(mask); 
else
    cToPlot = nan(numel(C),width(c)); % works whether c is true or scaled
    cToPlot(mask,:) = repmat(c, nnz(mask)/height(c), 1);
    cToPlot = reshape(cToPlot, height(C), width(C), width(c));
end

newplot(ax); 
s = surf(ax, x, y, z, +cToPlot, ip.Results.surfOptions{:});
set(ax, 'YDir', 'reverse', 'View', [0 90], 'Layer', 'bottom'); 


end


