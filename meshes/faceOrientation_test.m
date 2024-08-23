% Tests proceed as follows: 
% * Generate mesh
% * Choose random subset of faces (in vector `idx`): flip these
% * Run `faceOrientation` on faces matrix; note that this function always starts
% at face #1 (for each component)
% * Check that results match the faces flipped in step 2 in two cases: (i) face
% #1 not in `idx` --> `idx` should be negative and other faces should be
% positive; (ii) face #1 in `idx` --> `idx` should be positive and other faces
% should be negative

%%% Shared variables
% This is a helper function for the above. It is a bit simplified and needs to
% be called quite precisely. 
isCorrect = @(fo, idx) ...
    all( fo(idx)                        ==  2*ismember(1,idx) - 1 ) && ...
    all( fo(setdiff(1:numel(fo),idx))   ==  1 - 2*ismember(1,idx) );


%% Test 0: Check that all surfaces in `equilateralMesh` have consistent orientation
for ii = setdiff(4:2:20, 18)
    [~,f] = equilateralMesh(ii); 
    fo = faceOrientation(f); 
    assert(all( fo == 1 )); 
end


%% Test 1: 1-component surfaces with half the faces flipped

rng(1); 
for ii = setdiff(4:2:20, 18)
    [~,f] = equilateralMesh(ii); 
    idx = randsample(ii, ii/2); 
    f(idx,:) = f(idx, [1 3 2]);
    fo = faceOrientation(f);
    % disp(idx); disp(fo); 
    assert(all( fo(idx) == 2*ismember(1,idx)-1 ))
    assert(all( fo(setdiff(1:ii,idx)) == 1-2*ismember(1,idx) ))
    assert( isCorrect(fo,idx) )
end



%% Test 2: 2-component surfaces

clc 

% Generate mesh
nf = setdiff(4:2:20, 18);
[v1,f1] = equilateralMesh(randsample(nf,1));
[v2,f2] = equilateralMesh(randsample(nf,1));
v = [v1; v2+[10 0 0]];
f = [f1; f2+max(f1(:))];

% Flip some faces
idx = randsample(height(f), height(f)/2);
f(idx,:) = f(idx, [1 3 2]);
fo = faceOrientation(f);

disp(idx); disp(fo);

% Test
assert(all( abs(fo(1:height(f1)))     == 1 )); 
assert(all( abs(fo(height(f1)+1:end)) == 2 )); 
assert(isCorrect(  fo(1:height(f1)) , idx(idx<=height(f1))  ))
assert(isCorrect(  fo(height(f1)+1:end)/2 , idx(idx>height(f1)) - height(f1)  ))


%% Test 3: Timings

clc

nDouble = 7;
for ii = 0:nDouble
    [v,f] = equilateralMesh(20); 
    [v,f] = increasePatch(v,f,ii); 
    
    if ii==1; figure; end; nexttile; patchvfc(v,f,onesz(f),'EdgeColor','k'); axis equal tight; view(3); 
    fprintf('%6i faces: ', height(f));

    tic;
    fo = faceOrientation(f);
    toc;
    assert(all( fo==1 ))
end






