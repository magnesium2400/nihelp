%%% Shared variables

%%% User inputs incl. Square mesh surface 
nModes = 98; nData = 6; 
[v,f] = squareMesh3(20);
s = struct('vertices', v, 'faces', f);

%%% Calc modes and other parameters
s = calc_geometric_eigenmode(s, nModes);
nVerts = height(s.vertices);

w = rand(nModes, nData); 
data = s.evecs * w; 


%% Test 1: Defaults
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data, s.evecs);

% check size/shape of outputs
assert(all( size(corrCoeffs) == [nModes, nData]             ))
assert(all( size(recon)      == [nVerts, nModes, nData]     ))
assert(all( size(betaCoeffs) == [nModes, 1]                 ))

% check correlation ends at 1 and weights are correctly calculated
assert(allclose( corrCoeffs(end,:), 1 ))
assert(allclose( betaCoeffs{end} , w ))

% check regression terms are non-negative (within machine error) and
% increasing
assert(all( (corrCoeffs(1,:)  >= -1e-9) | isnan(corrCoeffs(1,:)) ))
d12 = diff(corrCoeffs(1:2,:)); assert(all( d12 >= 0 | isnan(d12)  ))
assert(all( diff(corrCoeffs(2:end,:)) >= 0, 'all' ))

% figure; plot(corrCoeffs); 


%% Test 2: Orthogonal method
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data, s.evecs, 'orthogonal', [], s.mass);

% check size/shape of outputs
assert(all( size(corrCoeffs) == [nModes, nData]            ))
assert(all( size(recon)      == [nVerts, nModes, nData]    ))
assert(all( size(betaCoeffs) == [nModes, 1]                ))

% check correlation ends at 1 and weights are correctly calculated
assert(allclose( corrCoeffs(end,:), 1 ))
assert(allclose( betaCoeffs{end} , w ))

% figure; plot(corrCoeffs); 


%% Test 3: Change modesq argument
modesq = [1:10, 20:10:nModes];
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data, s.evecs, 'matrix', modesq);

assert(all( size(corrCoeffs) == [length(modesq), nData]         ))
assert(all( size(recon)      == [nVerts, length(modesq), nData] ))
assert(all( size(betaCoeffs) == [length(modesq), 1]             ))

% figure; plot(modesq, corrCoeffs); xticks(modesq); 


%% Test 4: Orthogonal method and different modesq argument
modesq = [1:10, 20:10:(nModes-1), nModes];
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data, s.evecs, 'orthogonal', modesq, s);

assert(all( size(corrCoeffs) == [length(modesq), nData]         ))
assert(all( size(recon)      == [nVerts, length(modesq), nData] ))
assert(all( size(betaCoeffs) == [length(modesq), 1]             ))

assert(allclose( betaCoeffs{end}, w(1:max(modesq),:) ))

% figure; plot(modesq, corrCoeffs); xticks(modesq); 


%% Test 5: Test FC reconstruction
%%% User inputs incl. Square mesh surface 
[v,f] = squareMesh3(10);
s = struct('vertices', v, 'faces', f);
nVerts = height(s.vertices);
nModes = nVerts; nData = 10; % get full basis
modesq = [1:10, 20:10:(nModes-1), nModes];

%%% Calc modes and other parameters
s = calc_geometric_eigenmode(s, nModes);

ts = sinpi((1:nData)/nData*2) + rand(nVerts, nData); % dummy timeseries
fcEmpirical = corr(ts', ts'); 

%%% calc FC correlation
[~,recon,~, fcCorr, fcRecon] = calc_eigenreconstruction(ts, s.evecs, 'matrix', modesq);

assert(allclose( fcCorr(end) , 1  ))
assert(allclose( fcRecon(:,:,end) , fcEmpirical  ))
assert(allclose( ts, squeeze(recon(:,end,:)) ))

%%% visualisations
figuremax; tl = multiplot(1:length(modesq), @(x) imagescmg(squeeze(recon(:,x,:))), @(x) title("n="+modesq(x))); 
    nexttile; imagescmg(ts); title(sprintf('Target: Timeseries data across %i timepoints', nData));
    title(tl, 'Reconstructions at each timepoint with n Modes');  
figuremax; tl = multiplot(fcRecon, @imagescfc, 'dim', 3); tlfunc(tl, @(ax,ii) title(ax, "n="+modesq(ii)), 'axindex')
    nexttile; imagescfc(fcEmpirical); title('Target: Empirical FC');    
    title(tl, 'Reconstructions of FC using n modes'); 

