ccc
[v,f] = equilateralMesh(14);
% v = [1,0,0; 0,1,0; 0,0,0]; v = [v;v+1];  f = [1,2,3; 4,5,6];
% v = [1,0,0; 0,1,0; 0,0,0]; f = [1,2,3];
m = 13; 

%%% prelims
nv = height(v); 
nf = height(f); 

tr = triangulation(f,v); 

e = [ f(:,[1,2]) ; f(:,[2,3]) ; f(:,[3,1]) ]; 
[es, eo] = sort(e,2);
[E, ~, ej] = unique(es,'rows','sorted');
ej = reshape(ej, [], 3) %#ok<*NOPTS>
eo = reshape(eo(:,1), [], 3)-1;

f, e, E, eo

nE = height(E); 

%%% delaunay structure

z = zeros(1,m-1);
vnc = [m,0; 0,m; 0,0];
vne = [m-1:-1:1, z, 1:m-1;...
       1:m-1, m-1:-1:1, z ]';
[a,b] = meshgrid(1:m-2, m-2:-1:1); 
vnf = [tril2vec(b,0,1), tril2vec(a,0,1)];
clear a b

vn = [vnc; vne; vnf]; 
D = delaunay(vn); 

% figure; patchvfc(vn, D); 
% hold on; scat(vn,[],(1:height(vn))','filled'); addScatterLabels; 


%%% make all new verts
vne = arrayfun2mat(@(ii) [m-1:-1:1; 1:m-1]'/m*v(E(ii,:),:)   , (1:nE)'); 

vnf = arrayfun2mat(@(ii) barycentricToCartesian(tr,ii*ones(height(vnf),1),[vnf,m-sum(vnf,2)]/m), (1:nf)'); 


% figure; 
% scat3(v,'filled'); 
% hold on; axis equal tight off; 
% scat3(vne,'filled'); 
% scat3(vnf,'filled'); 

vn = [v; vne; vnf];

figure; 
scat3(vn, [], (1:height(vn))', 'filled'); addScatterLabels; 
axis equal tight; view(2); 


%%% renumber delaunay structure for each face
fn = repmat(D, 1, 1, nf); 
flipflag = @(vec,flag) (1-flag)*vec + (flag)*flip(vec); % flag to 0 or 1 

for ii = 1:size(fn,3)

    new = [f(ii,:), ...
        nv+(ej(ii,1)-1)*(m-1) + (1:m-1), ...
        nv+(ej(ii,2)-1)*(m-1) + (1:m-1), ...
        nv+(ej(ii,3)-1)*(m-1) + (1:m-1), ...
        nv+nE*(m-1)+(ii-1)*(m-2)*(m-1)/2+(1:(m-2)*(m-1)/2)];


    old = [1 2 3, ...
        flipflag( 4:m+2,   eo(ii,1) ), ...
       flipflag( m+3:2*m+1, eo(ii,2) ), ...
       flipflag( 2*m+2:3*m, eo(ii,3) ), ...
       3*m+(1:((m-2)*(m-1))/2)];

    fn(:,:,ii) = renumber(fn(:,:,ii), new, old); 

    % fn(:,:,ii) = renumber(fn(:,:,ii),                  f(ii,:), [1 2 3]); 
    % fn(:,:,ii) = renumber(fn(:,:,ii), nv+(ej(ii,1)-1)*(m-1) + (1:m-1) ,     flipflag( 4:m+2,   eo(ii,1) ) ); 
    % fn(:,:,ii) = renumber(fn(:,:,ii), nv+(ej(ii,2)-1)*(m-1) + (1:m-1) ,   flipflag( m+3:2*m+1, eo(ii,2) ) ); 
    % fn(:,:,ii) = renumber(fn(:,:,ii), nv+(ej(ii,3)-1)*(m-1) + (1:m-1) , flipflag( 2*m+2:3*m,   eo(ii,3) ) ); 
    % fn(:,:,ii) = renumber(fn(:,:,ii), nv+nE*(m-1)+(ii-1)*(m-2)*(m-1)/2+(1:(m-2)*(m-1)/2), 3*m+(1:((m-2)*(m-1))/2)); 
end


fn = reshape(permute(fn,[1 3 2]),[],3); 
% figure; 
hold on; patchvfc(vn, fn);
axis equal tight; view(2); 



