function tl = tlfunc(tl, func, flag)
%% TLFUNC Apply function throughout tiledlayout
%% Examples
%   figure; arrayfun(@nexttile,1:20); tlfunc([],@(x) plot(1:10));
%   figure; arrayfun(@nexttile,1:20); tlfunc([],@(x) plot(1:x), 'index');
%   figure; tl=tiledlayout('flow'); arrayfun(@nexttile,1:20); tlfunc(tl,@title, 'index');
%   figure; tl=tiledlayout('flow'); arrayfun(@nexttile,1:20); tlfunc(tl,@(x,y)title(y,x), 'subscript');
%   figure; tl=tiledlayout('flow'); arrayfun(@nexttile,1:20); tlfunc(tl,@(x) imagesc(magic(x)), 'index'); tlfunc(tl, @colorbar);
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

if isempty(tl) && (numel(findobj(gcf, 'Type', 'Tiled'))==1); tl = findobj(gcf, 'Type', 'Tiled'); end
if nargin < 3 || isempty(flag); flag = 'none'; end

for ii = 1:length(findobj(tl.Children, 'type', 'Axes'))
    
    ax = nexttile(tl, ii); 

    switch flag
        case 'none'
            func(); 
        case 'index'
            func(ii);
        case 'subscript'
            [r,c] = ind2sub(flip(tl.GridSize),ii);
            func(r,c);

        case 'axnone'
            func(ax); 
        case 'axindex'
            func(ax,ii);
        case 'axsubscript'
            [r,c] = ind2sub(flip(tl.GridSize),ii);
            func(ax,r,c);
            
        otherwise
            try
                func(get(ax, flag))
            catch
                func(get(ax.Children, flag))
            end
    end

end


end
