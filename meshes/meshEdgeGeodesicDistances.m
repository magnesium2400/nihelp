function [d,g] = meshEdgeGeodesicDistances(verts, faces, sources, targets, radius)
%% MESHEDGEGEODESICDISTANCES Calculates distances between vertices on 3d triangulated mesh
%% Usage Notes
% * Time taken on fsLR downsampled meshes: 5k, 1.5 seconds; 10k, 6 seconds; 32k,
% 50 seconds
% * You can select a subset of the vertices to be used as sources/targets, or a
% maximum radius within which to compute distances. However using both
% concurrently is not (yet) supported. 
%
% 
%% Examples
%   [x,y] = meshgrid(1:20,1:30); x=x(:); y=y(:); z=ones(size(x)); f=delaunay(x,y); v=[x,y,z]; d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:21:400; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
%   [x,y] = meshgrid(1:20); x=x(:); y=y(:); z=10*sin(x)+0.1*(y-10).^2; f=delaunay(x,y); v=[x,y,z]; d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:40:400; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
%   [v,f] = torusMesh(10); d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:8:90; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
%   [v,f] = torusMesh(200); d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:900:9900; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'none'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
% 
%   [v,f] = equilateralMesh(20); d = meshEdgeGeodesicDistances(v,f,[],[],1.01); assert(all(sum(isnan(d))==7));
%   [v,f] = torusMesh(40); d = meshEdgeGeodesicDistances(v,f,[],[],1); figure; for ii = 1:100:1200; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'none'); axis image; colorbar; end 
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


%% Create graph
x = reshape(faces,            [], 1);       % indices of edges
y = reshape(faces(:,[2 3 1]), [], 1);
v = vecnorm(verts(x,:) - verts(y,:), 2, 2); % distance between adjacent vertices
g = graph(x, y, v, size(verts, 1)); 


%% Distances if radius is not specified (can be restricted set of nodes)
if nargin < 3 || isempty(sources); sources = 'all'; end
if nargin < 4 || isempty(targets); targets = 'all'; end

if nargin < 5 || isempty(radius)
    d = distances(g, sources, targets);
    return;
end


%% Distances if radius is specified

d = nan(height(verts)); 

for ii = 1:height(verts) 
    [a,b] = nearest(g, ii, radius);
    d(a,ii) = b;
end

end

% % % % % f = @(x) distances(g, x, 'all'); 
% % % % % 
% % % % % %%% Create 6 anchors, use these to _estimate_ the r-neighbourhood of each point
% % % % % A     = 1;                                              dA = f(A); 
% % % % % [~,B] = min( abs(dA-median(dA)) );                      dB = f(B); 
% % % % % [~,C] = min( abs(dA-median(dA)) + abs(dB-median(dB)) ); dC = f(C); 
% % % % % [~,D] = max(dA);                                        dD = f(D); 
% % % % % [~,E] = max(dB);                                        dE = f(E);
% % % % % [~,F] = max(dC);                                        dF = f(F); 
% % % % % 
% % % % % temp = cat(3, dA-dA', dB-dB', dC-dC', dD-dD', dE-dE', dF-dF'); 
% % % % % targetMask = all(temp<=radius, 3); %%% This is the estimation for each point
% % % % % clear temp; 
% % % % % 
% % % % % %%% Then calculate the actual distance from each point to each other point in
% % % % % %%% its neighbourhood
% % % % % d = nan(height(verts)); 
% % % % % 
% % % % % q = [0 0.5 1]; 
% % % % % qA = quantile(dA,q); 
% % % % % qB = quantile(dB,q); 
% % % % % qC = quantile(dC,q); 
% % % % % 
% % % % % for ii = 1:2
% % % % %     for jj = 1:2
% % % % %         for kk = 1:2
% % % % %             sourceMask = ...
% % % % %                 dA>=qA(ii) & dA<=qA(ii+1) & ...
% % % % %                 dA>=qB(jj) & dA<=qB(jj+1) & ...
% % % % %                 dC>=qC(kk) & dC<=qC(kk+1);
% % % % %             temp = any(targetMask(:,sourceMask),2);  
% % % % %             temp2 = distances(g, find(sourceMask), find(temp)); 
% % % % %             d(sourceMask, temp) = temp2; 
% % % % %         end
% % % % %     end
% % % % % end
% % % % % d(d>radius) = nan; 
% % % % % 
% % % % % % for ii = 1:height(verts)
% % % % % %     temp = distances(g, ii, find(targetMask(:,ii))); 
% % % % % %     temp(temp>radius) = nan; %%% Remove any points which end up being extraneous 
% % % % % %     d(ii, targetMask(:,ii)) = temp; 
% % % % % % end