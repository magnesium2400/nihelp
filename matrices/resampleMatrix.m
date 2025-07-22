function spatialNoise = resampleMatrix(template, varargin)
%% RESAMPLEMATRIX Generates a matrix of noise in the same pattern as a template
%% Examples
%   resampleMatrix(magic(4))
%   t = magic(20); n = resampleMatrix(t); figure; scatter(t(:),n(:));
%   t = magic(10).*(magic(10)>50); n = resampleMatrix(t); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
%   t = magic(10).*(magic(10)>50); n = resampleMatrix(t,'randParams',[0.5 0.1]); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
%   t = log(pascal(15)).*(pascal(15)<500); n = resampleMatrix(t,'uniform','seed',314159,'randParams',[1,10],'resymmetrise',1,'ignoreRepeats',1,'resetZeros',1); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
%   t = log(pascal(15)).*(pascal(15)<500); n = resampleMatrix(t,'uniform','seed',314159,'randParams',[-1,1],'resymmetrise',0,'ignoreRepeats',0,'resetZeros',0); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
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

% TODO : consider adding support for upper/lower triangles of template (if input
% as a matrix)


%% Prelims
ip = inputParser;
addRequired(ip, 'template', @isnumeric);
noiseValidFn = @(x) isnumeric(x) || contains(x, ["gaussian", "normal", "uniform", "integers"]);
addOptional(ip, 'noise', 'gaussian', noiseValidFn);

addParameter(ip, 'seed', []);
addParameter(ip, 'randParams', [0 1]);
addParameter(ip, 'ignoreRepeats', true);
addParameter(ip, 'resetZeros', true);
addParameter(ip, 'resymmetrise', true);

parse(ip, template, varargin{:});
template            = ip.Results.template;
noise               = ip.Results.noise;
seed                = ip.Results.seed;
alpha               = ip.Results.randParams(1); % mean or min of rand distribution
beta                = ip.Results.randParams(2); % SD   or max of rand distribution
ignoreRepeats       = ip.Results.ignoreRepeats; if strcmp(ignoreRepeats, 'false'); ignoreRepeats = false; end

if ~isempty(seed); rng(seed); end % set seed if specified by user


%% Make noise
% generate noise --> into the variable sortedNoise

if ignoreRepeats;   [u,~,uc] = unique(template); nRand = length(u);
else;               nRand = numel(template); end


if isnumeric(noise) % user has input their own noise
    assert(numel(noise) == nRand, ...
        "Noise should contain the same number of elements as input map");
    sortedNoise = sort(noise(:));
else
    switch noise
        case {'gaussian', 'normal'} % generate noise with specified mean and SD
            sortedNoise = sort( randn(nRand, 1)*beta + alpha );
        case {'uniform'} % generate noise with specified max and min
            sortedNoise = sort( rand(nRand, 1)*(beta-alpha) + alpha );
        case {'integers'}
            sortedNoise = sort( randi([alpha, beta], nRand, 1) );
            
        otherwise
            error("Noise input not valid");
    end
end


%% Organise noise
if ~ignoreRepeats
    [~, idx] = sort(template(:)); % get the spatial pattern of the template map
    spatialNoise(idx) = sortedNoise; % order the noise according to the spatial pattern
    spatialNoise = reshape(spatialNoise, size(template)); % make it the correct shape
else
    spatialNoise = sortedNoise(uc);
    spatialNoise = reshape(spatialNoise, size(template));
end

if ip.Results.resymmetrise && issymmetric(template) % resymmetrise if original is symmetric
    spatialNoise = triu(spatialNoise) + triu(spatialNoise)' - diag(diag(spatialNoise)); 
end
if ip.Results.resetZeros; spatialNoise(~template) = 0; end


end