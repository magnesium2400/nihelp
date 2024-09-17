function [corrCoeffs,recon,betaCoeffs,fcCorr,fcRecon] = ...
    calc_eigenreconstruction(data,eigenvectors,method,modesq,params)
% calc_eigenreconstruction.m
%
% Reconstruct data using eigenvectors and calculate the coefficient of
% contribution of each vector
%
% Inputs: data         : data [MxP]
%                        M = number of points, P = number of independent data
%         eigenvectors : eigenvectors [MxN]
%                        M = number of points, N = number of eigenvectors
%         method       : type of calculation
%                        'matrix', 'matrix_separate', 'regression'
%         modesq       : modes to query to get reconstruction [1xQ]
%                        Q = number of sample points (1:N by default)
%         params       : further data required for decomposition
%                        for the 'orthogonal' method, this should be the mass matrix (M) or a struct with a field 'mass'  
% Output: corrCoeffs   : correlation coefficient values [QxP]
%         recon        : reconstructions using 1..N modes [MxQxP]
%         betaCoeffs   : coefficient values {Qx1}
%         fcCorr       : treating `data` as spanning P timepoints, reconstruct FC and calculate corr coeff between original and new FC matrices [Qx1]
%         fcRecon      : reconstructions of FC using 1..N modes [MxMxQ]
%
% Original: Mehul Gajwani & Victor Barnes, Monash University, 2024


%% Prelims
if isa(eigenvectors, 'struct'); eigenvectors = eigenvectors.evecs; end
if nargin < 3 || isempty(method); method = 'matrix'; end
if nargin < 4 || isempty(modesq); modesq = 1:size(eigenvectors, 2); end
if nargin < 5; params = []; end

assert(size(data,1) == size(eigenvectors, 1));
[M,P] = size(data);
nq = length(modesq);

recon = nan(M,nq,P);
corrCoeffs = nan(nq,P);
betaCoeffs = cell(nq,1);

if nargout >= 4
    tril2vec = @(A,k) reshape(A(tril(true(size(A)), k)), [], 1);
    fcOrigAtanh = atanh(tril2vec(corr(data.'),-1));
    fcCorr = nan(nq,1);
    if nargout >= 5; fcRecon = nan(M,M,nq); end
end


%% Calculations
if strcmp(method, 'orthogonal') % can get coeffs together if using ortho method
    tmp = calc_eigendecomposition(data, eigenvectors(:,1:max(modesq(:))), method, params);
    betaCoeffs = arrayfun(@(mq) tmp(1:mq,:), modesq(:), 'Uni', 0); 
end

for n = 1:nq

    % get recons
    if ~strcmp(method, 'orthogonal')
        betaCoeffs{n} = calc_eigendecomposition(data, eigenvectors(:,1:modesq(n)), method, params);       
    end
    recon(:,n,:) = eigenvectors(:,1:modesq(n))*betaCoeffs{n};

    % get correlations
    corrCoeffs(n,:) = arrayfun(@(ii) corr( data(:,ii), recon(:,n,ii)) ,1:size(data,2));

    % do FC calculations if requested
    if nargout >= 4
        tmp = corr(squeeze(recon(:,n,:)).');
        fcCorr(n) = corr( fcOrigAtanh , atanh(tril2vec(tmp,-1)) );
        if nargout >= 5; fcRecon(:,:,n) = tmp; end
        % clear tmp;
    end

end

% if the first column of `eigenvectors` is constant, then the first row of
% `corrCoeffs` may be NaNs
assert(~any(isnan(corrCoeffs(2:end,:)), 'all'));
assert(~any(isnan(recon), 'all'));


end


