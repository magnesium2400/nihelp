function [p,X,Y,C] = plotc(X,Y,C, patchOptions, ax)
%% PLOTC Plot lines according to a colormap
%% Syntax
%  plotc(X,Y,C)
%  plotc([],Y,C)
%  plotc([],Y,[])
%  plotc(___,patchOptions)
%  plotc(___,patchOptions,ax)
%
%  p = plotc()
%
%
%% Description
%
%
%
%% Examples
% % Examples of functionality  
%   figure; plotc(1:3, 1:3, 1); colormap hot; colorbar                      % color a line according to colorbar
%   figure; plotc(1:3, 1:3, 1:3);                                           % plot a multicolored line
%   figure; plotc(1:3, (1:3)+(1:3)', 1:3);  colormap cool(3); colorbar      % plot several lines
%   figure; plotc(1:3, (1:3)+(1:3)', 1:3);  colormap lines(3); colorbar     % plot several lines
%   figure; plotc(1:3, (1:3)+(1:3)', (1:3)+(1:3)');  colormap cool;         % plot several colored lines
%   figure; plotc([], 1:3, []); colormap hot; colorbar                      % default values
% 
% % Examples of syntactic variations:
%   figure; plotc(  1:3   ,  1:3   ,  1:3   );   
%   figure; plotc(  1:3   , (1:3)' ,  1:3   );   
%   figure; plotc( (1:3)' ,  1:3   ,  1:3   );   
%   figure; plotc( (1:3)' , (1:3)' ,  1:3   );   
%   figure; plotc(  1:3   ,  1:3   , (1:3)' );   
%   figure; plotc(  1:3   , (1:3)' , (1:3)' );   
%   figure; plotc( (1:3)' ,  1:3   , (1:3)' );   
%   figure; plotc( (1:3)' , (1:3)' , (1:3)' );   
%   
%   figure; plotc(1:5, magic(5), (1:5));
%   figure; plotc(1:5, magic(5), (1:5)');
%   figure; plotc(magic(5), 1:5, (1:5));
%   figure; plotc(magic(5), (1:5)', (1:5)');
%   figure; plotc(magic(5), magic(5)+(1:5), magic(5));
%   figure; plotc(magic(5), magic(5)+(1:5), magic(5)');
%
%
%% Input Arguments
%
%
%
%
%
%
%% Output Arguments
%
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% See Also
% PLOT, PATCH
%
%


%% Prelims

if isempty(X)
    if isvector(Y); X = (1:numel(Y))';
    else;           X = (1:height(Y))'; end
end

if isempty(C)
    if isvector(Y); C = (1:numel(Y))';
    else;           C = (1:height(Y))'; end
end


if isvector(X)
    vecDimX = find(size(X) ~= 1);
    vecDimY = find(size(Y) == size(X,vecDimX),1);
    Y = permute(Y, [vecDimY, setdiff(1:ndims(Y), vecDimY)]);
    X = reshape(X, [], 1);
    X = repmat(X, 1, width(Y));
elseif isvector(Y)
    vecDimY = find(size(Y) ~= 1);
    vecDimX = find(size(X) == size(Y,vecDimY),1);
    X = permute(X, [vecDimX, setdiff(1:ndims(X), vecDimX)]);
    Y = reshape(Y, [], 1);
    Y = repmat(Y, 1, width(X));
else
    assert(all(size(X) == size(Y))); 
end


if isvector(C)
    if     width(C)  == height(Y) && width(C)  ~= width(Y)
        C = C'; 
    elseif height(C) == width(Y)  && height(C) ~= height(Y)
        C = C';
    end
    C = repmat(C, height(Y)/height(C), width(Y)/width(C));
else
    assert(all(size(C) == size(X)) || all(size(C) == size(Y))); 
end


if nargin < 4 || isempty(patchOptions)
    patchOptions = {'FaceColor', 'none', 'EdgeColor', 'interp'};
end

if nargin < 5 || isempty(ax)
    ax = gca;
end



%% Plot
X(end+1,:) = NaN;
Y(end+1,:) = NaN;
C(end+1,:) = NaN;

p = arrayfun( ...
    @(ii) patch(ax, 'XData', X(:,ii), 'YData', Y(:,ii), ...
    'FaceVertexCData', C(:,ii), patchOptions{:}), ...
    1:width(Y));

end










