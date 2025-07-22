%%% Shared variables

% User inputs
doPlot = true; 
V = double(load("spiralVol.mat", "spiralVol").spiralVol(2:2:end,2:2:end,2:2:end));

% Other data
[v,d] = vol2xyz(V, logical(V)); 
ff = @(sz) cellfun(@feval, {@() axis('equal'), @() xlim([1,sz(1)]), @() ylim([1,sz(2)]), @() zlim([1,sz(3)]), @xyzlabel}); 

% Visualise if desired
if doPlot; figure; 
    nexttile; plotVolume(V); 
    nexttile; plotVolume(+logical(V), 'c', d);         % as d has been derived from vol2xyz, the vertices are in the same order
    nexttile; scat3(v, [], d, 'filled'); ff(size(V)); 
end


%% Test that rotateVolumeIdx and rotateVolume do the same thing

Vr = rotateVolume(V, 'ras', 'sal');
dr = nonzeros(Vr); 

ii = rotateVolumeIdx(V, 'ras', 'sal'); 
di = d(ii);

assert(isequal(dr, di))


if doPlot; figure; 
    % nexttile; plotVolume(V); 
    v2 = vol2xyz(Vr, logical(Vr)); 
    nexttile; plotVolume(Vr); 
    nexttile; plotVolume(Vr, 'c', di); 
    nexttile; scat3(v2, [], di, 'filled'); ff(size(Vr)); 
    % nexttile; plotVolume(Vr, 'c', dr); 
    % nexttile; scat3(v2, [], dr, 'filled'); ff(size(Vr));
end


%% Test that unrotateVolumeIdx and rotateVolume do complementary things

Vr = rotateVolume(V, 'ras', 'sal');
dr = nonzeros(Vr); 

ii = unrotateVolumeIdx(V, 'sal', 'ras'); 
di = dr(ii);

assert(isequal(d, di))

if doPlot; figure; 
    nexttile; plotVolume(V); 
    nexttile; plotVolume(V, 'c', d); 
    nexttile; scat3(v, [], di, 'filled'); ff(size(V)); 
    % nexttile; plotVolume(Vr); 
    % nexttile; scat3(v2, [], dr, 'filled'); ff(size(Vr)); 
end


%% Compare rotateVolumeIdx back and forth

idx1 = rotateVolumeIdx(V, 'pir', 'ras'); 
idx2 = rotateVolumeIdx(rotateVolume(V, 'pir', 'ras'), 'ras', 'pir'); 

% isequal(idx1, idx2)
assert(isequal(idx1(idx2), (1:nnz(V))'))


%% Compare rotateVolumeIds and unrotateVolumeIdx

idx1 = rotateVolumeIdx(V, 'pir', 'ras'); 
idx2 = unrotateVolumeIdx(rotateVolume(V, 'pir', 'ras'), 'pir', 'ras'); 

assert(isequal(idx1, idx2))
% isequal(idx1(idx2), (1:nnz(V))')


%% What if coordinates are in a different order to the data?
% % % % % 
% % % % % % Choose an orientation - this test should solve for this orientation
% % % % % hiddenOrientation = 'pir'; % Feel free to change this
% % % % % 
% % % % % % Generate data where d and v are different orientations
% % % % % d = nonzeros(V); 
% % % % % Vr = rotateVolume(V, 'ras', hiddenOrientation); 
% % % % % v = vol2xyz(Vr, logical(Vr)); 
% % % % % 
% % % % % % Find hiddenOrientation using V, v, d
% % % % % allOrientations = [...
% % % % %     "ras","rai","rps","rpi","las","lai","lps","lpi",...
% % % % %     "rsa","ria","rsp","rip","lsa","lia","lsp","lip",...
% % % % %     "asr","air","psr","pir","asl","ail","psl","pil",...
% % % % %     "ars","ari","prs","pri","als","ali","pls","pli",...
% % % % %     "sar","iar","spr","ipr","sal","ial","spl","ipl",...
% % % % %     "sra","ira","srp","irp","sla","ila","slp","ilp"];
% % % % % 
% % % % % % Visualise at this point
% % % % % if doPlot; figure; 
% % % % %     nexttile; plotVolume(V); 
% % % % %     nexttile; scat3(v, [], d, 'filled'); axis equal; 
% % % % % end
% % % % % 
% % % % % % Check orientations
% % % % % for ii = allOrientations(1:5)
% % % % %     ii = unrotateVolumeIdx(V, 'ras', ii); 
% % % % %     d2 = d(ii); 
% % % % %     nexttile; 
% % % % % 
% % % % % end


