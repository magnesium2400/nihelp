function [v2, f2, a2] = dualTriangulation(v, f)
%% DUALTRIANGULATION Find the dual polyhedron of a triangular mesh
%% Examples
%   [v,f] = equilateralMesh(20); v2 = dualTriangulation(v,f); 
%   [v,f] = equilateralMesh(20); v2 = dualTriangulation(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); hold on; scatter3(v2(:,1), v2(:,2), v2(:,3));    
%   [v,f] = equilateralMesh(20); [v2,f2] = dualTriangulation(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); hold on; patch('Vertices', v2, 'Faces', f2, 'FaceColor', 'w');   
%   
%   [v,f] = equilateralMesh(20); [v2,f2] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; patchvfc(v2,f2,'w'); view(3);  
%   [v,f] = equilateralMesh(4); [v2,f2] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; patchvfc(v2,f2,'w');  view(3);  
%   [v,f] = equilateralMesh(4); [v,f] = increasePatch(v,f,3); [v2,f2] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; patchvfc(v2,f2,'w');  view(3);   
%
%   figure; for ii = setdiff(4:2:20,18); [v,f] = equilateralMesh(ii); [v2,f2] = dualTriangulation(v,f); nexttile; plotSkeleton(v,f); hold on; patchvfc(v2,f2,'w'); view(3); end  
% 
%   [v,f] = equilateralMesh(20); [v2,~,a] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; plotSkeleton(v2,a,'nonTriangular',true);  view(3);  
%   [v,f] = equilateralMesh(4); [v2,~,a] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; plotSkeleton(v2,a,'nonTriangular',true); view(3);  
%   [v,f] = equilateralMesh(4); [v,f] = increasePatch(v,f,3); [v2,~,a] = dualTriangulation(v,f); figure; plotSkeleton(v,f); hold on; plotSkeleton(v2,a,'nonTriangular',true); view(3);   
%
%   figure; for ii = setdiff(4:2:20,18); [v,f] = equilateralMesh(ii); [v2,~,a] = dualTriangulation(v,f); nexttile; plotSkeleton(v,f); hold on; plotSkeleton(v2,a,'nonTriangular',true); view(3); end  
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


%% New vertices
V = cat(3, v(f(:,1),:), v(f(:,2),:), v(f(:,3),:));
v2 = mean(V, 3); 
if nargout < 2; return; end


%% New adjacency matrix
% Find all edges and the faces they are on
e = triangulation2edges(f); 
e = sort(e,2); 
e(:,3) = repmat((1:height(f))', 3, 1); 
e = sortrows(e); 

% Find the faces that share the same edge
% Then generate adj matrix encoding this
d = diff(e,[],1); 
facesIdx = all(~d(:,1:2), 2); %d(:,1) == 0 & d(:,2) == 0;
a2 = sparse(e(find(facesIdx),3), e(find(facesIdx)+1,3), true, height(f), height(f)); %#ok<FNDSB> 


%% New faces
f2 = nan( max(f,[],'all'), max(groupcounts(f(:))) );
% generate sparse matrix that encodes faces-vertex relationships
g = sparse(repmat((1:height(f))',1,3) , f, true, height(f), max(f,[],'all')); 

vertsTodo = 1; 
vertsDone = false(height(v), 1); 

% BFS over old vertices to find the new faces
% For each old vertex: need to find the neighbouring vertices in order
while any(~vertsDone)
    vertCurr = vertsTodo(1);
    if vertsDone(vertCurr); vertsTodo = vertsTodo(2:end); continue; end
    
    % find faces containing current vertex
    facesMask = g(:, vertCurr); 
    facesIdx = find(facesMask);
    facesCurr = f(facesMask,:); 

    % get current neighbours
    ncurr = removeXFromY(vertCurr, facesCurr);
    ncurr = sort(ncurr);  
    
    % check each neighbour occurs twice; if not, skip current vertex
    if ~isequal(ncurr(1:2:end), ncurr(2:2:end))
        vertsDone(vertCurr) = true; 
        vertsTodo = vertsTodo(2:end); 
        continue; 
    end    

    ncurr = ncurr(1:2:end);

    % find the cycle around the vertices
    % get the new faces IDs associated with this cycle 
    [newVerts, newFace] = deal(nan(1,numel(facesIdx))); 
    newVerts(1:2) = removeXFromY(vertCurr,facesCurr(1,:));
    newFace(1) = facesIdx(1); 
    gcurr = g(facesMask,ncurr); % faster to index outside than repeatedly index inside
    for ii = 3:length(newVerts)
        m2 = gcurr(:, newVerts(ii-1)==ncurr);
        m3 = gcurr(:, newVerts(ii-2)==ncurr);
        tmp = facesCurr(m2,:);
        newVerts(ii) = removeXFromY([vertCurr,newVerts(ii-1),newVerts(ii-2)], tmp);
        newFace(ii-1) = facesIdx(m2&~m3); 
    end
    newFace(end) = removeXFromY(newFace, facesIdx); 

    % put in output matrix
    f2(vertCurr,1:width(newFace)) = newFace; 

    % set up for next iteration
    vertsTodo = [vertsTodo(2:end), newVerts(~vertsDone(newVerts))]; 
    vertsDone(vertCurr) = true; 
end


end % main


%% HELPERS
function out = removeXFromY(x,y)
if numel(x) == 1
out = y(y~=x); 
else
out = y(~any(y(:)==x(:)',2)); % this is faster than ismember for th
% out = y(~ismember(y,x));
end 
end




