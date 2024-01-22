% Shared variables
V = (1:10).'+(1:5)+permute(1:20,[1,3,2])-2;
% D = ((loadmri)+(1:128).').*logical(loadmri);
warning('off', 'nihelp:rotateVolumeOdd');

%% Test 1: Test inversions
assert(isequal(V, rotateVolume(V, 'pir', 'pir')));
assert(isequal(V, rotateVolume(rotateVolume(V, 'pir', 'sra'), 'sra', 'pir')));

%% Test 2: Test flips only
assert(isequal(flip(V, 2), rotateVolume(V, 'ali', 'ari')));
assert(isequal(flip(flip(V, 2), 3), rotateVolume(V, 'ali', 'ars')));

%% Test 3: Test permutations only
assert(isequal(permute(V, [1 3 2]), rotateVolume(V, 'ali', 'ail')));
assert(isequal(permute(V, [3 1 2]), rotateVolume(V, 'ali', 'ial')));

%% Test 4: Figures (for manual inspection)
src = 'ras'; tgt = {'rsa', 'pir', 'ilp'};
figure; nexttile(); plotVolume(V); title(src);
for ii = 1:length(tgt)
    nexttile(); plotVolume(rotateVolume(V,src,tgt{ii})); title(tgt{ii});
end

warning('on', 'nihelp:rotateVolumeOdd');