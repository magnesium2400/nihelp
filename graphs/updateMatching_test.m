%%% Shared variables
% Dependencies: BCT, FasterMatchingIndex

allclose = @(a,b) all( abs(a-b)<1e-9 ,'all');

%% Test 1: compare to BCT and Oldham code

W = +(gallery('toeppd', 1000)<0);
% density_und(A)

fprintf('Betzel method: ');     tic; a = matching_ind_und(W); toc
fprintf('Update method: ');     tic; [~,b] = updateMatching(W); toc
fprintf('Oldham method: ');     tic; c = matching(W); toc

assert(allclose(a,b))
assert(allclose(a,c))


%% Test 2: compare update method to Oldham code

% setup
% rng(1);
W = +(gallery('toeppd', 1000)<0);
% figure; imagesc(W); axis equal tight; colorbar; title(density_und(W));

% baseline
fprintf('\nBaseline:\n');
fprintf('Update method: ');     tic; [a,m,n,d] = updateMatching(W); toc
fprintf('Oldham method: ');     tic; b = matching(W); toc

assert(allclose(m,b))

% find random new edge to add
[x,y] = find(~(W+eye(size(W))));
tmp = randi(length(x),1);
x = x(tmp); y = y(tmp); 
W(x,y) = 1; W(y,x) = 1; 

% updating vs recalculating
fprintf('Single edge added:\n'); 
fprintf('Update method: ');     tic; [a,m,n,d] = updateMatching(a,m,n,d,x,y); toc % Note: original adj mat used as input
fprintf('Oldham method: ');     tic; b = matching(W); toc

assert(allclose(m,b))

% double check that updateMatching actually updates adj mat properly!
assert(isequal(W,a)); 



%% Test 3: add multiple edges

nNewEdges = 100; 

% setup
% rng(1);
W = +(gallery('toeppd', 1000)<0);
% figure; imagesc(W); axis equal tight; colorbar; title(density_und(W));

% baseline
fprintf('\nBaseline:\n');
fprintf('Update method: ');     tic; [a,m,n,d] = updateMatching(W); toc
fprintf('Oldham method: ');     tic; b = matching(W); toc

% find random new edges to add
[x,y] = find(~W);
[x,y] = deal(x(x>y), y(x>y)); % lower triangle only
newEdges = randsample(length(x), nNewEdges);

% add new edges - update method
fprintf('Add %i edges:\n', nNewEdges);
fprintf('Update method: '); 
tic
for ii = 1:length(newEdges)
    [a,m,n,d] = updateMatching(a,m,n,d,x(ii),y(ii));
end
toc

% add new edges - oldham method
fprintf('Oldham method: ');  
tic
for ii = 1:length(newEdges)
    W(x(ii),y(ii)) = 1; W(y(ii),x(ii)) = 1; 
    b = matching(W);
end
toc

% double check that updateMatching actually updates adj mat properly!
assert(isequal(W,a)); 
assert(allclose(m,b))







