function out = imagesclu(L, U)


%% TODO
% * user-specify border
% * user-specfy diagonal elements
% * remake this using patch: 
    % [x,y] = meshgrid(1:3);
    % v = [x(:), y(:)];
    % f = [1 2 5 4; 4 5 8 7; 2 3 6 5; 5 6 9 8];
    % figure; 
    % out = patch('vertices', v, 'faces', f, ...
    %     'FaceVertexCData', [1;2;3;4], 'FaceColor', 'flat', 'EdgeColor', 'none');
    % axis off; 





if ~ismatrix(L) || ~ismatrix(U)
    error('Input data are not matrices'); 
end

issquare = @(x) size(x,1) == size(x,2);
if ~issquare(L) || ~issquare(U)
    warning('Input matrix/matrices are not square'); 
end

if ~issymmetric(L) || ~issymmetric(U)
    warning('Input matrix/matrices are not symmetric'); 
end

if ~all(size(L) == size(U))
    warning('Inputs matrix/matrices are not the same size'); 
end

sl = min(size(L)); 
su = min(size(U)); 

tl = tril(L, -1); 
tl = tl(1:sl, 1:sl); 

tu = triu(U, 1); 
tu = tu(1:su, 1:su); 



figure; 
out = imagesc(tl + tu); 
box off; axis off; 

cmap = colormap; 
clims = clim; 
colorbar;

lineOptions = {'Color', 'k', 'LineWidth', 1};

% lower lines
line([0.5 0.5], [1.5 sl+0.5], lineOptions{:});                      % y base
line([0.5 sl-0.5], [sl+0.5 sl+0.5], lineOptions{:});                % x base
line([ 0.5; 0.5]+(1:sl-1), [ 0.5; 1.5]+(1:sl-1), lineOptions{:});   % y lines
line([-0.5; 0.5]+(1:sl-1), [ 0.5; 0.5]+(1:sl-1), lineOptions{:});   % x lines




end



