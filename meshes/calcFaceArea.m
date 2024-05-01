function out = calcFaceArea(verts, faces)
%% CALCFACEAREA gets area of each face in a surface patch object
%% Examples
%   rng(10); v=rand(100,2); f=delaunay(v(:,1),v(:,2)); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   [x,y]=meshgrid(1:10); v=[x(:),y(:)]; f=delaunay(v(:,1),v(:,2)); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   [x,y]=meshgrid(1:10); z=repmat(1:10,10,1)*sqrt(3); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   [x,y]=meshgrid((1:10).^2); z=x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   [x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
%   if ~isempty(which('getFaceArea')); [x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcFaceArea(v,f); b=arrayfun(@(ii)getFaceArea(struct('vertices',v),f,ii),1:length(f)).'; figure; scatter(a,b); title(string(all(isclose(a,b)))); end
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


if      size(verts,2) == 2; verts(:,3) = 0; 
elseif  size(verts,2) ~= 3; error('Vertices should be 2 or 3 dimensional'); end
assert(size(faces, 2) == 3);
assert(max(faces,[],'all') >= size(verts,1));

temp = permute(reshape( verts(faces(:),:),[],3,3 ) , [1 3 2]);
temp2 = cross(temp(:,:,2) - temp(:,:,1), temp(:,:,3) - temp(:,:,1));
out = vecnorm(temp2,2,2)/2;

end







%% More Examples: 
% [x,y] = meshgrid(1:20); f=delaunay(x,y); z=peaks(20); a=calcFaceArea([x(:),y(:),z(:)],f);
% figure; nexttile; patch('Vertices', [x(:),y(:),z(:)], 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
% t = all(diff(x(f),[],2) == [0,1],2); zf = @(ii) z(f(t,ii));
% nexttile; scatter(sqrt((zf(2)-zf(3)).^2+(zf(1)-zf(2)).^2+1),2*a(t)');
% t = all(diff(y(f),[],2) == [0,1],2); zf = @(ii) z(f(t,ii));
% nexttile; scatter(sqrt((zf(1)-zf(3)).^2+(zf(1)-zf(2)).^2+1),2*a(t)');
% 
% x = [1;1;0]+(1:10);
% y = [0;1;1]+zeros(1,10);
% z = [0;1;0]+zeros(1,10); z(3,:) = rand(1,10); z3 = z(3,:); 
% f = [1,2,3]+(3:3:30).'-3;
% a = calcFaceArea([x(:),y(:),z(:)],f);
% figure; nexttile; patch('Vertices', [x(:),y(:),z(:)], 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a);
% axis equal; colorbar; view([30 15]);
% nexttile; scatter(sqrt((1-z3).^2+2),2*a);

%% Old way:
% temp = zeros( length(faces), 3, 3 );
% for ii = 1:length(faces)
%     temp(ii,:,:) = verts(faces(ii,:),:)';
% end
