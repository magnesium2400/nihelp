function out = imagesclu(L, U, varargin)
%% IMAGESCLU Plots lower and upper triangles of matrices using `imagesc`
%% Examples
%   figure; imagesclu(1./pascal(5), hilb(5)        ); 
%   figure; imagesclu(1./pascal(5), hilb(5),  1    ); 
%   figure; imagesclu(1./pascal(5), hilb(5),  2    ); 
%   figure; imagesclu(1./pascal(5), hilb(5), [2 0] ); 
% 
%   figure; imagesclu(1./pascal(5), -hilb(5), [2 -1]); axis('image'); colormap(flip(gray));
%   figure; imagesclu(1./pascal(5), -hilb(5), [2 -1], 'lineOptions', {'Color','k','LineWidth',3}); axis('image'); colormap(flip(gray));
%   figure; imagesclu(1./pascal(5), -hilb(5), [2 -1], 'fillVal', 0); axis('image','off'); colormap(bluewhitered);
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


%% Inputs

ip = inputParser; % only for varargin
addRequired(ip, 'L', @ismatrix);
addRequired(ip, 'U', @ismatrix);
addOptional(ip, 'offset', 0, @isnumeric);
addParameter(ip, 'fillVal', NaN, @isnumeric); 
addParameter(ip, 'lineOptions', {'Color', 'k', 'LineWidth', 1}, @iscell); 

parse(ip, L, U, varargin{:}); 
dx = ip.Results.offset(1); 
dy = ip.Results.offset(end); 
lineOptions = ip.Results.lineOptions; 


%% Prelims
sz = size(L,1); 
assert(all( sz==[size(L,2),size(U,1:2)] ), 'Input matrices must be same size squares'); 
if ~issymmetric(L) || ~issymmetric(U)
    warning('Input matrix/matrices are not symmetric'); 
end


%% Generate and plot matrix

mat = ones(sz+[dy,dx]) * ip.Results.fillVal;

trilidx = @(X,d) tril(true(size(X)),d);
triuidx = @(X,d) triu(true(size(X)),d);

mat( trilidx(mat,-dy-1) ) = L( trilidx(L,-1) );
mat( triuidx(mat, dx+1) ) = U( triuidx(U,+1) ); 

out = imagesc(mat); 


%% Plot borders
% lower lines
line([0.5 0.5],            [1.5 sz+0.5]+dy,         lineOptions{:});   % y base
line([0.5 sz-0.5],         [sz+0.5 sz+0.5]+dy,      lineOptions{:});   % x base
line([ 0.5; 0.5]+(1:sz-1), [ 0.5; 1.5]+(1:sz-1)+dy, lineOptions{:});   % y lines
line([-0.5; 0.5]+(1:sz-1), [ 0.5; 0.5]+(1:sz-1)+dy, lineOptions{:});   % x lines

% upper lines
line([1.5 sz+0.5]+dx,         [0.5 0.5],            lineOptions{:});   % y base
line([sz+0.5 sz+0.5]+dx,      [0.5 sz-0.5],         lineOptions{:});   % x base
line([ 0.5; 1.5]+(1:sz-1)+dx, [ 0.5; 0.5]+(1:sz-1), lineOptions{:});   % y lines
line([ 0.5; 0.5]+(1:sz-1)+dx, [-0.5; 0.5]+(1:sz-1), lineOptions{:});   % x lines


end



