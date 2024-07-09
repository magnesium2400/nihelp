%% MESHCENTREEXAMPLES Examples of using meshFrechet etc
% This can also be used as a visual test suite.

n = 19; 
meshCentre = @meshFrechet; % or meshIncentre or meshCircumcentre

%%
% Generate dummy mesh (regular)
[v,f] = hexMesh(n); 

% Get centre
c = meshCentre(v,f); 

% Data vis
figure; patchvfc(v,f); axis equal tight; 
hold on; scat(v(c,:), [], 'r', 'filled'); 


%%
% Generate dummy mesh (regular)
[v,f] = squareMesh3(n,n); 

% Get centre
c = meshCentre(v,f); 

% Data vis
figure; patchvfc(v,f); axis equal tight; 
hold on; scat(v(c,:), [], 'r', 'filled'); 


%%
% Generate dummy mesh (not regular)
[v,f] = hexMesh(n); 
v(:,1) = v(:,1) .* (1+(v(:,1)>0)*n) + n;

% Get centre
c = meshCentre(v,f); 

% Data vis
figure; patchvfc(v,f);
hold on; scat(v(c,:), [], 'r', 'filled'); 


%% 
% Generate dummy mesh (not regular)
v1 = squareMesh3(n); 
v2 = squareMesh3(n-1) + [.5 .5 0];
v = [v1;v2]; 
f = delaunay(v(:,[1 2])); 
v(v(:,1)==n,1) = 2*n-3; 

% Get centre
c = meshCentre(v,f); 

% Data vis
figure; patchvfc(v,f); axis equal tight; 
hold on; scat(v(c,:), [], 'r', 'filled'); 


%% 
% Generate dummy mesh (not regular)
v1 = squareMesh3(n); 
v2 = squareMesh3(n)./[n+1,1,1] + [1 0 0];
v = [v1;v2]; 
f = delaunay(v(:,[1 2])); 
% v(v(:,1)==n,1) = 2*n-3; 

% Get centre
c = meshCentre(v,f); 

% Data vis
figure; patchvfc(v,f); axis equal tight; 
hold on; scat(v(c,:), [], 'r', 'filled'); 

